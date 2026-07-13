# isms

A small fortune file of team “isms” plus a quick install script that shows one at shell startup.

## Quick deploy

```bash
curl -fsSL https://raw.githubusercontent.com/DogsbodyOps/isms/refs/heads/main/isms_deploy.sh | bash
```

The installer:
- creates `~/.isms`
- downloads the latest `isms` fortune file
- runs `strfile` to build the index
- appends a guarded block to `~/.bashrc` that refreshes daily and prints:

```bash
fortune "$HOME/.isms/isms" | cowsay
```

## Requirements

- `fortune`
- `strfile` (usually included with fortune packages)
- `cowsay`
- `curl`
- `bash`

## Updating the fortune file manually

When editing `/home/runner/work/isms/isms/isms`:

1. Keep `%` as the separator between entries.
2. Keep a trailing `%` at the end of the file.
3. Rebuild the index file:

   ```bash
   strfile -c % isms isms.dat
   ```

## Local usage (without deploy script)

```bash
fortune /home/runner/work/isms/isms/isms | cowsay
```
