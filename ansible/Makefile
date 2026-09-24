setup:
	ansible-galaxy collection install --requirements-file requirements.yml

all01:
	ansible-playbook -i ./hosts/site01.yaml ./services/all.yaml --vault-password-file ~/ansible/.vault_pass

cache01:
	ansible-playbook -i ./hosts/site01.yaml ./services/cache.yaml --vault-password-file ~/ansible/.vault_pass

bastion01:
	ansible-playbook -i ./hosts/site01.yaml ./services/bastion.yaml --vault-password-file ~/ansible/.vault_pass

bastion01p:
	ansible-playbook -i ./hosts/site01-private.yaml ./services/bastion.yaml --vault-password-file ~/ansible/.vault_pass

dns01:
	ansible-playbook -i ./hosts/site01.yaml ./services/dns.yaml --vault-password-file ~/ansible/.vault_pass

worker01p:
	ansible-playbook -i ./hosts/site01-private.yaml ./services/worker.yaml --vault-password-file ~/ansible/.vault_pass

hermes01p:
	ansible-playbook -i ./hosts/site01-private.yaml ./services/hermes.yaml --vault-password-file ~/ansible/.vault_pass

search01p:
	ansible-playbook -i ./hosts/site01-private.yaml ./services/search.yaml --vault-password-file ~/ansible/.vault_pass

memory01p:
	ansible-playbook -i ./hosts/site01-private.yaml ./services/memory.yaml --vault-password-file ~/ansible/.vault_pass

kubernetes01p:
	ansible-playbook -i ./hosts/site01-private.yaml ./services/kubernetes.yaml --vault-password-file ~/ansible/.vault_pass

all02:
	ansible-playbook -i ./hosts/site02.yaml ./services/all.yaml --vault-password-file ~/ansible/.vault_pass

cache02:
	ansible-playbook -i ./hosts/site02-private.yaml ./services/cache.yaml --vault-password-file ~/ansible/.vault_pass

bastion02:
	ansible-playbook -i ./hosts/site02.yaml ./services/bastion.yaml --vault-password-file ~/ansible/.vault_pass

dns02:
	ansible-playbook -i ./hosts/site02.yaml ./services/dns.yaml --vault-password-file ~/ansible/.vault_pass

all01p:
	ansible-playbook -i ./hosts/site01-private.yaml ./services/all.yaml --vault-password-file ~/ansible/.vault_pass

llm01p:
	ansible-playbook -i ./hosts/site01-private.yaml ./services/llm.yaml --vault-password-file ~/ansible/.vault_pass

all02p:
	ansible-playbook -i ./hosts/site02-private.yaml ./services/all.yaml --vault-password-file ~/ansible/.vault_pass

bastion02p:
	ansible-playbook -i ./hosts/site02-private.yaml ./services/bastion.yaml --vault-password-file ~/ansible/.vault_pass

dns02p:
	ansible-playbook -i ./hosts/site02-private.yaml ./services/dns.yaml --vault-password-file ~/ansible/.vault_pass
