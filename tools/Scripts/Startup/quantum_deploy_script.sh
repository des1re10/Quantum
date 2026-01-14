#!/bin/bash

# ============================================================================
# Quantum - Server Deployment Script
# ============================================================================
# Deploys static documentation website from pCloud to web server
# Uses shared deployment infrastructure for consistency with other projects
#
# Usage: ./quantum_deploy_script.sh
# ============================================================================

# Fix own line endings first (handles Windows CRLF -> Unix LF)
# IMPORTANT: Properly resolve symlinks to avoid overwriting shortcuts in ~/Desktop/Run scripts/
SCRIPT_PATH="${BASH_SOURCE[0]}"
if [ -L "$SCRIPT_PATH" ]; then
    # Script is being run via symlink - resolve to actual file
    SCRIPT_REAL_PATH=$(readlink -f "$SCRIPT_PATH" 2>/dev/null)
    if [ -z "$SCRIPT_REAL_PATH" ] || [ ! -f "$SCRIPT_REAL_PATH" ]; then
        # Could not resolve symlink - skip sed to avoid destroying the symlink
        echo "Note: Running via symlink, skipping CRLF fix on script itself"
    else
        sed -i 's/\r$//' "$SCRIPT_REAL_PATH" 2>/dev/null || true
    fi
else
    # Not a symlink, safe to modify directly
    sed -i 's/\r$//' "$SCRIPT_PATH" 2>/dev/null || true
fi

# Ensure all messages and errors are displayed (with function error propagation)
set -eE

# Error handler function - shows detailed error info
function error_handler() {
    local exit_code=$?
    local line_number=${BASH_LINENO[0]}
    local command="${BASH_COMMAND}"

    echo ""
    echo "=================================================================="
    echo "[ERROR] Script failed at line $line_number"
    echo "[ERROR] Exit code: $exit_code"
    echo "[ERROR] Failed command: $command"
    echo "=================================================================="
    echo ""

    # Skip waiting for input in AUTO_DEPLOY mode
    if [ "$AUTO_DEPLOY" == "1" ]; then
        echo "[AUTO_DEPLOY] Error occurred - continuing without waiting for input"
        return
    fi
    echo "Press Enter to close the terminal..."
    read
}

# Ensure the function is called on error
trap error_handler ERR

# Determine the system type
SYSTEM=$(uname -s)

# Set path variables for different systems
if [[ "$SYSTEM" == "Linux" ]]; then
    if grep -q "microsoft" /proc/version; then
        # WSL - not supported for deployment
        echo "ERROR: This script must run on the Linux server, not WSL"
        exit 1
    else
        # Linux server - pCloud mounted
        SOURCE_BASE="$HOME/pCloudDrive/Crypto Folder/Quantum Sources/Quantum"
        HOME_BASE="$HOME"
    fi
elif [[ "$SYSTEM" == "Darwin" ]]; then
    # Mac path
    SOURCE_BASE="$HOME/pCloudDrive/Crypto Folder/Quantum Sources/Quantum"
    HOME_BASE="$HOME"
else
    echo "Unsupported system type: $SYSTEM"
    exit 1
fi

echo "================================================"
echo "  Quantum - Server Deployment"
echo "================================================"
echo ""
echo "Source directory: $SOURCE_BASE"

# Shared deployment script location
# Check multiple locations in priority order:
#   0. LOCAL_DEPLOY_SCRIPTS_DIR - set by deploy_all_from_cloud.sh (local copies, avoids pCloud FUSE issues)
#   1. Deployed Libraries folder (sibling to project folder)
#   2. Same directory as script
#   3. pCloud Libraries - for manual execution from cloud
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
DEPLOYED_LIBS_DIR="$(dirname "$(dirname "$(dirname "$(dirname "$SCRIPT_DIR")")")")/Libraries/Scripts"

LIBRARIES_DEPLOY_SCRIPT=""
LIBRARIES_FUNCTIONS_SCRIPT=""

