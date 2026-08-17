# Hexis installer — https://quixi.ai/hexis.sh
#
# Usage:  curl -LsSf https://quixi.ai/hexis.sh | sh
#
# Installs the Hexis CLI (https://github.com/QuixiAI/Hexis) into an isolated
# environment via uv, bootstrapping uv first if it isn't installed. Safe to
# re-run: an existing install is upgraded to the latest release.
#
# Environment respected: UV_INSTALL_DIR, UV_TOOL_DIR, UV_TOOL_BIN_DIR, XDG_BIN_HOME

set -u

say() { printf '%s\n' "$*"; }
fail() {
    say ""
    say "error: $1"
    say "  fix: $2"
    exit 1
}

say "Hexis installer"
say ""

# --- Platform check ------------------------------------------------------
case "$(uname -s)" in
    Darwin|Linux) ;;
    MINGW*|MSYS*|CYGWIN*)
        fail "native Windows shells are not supported" \
             "install WSL2 (https://learn.microsoft.com/windows/wsl/install) and run this inside your WSL2 distro" ;;
    *)
        fail "unsupported platform: $(uname -s)" \
             "Hexis runs on macOS, Linux, and Windows via WSL2" ;;
esac

command -v curl >/dev/null 2>&1 || \
    fail "curl is required" "install curl with your package manager and re-run"

# --- Ensure uv -----------------------------------------------------------
if command -v uv >/dev/null 2>&1; then
    UV=uv
else
    say "uv not found — installing it first (https://docs.astral.sh/uv/) ..."
    curl -LsSf https://astral.sh/uv/install.sh | sh || \
        fail "the uv installer failed" "see its output above; or install uv yourself (brew install uv) and re-run"

    # The installer puts uv on PATH for *new* shells; find it for this one.
    UV=""
    for candidate in \
        "${UV_INSTALL_DIR:-}/uv" \
        "${XDG_BIN_HOME:-}/uv" \
        "$HOME/.local/bin/uv"
    do
        if [ -x "$candidate" ]; then
            UV=$candidate
            break
        fi
    done
    if [ -z "$UV" ] && command -v uv >/dev/null 2>&1; then
        UV=uv
    fi
    [ -n "$UV" ] || fail "uv was installed but could not be located" \
        "open a new terminal and run: uv tool install hexis"
    say ""
fi

# --- Install / upgrade hexis --------------------------------------------
# Pin the interpreter to 3.12 — the same Python the Hexis Docker images run on.
say "Installing Hexis with: $UV tool install --upgrade --python 3.12 hexis"
"$UV" tool install --upgrade --python 3.12 hexis || \
    fail "uv could not install hexis" "see the output above, then re-run this script"
say ""

# --- Make sure it's on PATH ---------------------------------------------
BIN_DIR=$("$UV" tool dir --bin 2>/dev/null || printf '%s' "$HOME/.local/bin")
if command -v hexis >/dev/null 2>&1; then
    say "Installed: $(hexis --version)"
else
    "$UV" tool update-shell >/dev/null 2>&1 || true
    say "Installed: $("$BIN_DIR/hexis" --version 2>/dev/null || printf 'hexis')"
    say ""
    say "Note: $BIN_DIR is not on this shell's PATH yet."
    say "  Open a new terminal, or run now:  export PATH=\"$BIN_DIR:\$PATH\""
fi

# --- Advisory environment checks (never block) ---------------------------
if ! command -v docker >/dev/null 2>&1; then
    say ""
    say "Heads up: Docker is not installed. Hexis needs it to run the agent's brain."
    say "  Install Docker Desktop: https://docs.docker.com/get-docker/"
elif ! docker info >/dev/null 2>&1; then
    say ""
    say "Heads up: Docker is installed but not running. Start Docker Desktop before 'hexis init'."
fi

say ""
say "Next steps:"
say "  hexis init      # set up your agent (starts services, runs consent)"
say "  hexis chat      # talk to it"
say ""
say "Docs: https://github.com/QuixiAI/Hexis#quick-start"
