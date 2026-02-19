setup:
	ansible-galaxy collection install kewlfft.aur
	ansible-galaxy collection install community.docker

all01:
	ansible-playbook -i ./hosts/site01.yaml -i conf ./services/all.yaml --vault-password-file ~/ansible/.vault_pass

bastion01:
	ansible-playbook -i ./hosts/site01.yaml -i conf ./services/bastion.yaml --vault-password-file ~/ansible/.vault_pass

bastion01p:
	ansible-playbook -i ./hosts/site01-private.yaml -i conf ./services/bastion.yaml --vault-password-file ~/ansible/.vault_pass

dns01:
	ansible-playbook -i ./hosts/site01.yaml -i conf ./services/dns.yaml --vault-password-file ~/ansible/.vault_pass

kubernetes01:
	ansible-playbook -i ./hosts/site01.yaml -i conf ./services/kubernetes.yaml --vault-password-file ~/ansible/.vault_pass

worker01p:
	ansible-playbook -i ./hosts/site01-private.yaml -i conf ./services/worker.yaml --vault-password-file ~/ansible/.vault_pass

all02:
	ansible-playbook -i ./hosts/site02.yaml -i conf ./services/all.yaml --vault-password-file ~/ansible/.vault_pass

bastion02:
	ansible-playbook -i ./hosts/site02.yaml -i conf ./services/bastion.yaml --vault-password-file ~/ansible/.vault_pass

dns02:
	ansible-playbook -i ./hosts/site02.yaml -i conf ./services/dns.yaml --vault-password-file ~/ansible/.vault_pass

kubernetes02:
	ansible-playbook -i ./hosts/site02.yaml -i conf ./services/kubernetes.yaml --vault-password-file ~/ansible/.vault_pass

all01p:
	ansible-playbook -i ./hosts/site01-private.yaml -i conf ./services/all.yaml --vault-password-file ~/ansible/.vault_pass

llm01p:
	ansible-playbook -i ./hosts/site01-private.yaml -i conf ./services/llm.yaml --vault-password-file ~/ansible/.vault_pass

all02p:
	ansible-playbook -i ./hosts/site02-private.yaml -i conf ./services/all.yaml --vault-password-file ~/ansible/.vault_pass

bastion02p:
	ansible-playbook -i ./hosts/site02-private.yaml -i conf ./services/bastion.yaml --vault-password-file ~/ansible/.vault_pass

dns02p:
	ansible-playbook -i ./hosts/site02-private.yaml -i conf ./services/dns.yaml --vault-password-file ~/ansible/.vault_pass