for SEARCH_DIR in "${LOCAL_DEPLOY_SCRIPTS_DIR:-}" "$DEPLOYED_LIBS_DIR" "$SCRIPT_DIR" "$HOME/pCloudDrive/Crypto Folder/Quantum Sources/Libraries/Scripts"; do
    [ -z "$SEARCH_DIR" ] && continue
    if [ -f "$SEARCH_DIR/deploy_common.sh" ]; then
        LIBRARIES_DEPLOY_SCRIPT="$SEARCH_DIR/deploy_common.sh"
        LIBRARIES_FUNCTIONS_SCRIPT="$SEARCH_DIR/deploy_functions.sh"
        break
    fi
done

# Check if shared deployment script exists
if [ -z "$LIBRARIES_DEPLOY_SCRIPT" ] || [ ! -f "$LIBRARIES_DEPLOY_SCRIPT" ]; then
    echo "ERROR: Shared deployment script not found!"
    echo "Searched locations:"
    echo "  0. Local deploy dir: ${LOCAL_DEPLOY_SCRIPTS_DIR:-not set}/deploy_common.sh"
    echo "  1. Deployed Libraries: $DEPLOYED_LIBS_DIR/deploy_common.sh"
    echo "  2. Script directory: $SCRIPT_DIR/deploy_common.sh"
    echo "  3. pCloud Libraries: $HOME/pCloudDrive/Crypto Folder/Quantum Sources/Libraries/Scripts/deploy_common.sh"
    echo "Please ensure deploy_common.sh is in one of these locations"
    keep_terminal_open
    exit 1
fi

# Make sure the shared scripts are executable
chmod +x "$LIBRARIES_DEPLOY_SCRIPT"

# Source shared functions (required - no fallbacks)
if [ ! -f "$LIBRARIES_FUNCTIONS_SCRIPT" ]; then
    echo "ERROR: Shared functions script not found!"
    echo "Expected location: $LIBRARIES_FUNCTIONS_SCRIPT"
    keep_terminal_open
    exit 1
fi
chmod +x "$LIBRARIES_FUNCTIONS_SCRIPT"
sed -i 's/\r$//' "$LIBRARIES_FUNCTIONS_SCRIPT" 2>/dev/null || true
source "$LIBRARIES_FUNCTIONS_SCRIPT"
echo "Using shared deployment functions"

# Ask for the deployment target (or use AUTO_DEPLOY_SERVER)
if [ "$AUTO_DEPLOY" == "1" ]; then
    DEPLOY_TARGET="${AUTO_DEPLOY_SERVER:-main}"
    echo "[AUTO_DEPLOY] Deployment target: $DEPLOY_TARGET"
else
    while true; do
        echo "Do you want to deploy to the test server or the main server? (test/main)"
        read DEPLOY_TARGET

        if [ "$DEPLOY_TARGET" == "main" ] || [ "$DEPLOY_TARGET" == "test" ]; then
            break
        else
            echo "Invalid input. Please enter 'test' or 'main'."
        fi
    done
fi

# Set paths based on deployment target
if [ "$DEPLOY_TARGET" == "main" ]; then
    TARGET_DIR="$HOME_BASE/Quantum/Quantum"
    TARGET_LIBRARIES="$HOME_BASE/Quantum/Libraries"
    WEB_ROOT="/var/www/quantum"
    DOMAIN="quantum.phexora.ai"
    echo "Deploying to MAIN server: $WEB_ROOT"
else
    TARGET_DIR="$HOME_BASE/QuantumTest/Quantum"
    TARGET_LIBRARIES="$HOME_BASE/QuantumTest/Libraries"
    WEB_ROOT="/var/www/quantum-test"
    DOMAIN="test.quantum.phexora.ai"
    echo "Deploying to TEST server: $WEB_ROOT"
fi

# Source Libraries path (from pCloud - Libraries is at parent level, not inside Quantum)
SOURCE_LIBRARIES="$HOME/pCloudDrive/Crypto Folder/Quantum Sources/Libraries"

# Verify source directory exists
if [ ! -d "$SOURCE_BASE" ]; then
    echo "ERROR: Source directory not found!"
    echo "Expected: $SOURCE_BASE"
    echo ""
    echo "Please ensure:"
    echo "1. pCloud is running and mounted"
    echo "2. Files were synced from Windows (deploy_testing.bat)"
    keep_terminal_open
    exit 1
fi

# Check sudo availability
HAS_PASSWORDLESS_SUDO=0

