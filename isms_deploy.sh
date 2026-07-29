#!/bin/bash
set -e

ISMS_DIR="$HOME/.isms"
ISMS_URL="https://raw.githubusercontent.com/DogsbodyOps/isms/refs/heads/main/isms"

mkdir -p "$ISMS_DIR"

# Write the daily-refresh helper into ~/.isms so bashrc just sources it
cat > "$ISMS_DIR/refresh.sh" <<EOF
#!/bin/bash
# Refresh isms fortunes at most once per day (user-space, no sudo)
_isms_refresh() {
    local dir="\$HOME/.isms"
    local stamp="\$dir/.last"
    local today
    today=\$(date +%Y-%m-%d)
    [ "\$(cat "\$stamp" 2>/dev/null)" = "\$today" ] && return
    if curl -fsSL "$ISMS_URL" -o "\$dir/isms.new" 2>/dev/null; then
        mv "\$dir/isms.new" "\$dir/isms"
        strfile "\$dir/isms" >/dev/null 2>&1
        echo "\$today" > "\$stamp"
    fi
    rm -f "\$dir/isms.new"
}
EOF
chmod +x "$ISMS_DIR/refresh.sh"

# Initial download so the first shell has something to show
curl -fsSL "$ISMS_URL" -o "$ISMS_DIR/isms"
strfile "$ISMS_DIR/isms" >/dev/null 2>&1

# Wire up .bashrc (idempotent)
if ! grep -qF '# --- isms fortunes ---' "$HOME/.bashrc"; then
cat >> "$HOME/.bashrc" <<'EOF'

# --- isms fortunes ---
if [ -f "$HOME/.isms/refresh.sh" ]; then
    source "$HOME/.isms/refresh.sh"
    ( _isms_refresh & ) 2>/dev/null
    fortune "$HOME/.isms/isms" 2>/dev/null | cowsay
fi
# --- end isms ---
EOF
fi

echo "Installed. Open a new shell or run: source ~/.bashrc"
