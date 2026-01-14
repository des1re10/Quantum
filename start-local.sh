#!/bin/bash
#
# Quantum - Local Development Server
# Quick start script for testing the website locally
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PAPERS_DIR="$SCRIPT_DIR/papers/zkprivacy"

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

if needs_rebuild "$PAPERS_DIR/zkprivacy-quantum-spec-v1.md" "$PAPERS_DIR/zkprivacy-quantum-spec-v1.pdf"; then
    REBUILD_NEEDED=true
fi

if needs_rebuild "$PAPERS_DIR/zkprivacy-verification-guide.md" "$PAPERS_DIR/zkprivacy-verification-guide.pdf"; then
    REBUILD_NEEDED=true
fi

# Auto-generate PDFs if needed
if [ "$REBUILD_NEEDED" = true ]; then
    echo "PDFs missing or outdated. Building automatically..."
    echo ""

    if [ -f "$SCRIPT_DIR/build-pdfs.sh" ]; then
        "$SCRIPT_DIR/build-pdfs.sh"

        if [ $? -ne 0 ]; then
            echo ""
            echo "WARNING: PDF generation failed!"
            read -p "Continue without PDFs? (y/n) " -n 1 -r
            echo ""
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                exit 1
            fi
        fi
        echo ""
    else
        echo "WARNING: build-pdfs.sh not found!"
        read -p "Continue without PDFs? (y/n) " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
else
    echo "PDFs are up to date."
    echo ""
fi

# Start Python HTTP server
echo "Starting local web server..."
echo "URL: http://localhost:8080"
echo "Press Ctrl+C to stop"
echo ""

python3 -m http.server 8080