if [ "$AUTO_DEPLOY" == "1" ]; then
    if [ "${HAS_SUDO_CACHED:-0}" == "1" ]; then
        if sudo -n true 2>/dev/null; then
            HAS_PASSWORDLESS_SUDO=1
            echo "[AUTO_DEPLOY] Using cached sudo credentials from parent script"
        else
            echo "[AUTO_DEPLOY] Cached sudo credentials expired"
        fi
    elif sudo -n true 2>/dev/null; then
        HAS_PASSWORDLESS_SUDO=1
        echo "[AUTO_DEPLOY] Passwordless sudo available"
    fi

    if [ "$HAS_PASSWORDLESS_SUDO" == "0" ]; then
        echo "[AUTO_DEPLOY] No sudo access - will deploy to home directory only"
        echo "[AUTO_DEPLOY] Web root deployment (/var/www/) will be skipped"
    fi
else
    echo ""
    echo "This script requires sudo privileges for:"
    echo "  - Copying files to $WEB_ROOT"
    echo "  - Configuring Nginx"
    echo ""
    echo "Testing sudo access..."
    if ! sudo -v; then
        echo "ERROR: Cannot obtain sudo privileges"
        keep_terminal_open
        exit 1
    fi
    echo "Sudo access confirmed."
    HAS_PASSWORDLESS_SUDO=1
fi

# Verify required files exist
echo ""
echo "Verifying source files..."
REQUIRED_FILES=("index.html" "papers/zkprivacy/zkprivacy-quantum-spec-v1.md")
MISSING_FILES=0

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$SOURCE_BASE/$file" ] && [ ! -d "$SOURCE_BASE/$file" ]; then
        echo "  Missing: $file"
        MISSING_FILES=1
    else
        echo "  Found: $file"
    fi
done

if [ $MISSING_FILES -eq 1 ]; then
    echo ""
    echo "ERROR: Required files missing from source directory"
    echo "Please sync files from Windows first (deploy_testing.bat)"
    keep_terminal_open
    exit 1
fi

echo ""
echo "=== Deployment Configuration ==="
echo "Source: $SOURCE_BASE"
echo "Target Project: $TARGET_DIR"
echo "Source Libraries: $SOURCE_LIBRARIES"
echo "Target Libraries: $TARGET_LIBRARIES"
echo "Web Root: $WEB_ROOT"
echo "Domain: $DOMAIN"
echo ""

# Final confirmation
if [ "$AUTO_DEPLOY" == "1" ]; then
    CONFIRM="y"
    echo "[AUTO_DEPLOY] Confirmation: auto-confirmed"
else
    echo "Ready to deploy. Continue? (y/n)"
    read CONFIRM

    if [ "$CONFIRM" != "y" ]; then
        echo "Deployment cancelled."
        keep_terminal_open
        exit 0
    fi
fi

echo ""

# === Create directories if needed ===
echo "[1/6] Setting up directories..."
mkdir -p "$TARGET_DIR" 2>/dev/null || true
mkdir -p "$TARGET_LIBRARIES" 2>/dev/null || true

if [ "$HAS_PASSWORDLESS_SUDO" == "1" ]; then
    sudo mkdir -p "$WEB_ROOT"
    echo "  Directories ready (including web root)"
else
    echo "  Home directories ready (web root skipped - no sudo)"
fi

# === Deploy Quantum using shared script ===
echo ""
echo "=== Deploying Quantum ==="
QUANTUM_OUTPUT=$(bash "$LIBRARIES_DEPLOY_SCRIPT" "Quantum" "$SOURCE_BASE" "$TARGET_DIR" "$DEPLOY_TARGET" "n" 2>&1)
echo "$QUANTUM_OUTPUT"

