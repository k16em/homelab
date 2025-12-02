#!/bin/bash

# 引数チェック
if [ $# -ne 4 ]; then
    echo $#
    echo "Usage: $0 <VMID> <VMNAME> <VMIPV4> <VMIPV4GW>"
    exit 1
fi

VMID="$1"
VMNAME="$2"
VMIPV4="$3"
VMIPV4GW="$4"

# 固定設定値
VMCORE=2
VMSTORAGESIZE=32G
VMMEMORY=4096
VMSWAP=0
VMSEARCHDOMAIN="home"
VMIMAGE=/var/lib/vz/images/Arch-Linux-x86_64-cloudimg.qcow2

# VM作成
# AMD Ryzen 5 PRO 4650GとAMD Ryzen 5 5600Gでしか実行してないのでその前提
qm create ${VMID} \
    --name "tkpve-${VMNAME}" \
    --cpu x86-64-v3 \
    --arch x86_64 \
    --cores ${VMCORE} \
    --sockets 1 \
    --memory "${VMMEMORY}" \
    --scsihw virtio-scsi-pci \
    --boot order=scsi0 \
    --agent 1 \
    --scsi0 "storage01:0,import-from=${VMIMAGE},format=qcow2,cache=writeback,discard=on" \
    --sata0 local-lvm:cloudinit \
    --cicustom "user=local:snippets/arch-vm-ci.yaml" \
    --serial0 socket \
    --net0 "virtio,bridge=vmbr0" \
    --ipconfig0 "ip=${VMIPV4},gw=${VMIPV4GW}" \
    --start 0 \
&& qm resize ${VMID} scsi0 ${VMSTORAGESIZE} \
&& qm set ${VMID} --onboot 1 \
&& qm start ${VMID}

