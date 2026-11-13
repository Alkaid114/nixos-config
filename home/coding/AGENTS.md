## Communication

- User-facing messages: say only new, actionable information, then stop. Keep internal monologue out.
- Assume high domain expertise. Do not teach basics or repeat context, domain knowledge, or things inferable from the conversation.
- Prefer showing code, pseudocode, or a graph over explaining. Do not re-explain what was shown.
- No disclaimers, summaries, or closing pleasantries.
- Use plain language. Avoid system-prompt style, jargon, and rare words.

## Environment and Nix

- Never run `nix profile` subcommands that modify the user profile. Keep the global environment clean. Do not modify system-level or user-level global environment without explicit consent.
- `/tmp` is tmpfs. Do not store persistent data there. Temporary files may go in `/tmp/opencode`; persistent data must go under `/home` or another persistent partition.
- This system is NixOS. Do not assume global tools exist. Check with `command -v`; if missing, use `nix shell nixpkgs#<package> -c <command>` or `nix-shell -p <package> --run '<command>'`. Do not install globally.
- Before adding or using a Nix package, check binary cache availability with `nix-build --dry-run`, `nix path-info --store https://cache.nixos.org`, or equivalent. If a source build is needed, state which packages, why, and the estimated time, then wait for consent. Stop immediately if an unexpected local compile starts.

## Python

- Use global `uv` at `~/.nix-profile/bin/uv`. Do not call `python` or `pip` directly. Do not manually create virtual environments outside a project.
- For PyTorch, use `uv add torch`. The PyPI Linux wheel bundles CUDA. Do not specify custom indexes, `+cuXXX` versions, or extra CUDA sources.

## File Reading and Command Output

- Read files with the `read` tool, not `cat`/`sed`/`awk`. Edit files with the `edit` tool, not `sed -i`/`awk`.
- Do not trim command output yourself, whether with `head`, `tail`, `sed -n`, `awk 'NR==...'`, or similar. Tools handle large output natively; short output is returned in full, long output keeps head and tail.
- `cat` is fine for heredoc file creation, piping into another command, or very small system files. Avoid long heredoc content because truncation can leave the shell waiting for the delimiter.
- `sed`/`awk` are fine for pure in-stream transformation, e.g. `cmd | sed 's/foo/bar/'`, when no dedicated tool fits.

## Command Execution

- Do not use `cd ... && command`. Use the bash tool's `workdir` parameter instead.

## Formatting

- No decorative separator blocks made of many `-` or `=` characters. Use blank lines or short headings.
- No numeric list prefixes in comments. No emoji unless explicitly requested.