# === Copy to web root (Quantum-specific: static website served by nginx) ===
echo ""
echo "[2/6] Deploying to web root..."
if [ "$HAS_PASSWORDLESS_SUDO" == "1" ]; then
    echo "  Deploying to web root: $WEB_ROOT"
    # Copy to temp directory first (pCloud FUSE doesn't allow root access)
    TEMP_DIR=$(mktemp -d)
    cp "$TARGET_DIR/index.html" "$TEMP_DIR/" 2>/dev/null || true
    cp -r "$TARGET_DIR/assets" "$TEMP_DIR/" 2>/dev/null || true
    cp -r "$TARGET_DIR/papers" "$TEMP_DIR/" 2>/dev/null || true

    # Remove existing files/directories to allow clean replacement
    sudo rm -f "$WEB_ROOT/index.html" 2>/dev/null || true
    sudo rm -rf "$WEB_ROOT/assets" 2>/dev/null || true
    sudo rm -rf "$WEB_ROOT/papers" 2>/dev/null || true

    # Move from temp to web root with sudo
    sudo mv "$TEMP_DIR/index.html" "$WEB_ROOT/" 2>/dev/null || true
    sudo mv "$TEMP_DIR/assets" "$WEB_ROOT/" 2>/dev/null || true
    sudo mv "$TEMP_DIR/papers" "$WEB_ROOT/" 2>/dev/null || true
    rmdir "$TEMP_DIR" 2>/dev/null || true
    echo "  ✓ Web root deployment complete"
else
    echo "  ⏭️  Web root deployment skipped (no sudo)"
fi

# === Deploy Libraries ===
echo ""
echo "[3/6] Deploying Libraries..."
if [ -d "$SOURCE_LIBRARIES" ] && [ -f "$LIBRARIES_DEPLOY_SCRIPT" ]; then
    echo "=== Deploying Libraries (using shared script) ==="
    LIBRARIES_OUTPUT=$(bash "$LIBRARIES_DEPLOY_SCRIPT" "Libraries" "$SOURCE_LIBRARIES" "$TARGET_LIBRARIES" "$DEPLOY_TARGET" "n" 2>&1)
    echo "$LIBRARIES_OUTPUT"
elif [ -d "$SOURCE_LIBRARIES" ]; then
    echo "  Note: Using simple copy (shared script not found)"
    if [ -d "$SOURCE_LIBRARIES/Scripts" ]; then
        mkdir -p "$TARGET_LIBRARIES/Scripts"
        cp -r "$SOURCE_LIBRARIES/Scripts/"* "$TARGET_LIBRARIES/Scripts/" 2>/dev/null || true
        find "$TARGET_LIBRARIES/Scripts" -name "*.sh" -exec sed -i 's/\r$//' {} \; 2>/dev/null || true
        chmod +x "$TARGET_LIBRARIES/Scripts/"*.sh 2>/dev/null || true
        SCRIPTS_COUNT=$(find "$TARGET_LIBRARIES/Scripts" -type f 2>/dev/null | wc -l)
        echo "  ✓ Scripts/ ($SCRIPTS_COUNT files)"
    fi
else
    echo "  ⚠️ Warning: Libraries not found at $SOURCE_LIBRARIES"
    LIBRARIES_OUTPUT=""
fi

# Validate sync manifest
MANIFEST_FILE="$TARGET_DIR/deployment_sync_manifest.json"
validate_sync_manifest "$MANIFEST_FILE"

# Cleanup source manifests
if [ "$AUTO_DEPLOY" != "1" ] || [ "${AUTO_DEPLOY_DELETE_SOURCE:-y}" != "n" ]; then
    cleanup_source_manifests "$SOURCE_BASE" "$SOURCE_LIBRARIES"
else
    echo "[AUTO_DEPLOY] Skipping source manifest cleanup (deferred for multi-variant deployment)"
fi

# Display combined deployment summary
read QUANTUM_ITEMS QUANTUM_FILES <<< $(parse_deployment_counts "$QUANTUM_OUTPUT")
read LIBRARIES_ITEMS LIBRARIES_FILES <<< $(parse_deployment_counts "$LIBRARIES_OUTPUT")
display_deployment_summary "Quantum" "$QUANTUM_OUTPUT" "$QUANTUM_ITEMS" "$QUANTUM_FILES" "$LIBRARIES_OUTPUT" "$LIBRARIES_ITEMS" "$LIBRARIES_FILES"

# === Set permissions ===
echo "[4/6] Setting permissions..."
if [ "$HAS_PASSWORDLESS_SUDO" == "1" ]; then
    sudo chown -R www-data:www-data "$WEB_ROOT"
    sudo chmod -R 755 "$WEB_ROOT"
    sudo chmod 644 "$WEB_ROOT/index.html"
    echo "  Web root permissions set"
