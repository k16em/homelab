# Ansible Design and Implementation

- Inspect existing roles, variables, and playbooks before making changes, and follow their design. Do not introduce standalone services or implementations solely for one-off requests.
- Do not manage the same configuration in multiple places. When extracting shared functionality, move the existing definitions and tasks, and update existing callers to use the shared implementation.
- Treat the Homelab repository as the source of truth for configuration. Do not import existing host configuration or introduce includes or additional files to preserve it without explicit approval.
- Do not leave temporary migration or cleanup tasks in permanent roles. Run them separately or temporarily, and remove them after completion.
- Proxmox hosts are listed in the inventory for reference only. Do not consider them during design, implementation, or testing.
- Use Vault for secrets. Do not encrypt non-secret configuration, such as connection destinations or private-key paths, without a specific reason.
- Apply Ansible changes to Ansible-managed hosts using the actual code in the repository. When only part of the configuration needs to be applied, define tags and use them to select the relevant tasks.
- Localhost is not an Ansible-managed host. To reflect shared OpenCode settings locally, update the role's source files first, then copy them to the local global configuration using `cp`. Do not run Ansible against localhost for this purpose.

## Coding and Commit Guidelines

- Express **How** in implementation code: how the behavior is achieved.
- Express **What** in test code: what behavior is expected.
- Explain **Why** in commit messages: why the change is needed.
- Explain **Why not** in commit messages and Pull Request descriptions: why a plausible alternative was not chosen.
