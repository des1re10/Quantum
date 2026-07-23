#!/bin/bash
#
# Quantum - Local Development Server
# Quick start script for testing the website locally
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PAPERS_DIR="$SCRIPT_DIR/papers/zkprivacy"
LIBRARIES_PYTHON="$(cd "$SCRIPT_DIR/../Libraries/Python" && pwd)"
DEFAULT_PORT="9180"
PORT="${1:-}"

if [ -z "$PORT" ]; then
    REGISTRY_PORT="$(python3 - <<PY 2>/dev/null
import sys
sys.path.insert(0, r"$LIBRARIES_PYTHON")
from ApplicationRegistry import get_application
config = get_application("quantum")
print(getattr(config, "local_preview_port", "") or "")
PY
)"
    if [[ "$REGISTRY_PORT" =~ ^[0-9]+$ ]]; then
        PORT="$REGISTRY_PORT"
    else
        PORT="$DEFAULT_PORT"
    fi
fi

cd "$SCRIPT_DIR"

echo "================================================"
echo "  Quantum - Post-Quantum Cryptography Research"
echo "  Local Development Server"
echo "================================================"
echo ""

# Function to check if PDF needs rebuild
needs_rebuild() {
    local md_file="$1"
    local pdf_file="$2"

    # PDF doesn't exist
    if [ ! -f "$pdf_file" ]; then
        return 0
    fi

    # MD is newer than PDF
    if [ "$md_file" -nt "$pdf_file" ]; then
        return 0
    fi

    return 1
}

# Check if PDFs need to be built
REBUILD_NEEDED=false

shopt -s nullglob
PAPER_SOURCES=("$PAPERS_DIR"/*.md)

if [ "${#PAPER_SOURCES[@]}" -eq 0 ]; then
    echo "ERROR: No active Markdown papers found in: $PAPERS_DIR"
    exit 1
fi

for paper_source in "${PAPER_SOURCES[@]}"; do
    if needs_rebuild "$paper_source" "${paper_source%.md}.pdf"; then
        REBUILD_NEEDED=true
        break
    fi
done

# Auto-generate PDFs if needed
if [ "$REBUILD_NEEDED" = true ]; then
    echo "PDFs missing or outdated. Building automatically..."
    echo ""

    if [ ! -x "$SCRIPT_DIR/build-pdfs.sh" ]; then
        echo "ERROR: Executable PDF build script not found at: $SCRIPT_DIR/build-pdfs.sh"
        exit 1
    fi

    if ! "$SCRIPT_DIR/build-pdfs.sh"; then
        echo ""
        echo "ERROR: PDF generation failed; local preview was not started"
        exit 1
    fi

    echo ""
else
    echo "PDFs are up to date."
    echo ""
fi

# Start Python HTTP server
echo "Starting local web server..."
echo "URL: http://localhost:$PORT"
echo "Press Ctrl+C to stop"
echo ""

python3 -m http.server "$PORT"