else
    echo "  Permissions skipped (no sudo)"
fi

# Set permissions on home directory files
chmod 644 "$TARGET_DIR/index.html" 2>/dev/null || true
chmod -R 755 "$TARGET_DIR/assets" 2>/dev/null || true
chmod -R 755 "$TARGET_DIR/papers" 2>/dev/null || true
echo "  Home directory permissions set"

# === Count deployed files ===
echo "[5/6] Verifying deployment..."
HOME_FILE_COUNT=$(find "$TARGET_DIR" -type f 2>/dev/null | wc -l)
echo "  Deployed $HOME_FILE_COUNT files to $TARGET_DIR"

if [ "$HAS_PASSWORDLESS_SUDO" == "1" ]; then
    WEB_FILE_COUNT=$(sudo find "$WEB_ROOT" -type f 2>/dev/null | wc -l)
    echo "  Deployed $WEB_FILE_COUNT files to $WEB_ROOT"
fi

# === Run startup script for nginx/SSL setup ===
echo "[6/6] Running startup script for nginx configuration..."
STARTUP_SCRIPT="$TARGET_DIR/tools/Scripts/Startup/run_quantum.sh"

if [ "$HAS_PASSWORDLESS_SUDO" == "1" ]; then
    if [ -f "$STARTUP_SCRIPT" ]; then
        chmod +x "$STARTUP_SCRIPT"
        sed -i 's/\r$//' "$STARTUP_SCRIPT" 2>/dev/null || true

        if [ "$AUTO_DEPLOY" == "1" ]; then
            AUTO_DEPLOY=1 DEPLOY_TARGET="$DEPLOY_TARGET" HAS_PASSWORDLESS_SUDO=1 "$STARTUP_SCRIPT"
        else
            "$STARTUP_SCRIPT"
        fi
    else
        echo "  Warning: Startup script not found at $STARTUP_SCRIPT"
        echo "  Nginx configuration may need manual setup"
    fi
else
    echo "  Nginx setup skipped (no sudo)"
    echo "  Run manually with sudo: $STARTUP_SCRIPT"
fi

# === Deployment complete ===
echo ""
echo "================================================"
echo "  Deployment COMPLETE"
echo "================================================"
echo ""
echo "Files deployed to home: $TARGET_DIR ($HOME_FILE_COUNT files)"

if [ "$HAS_PASSWORDLESS_SUDO" == "1" ]; then
    echo "Files deployed to web root: $WEB_ROOT ($WEB_FILE_COUNT files)"
    echo ""
    if [ "$DEPLOY_TARGET" == "test" ]; then
        echo "Test site: http://$DOMAIN (or https:// if SSL configured)"
    else
        echo "Production site: https://$DOMAIN"
    fi
else
    echo ""
    echo "NOTE: Web root deployment was SKIPPED (no passwordless sudo)"
    echo "To complete deployment, run manually with sudo:"
    echo "  sudo $0"
fi

echo ""
echo "NEXT STEPS:"
echo "=============="
if [ "$HAS_PASSWORDLESS_SUDO" == "1" ]; then
    if [ "$DEPLOY_TARGET" == "test" ]; then
        echo "1. Verify test site at http://$DOMAIN"
        echo "2. Check nginx logs: sudo tail -20 /var/log/nginx/quantum_error.log"
    else
        echo "1. Verify site at https://$DOMAIN"
        echo "2. Check all papers load correctly"
    fi
else
    echo "1. Set up passwordless sudo for deployment, OR"
    echo "2. Run this script manually with sudo for web root deployment"
fi

# Cleanup prompts
prompt_source_cleanup "$SOURCE_BASE" "$SOURCE_LIBRARIES"

echo ""
echo "For nginx/SSL updates without redeploying files:"
echo "  $STARTUP_SCRIPT"

# Display manifest summary
echo ""
display_manifest_summary "$MANIFEST_VALIDATION_RESULT"

echo ""
echo "Deployment completed successfully."

# Only keep terminal open in interactive mode
if [ "$AUTO_DEPLOY" != "1" ]; then
    keep_terminal_open
fi
