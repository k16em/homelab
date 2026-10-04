## Response Rules
- Always respond in Japanese unless the user explicitly specifies otherwise.

## Terminology
- Prefer original English IT terminology over unnatural Japanese translations.
- Keep proper nouns in their original-language form.
- Describe effects and outcomes concretely using wording equivalent to "applied", "reflected", or "affects", rather than vague phrasing.

## Tooling rules for OpenCode V2
- Treat the tools and schemas advertised in the current request as the source of truth. Available tools can vary by model, permissions, and runtime.
- Use only advertised tools with their exact names and parameter schemas. Never invent a tool name, namespace, alias, or parameter.
- Do not prepend `tool.` or another namespace unless that exact qualified name is advertised.
- In OpenCode V2, the command execution tool is `shell` and the child-agent tool is `subagent`. Use them only when advertised; do not substitute legacy names such as `bash` or `task`.
- Do not assume `list`, `todowrite`, `todoread`, or `Repo_browser.*` exist. Use advertised discovery tools such as `read`, `glob`, and `grep` when available.
- Prefer `edit` for focused changes to existing files when available. Inspect files with `read` before modifying them, and use `write` for new files or intentional complete replacements.
- When a tool is exposed only through Code Mode, use `execute` and the exact callable path and schema from its catalog. Do not call catalog-only tools directly or assume directly exposed tools are also in the catalog.
- Await calls whose completion matters. Use background execution only for independent work and rely on completion notifications rather than polling.
- If a call fails because the tool is unknown, unavailable, or not a function, do not retry the same call or guess alternative names. Recheck the advertised tools and catalog, then use a verified available tool or stop and explain the limitation.
- Do not retry an unchanged failing call indefinitely. For timeouts or other execution failures, inspect the error and available diagnostics before deciding whether a corrected retry is appropriate.

## Code comments
- Do NOT write comments in code. This applies to every file: YAML, Jinja templates, config files, scripts.
- Explain non-obvious decisions in the commit message and the pull request description instead.
- Markdown headings are not comments.

## Privacy and placeholders
- Do NOT write real email addresses.
- Do NOT write real domains.
- If a domain or email address is absolutely necessary, use the `example.com` domain.

## Committing
- Do NOT commit untracked files. Anything `git status` shows as `??` stays out of the commit, even if you created it yourself, unless you are explicitly told to include it.
- Do NOT use `git add -A`, `git add .`, or `git add <directory>`. Name the changed paths explicitly; use `git add -A -- <explicit paths>` when the change includes deletions or renames.
- Run `git status --short` before committing and confirm the `??` entries are still listed.
- End the commit message with a co-author line, no email address:
  - `Co-Authored-By: {Model Name} with {tool}`
  - e.g. `Co-Authored-By: Qwen3.8-27B-UD-Q8_K_XL with OpenCode`
  - Exception: Claude Code and Codex ignore this rule and follow their own default co-author line convention.
