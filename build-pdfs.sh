#!/bin/bash
#
# Quantum - PDF Build Script
# Converts Markdown papers to PDF using DocWizard-Pro
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCWIZARD_DIR="$(dirname "$SCRIPT_DIR")/DocWizard-Pro/Src"
PAPERS_DIR="$SCRIPT_DIR/papers/zkprivacy"

echo "================================================"
echo "  Quantum - PDF Build Script"
echo "================================================"
echo ""

# Check if DocWizard-Pro exists
if [ ! -f "$DOCWIZARD_DIR/universal_converter.py" ]; then
    echo "ERROR: DocWizard-Pro not found at: $DOCWIZARD_DIR"
    echo "       Make sure DocWizard-Pro is in the same parent directory as Quantum"
    exit 1
fi

# Check if Pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "ERROR: Pandoc is not installed"
    echo "       Install from: https://pandoc.org/installing.html"
    exit 1
fi

echo "Building PDFs..."
echo ""

# Convert specification
echo "[1/2] Converting zkprivacy-quantum-spec-v1.md..."
python3 "$DOCWIZARD_DIR/universal_converter.py" \
    "$PAPERS_DIR/zkprivacy-quantum-spec-v1.md" \
    "$PAPERS_DIR/zkprivacy-quantum-spec-v1.pdf"

if [ $? -eq 0 ]; then
    echo "      Done: zkprivacy-quantum-spec-v1.pdf"
else
    echo "      FAILED: zkprivacy-quantum-spec-v1.pdf"
    exit 1
fi

# Convert verification guide
echo "[2/2] Converting zkprivacy-verification-guide.md..."
python3 "$DOCWIZARD_DIR/universal_converter.py" \
    "$PAPERS_DIR/zkprivacy-verification-guide.md" \
    "$PAPERS_DIR/zkprivacy-verification-guide.pdf"

if [ $? -eq 0 ]; then
    echo "      Done: zkprivacy-verification-guide.pdf"
else
    echo "      FAILED: zkprivacy-verification-guide.pdf"
    exit 1
fi

echo ""
echo "================================================"
echo "  Build complete!"
echo "  PDFs generated in: $PAPERS_DIR"
echo "================================================"
