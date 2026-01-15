#!/bin/bash

#
# Quantum - Startup Script
# Sets up nginx, maintenance page, and SSL for static documentation website
# Uses shared common_functions.sh library
#

# ============================================================================
# PROJECT CONFIGURATION
# ============================================================================
PROJECT_NAME="Quantum"

# Resolve paths dynamically from script location
# Use readlink -f to properly resolve symlinks (e.g., when run from ~/Desktop/Run scripts/)
SCRIPT_PATH="${BASH_SOURCE[0]}"
if [ -L "$SCRIPT_PATH" ]; then
    SCRIPT_DIR="$(dirname "$(readlink -f "$SCRIPT_PATH")")"
else
    SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
fi
# Script is in tools/Scripts/Startup/, so project root is 3 levels up
PROJECT_DIR="$(cd "$SCRIPT_DIR/../../.." && pwd)"
# Parent directory contains Libraries folder
PARENT_DIR="$(cd "$PROJECT_DIR/.." && pwd)"

# Determine deployment target from environment or default to main
DEPLOY_TARGET="${DEPLOY_TARGET:-main}"

if [ "$DEPLOY_TARGET" == "main" ]; then
    WEB_ROOT="/var/www/quantum"
    DOMAIN="quantum.phexora.ai"
    NGINX_CONFIG_NAME="quantum.conf"
    MAINTENANCE_PAGE="/var/www/html/maintenance_quantum.html"
    MAINTENANCE_PAGE_FILENAME="maintenance_quantum.html"
else
    WEB_ROOT="/var/www/quantum-test"
    DOMAIN="test.quantum.phexora.ai"
    NGINX_CONFIG_NAME="quantum-test.conf"
    MAINTENANCE_PAGE="/var/www/html/maintenance_quantum_test.html"
    MAINTENANCE_PAGE_FILENAME="maintenance_quantum_test.html"
fi

NGINX_SITES_AVAILABLE="/etc/nginx/sites-available"
NGINX_SITES_ENABLED="/etc/nginx/sites-enabled"
SSL_CERT="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"
SSL_KEY="/etc/letsencrypt/live/$DOMAIN/privkey.pem"
LIBRARIES_PATH="$PARENT_DIR/Libraries/Python"

# Fix own line endings (handles Windows CRLF -> Unix LF)
sed -i 's/\r$//' "$PROJECT_DIR/tools/Scripts/Startup/$(basename "$0")" 2>/dev/null || true

echo "================================================"
echo "  $PROJECT_NAME - Startup ($DEPLOY_TARGET server)"
echo "================================================"
echo ""
echo "Working from: $PROJECT_DIR"
echo "Web root: $WEB_ROOT"
echo "Domain: $DOMAIN"

# ============================================================================
# LOAD COMMON FUNCTIONS (REQUIRED)
# ============================================================================
COMMON_FUNCTIONS="$PARENT_DIR/Libraries/Scripts/common_functions.sh"

if [ ! -f "$COMMON_FUNCTIONS" ]; then
    echo "FATAL: common_functions.sh not found at $COMMON_FUNCTIONS"
    exit 1
fi
sed -i 's/\r$//' "$COMMON_FUNCTIONS" 2>/dev/null || true
source "$COMMON_FUNCTIONS"

# ============================================================================
# SET TERMINAL WINDOW TITLE (for Ubuntu window overview hover identification)
# ============================================================================
set_terminal_title "$PROJECT_NAME - $DEPLOY_TARGET Startup"

# ============================================================================
# SUDO AUTHENTICATION
# ============================================================================
setup_sudo_auth
_setup_exit_trap

# Define sudo wrapper function - uses -A flag with common_functions
run_sudo() {
    sudo -A "$@"
}

# ============================================================================
# VERIFY WEB ROOT EXISTS
# ============================================================================
echo ""
echo "[1/6] Verifying web root..."

if [ ! -d "$WEB_ROOT" ]; then
    echo "  Creating web root directory..."
    run_sudo mkdir -p "$WEB_ROOT"
fi

if [ ! -f "$WEB_ROOT/index.html" ]; then
    echo "  WARNING: index.html not found in $WEB_ROOT"
    echo "  Run the deploy script first to copy website files."
else
    echo "  Web root OK: $WEB_ROOT"
fi

# ============================================================================
# CREATE MAINTENANCE PAGE
# ============================================================================
echo ""
echo "[2/6] Setting up maintenance page..."

if [ ! -f "$MAINTENANCE_PAGE" ]; then
    run_sudo tee "$MAINTENANCE_PAGE" > /dev/null << 'MAINTEOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quantum - Maintenance</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: #0a0a0f;
            color: #e8e8f0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 2rem;
        }
        .container {
            max-width: 500px;
            background: #1a1a24;
            padding: 3rem;
            border-radius: 12px;
            border: 1px solid #2a2a3a;
        }
        .logo {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.5rem;
            color: white;
            margin-bottom: 1.5rem;
        }
        h1 {
            font-size: 1.5rem;
            letter-spacing: -0.02em;
            margin-bottom: 1rem;
            color: #e8e8f0;
        }
        p {
            font-size: 1rem;
            line-height: 1.6;
            color: #a0a0b0;
            margin-bottom: 1rem;
        }
        .spinner {
            margin: 2rem auto;
            width: 40px;
            height: 40px;
            border: 3px solid #2a2a3a;
            border-top-color: #6366f1;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">Q</div>
        <h1>Updating Documentation</h1>
        <p>The site is being updated with new research papers.</p>
        <p>Please check back in a moment.</p>
        <div class="spinner"></div>
    </div>
    <script>setTimeout(function() { location.reload(); }, 10000);</script>
</body>
</html>
MAINTEOF
    run_sudo chmod 644 "$MAINTENANCE_PAGE"
    echo "  Maintenance page created"
else
    echo "  Maintenance page exists"
fi

# ============================================================================
# CHECK SSL CERTIFICATE
# ============================================================================
echo ""
echo "[3/6] Checking SSL certificate..."

cert_valid=false
cert_status="missing"

if run_sudo test -r "$SSL_CERT" && run_sudo test -r "$SSL_KEY"; then
    if run_sudo openssl x509 -checkend 604800 -noout -in "$SSL_CERT" 2>/dev/null; then
        cert_valid=true
        cert_status="valid"
        EXPIRY_DATE=$(run_sudo openssl x509 -enddate -noout -in "$SSL_CERT" 2>/dev/null | cut -d= -f2)
        echo "  SSL certificate valid (expires: $EXPIRY_DATE)"
    else
        cert_status="expiring"
        echo "  SSL certificate expires within 7 days!"
    fi
else
    echo "  No SSL certificate found"
fi

# Attempt to get/renew certificate if needed (skip in AUTO_DEPLOY for speed)
if [ "$cert_valid" = false ] && [ "$AUTO_DEPLOY" != "1" ]; then
    echo ""
    echo "  Attempting to obtain/renew SSL certificate..."

    # Ensure certbot is installed
    if ! command -v certbot &> /dev/null; then
        echo "  Installing certbot..."
        run_sudo apt update
        run_sudo apt install -y certbot python3-certbot-nginx
    fi

    # Try to get certificate
    if run_sudo certbot --nginx -d "$DOMAIN" --non-interactive --agree-tos --email robert-ledwig@outlook.com 2>/dev/null; then
        cert_valid=true
        cert_status="valid"
        echo "  SSL certificate obtained successfully"
    else
        echo "  Could not obtain SSL certificate - using HTTP-only config"
        echo "  You may need to run certbot manually:"
        echo "  sudo certbot --nginx -d $DOMAIN"
    fi
elif [ "$cert_valid" = false ] && [ "$AUTO_DEPLOY" == "1" ]; then
    echo "  [AUTO_DEPLOY] Skipping SSL auto-renewal (run manually if needed)"
fi

# ============================================================================
# CONFIGURE NGINX
# ============================================================================
echo ""
echo "[4/6] Configuring nginx..."

NGINX_CONFIG="$NGINX_SITES_AVAILABLE/$NGINX_CONFIG_NAME"

if [ "$cert_valid" = true ]; then
    echo "  Generating HTTPS configuration..."
    run_sudo tee "$NGINX_CONFIG" > /dev/null << EOF
# Nginx configuration for Quantum ($DEPLOY_TARGET)
# Auto-generated by startup script

server {
    listen 80;
    listen [::]:80;
    server_name $DOMAIN;

    # ACME challenge for cert renewal
    location /.well-known/acme-challenge/ {
        root /var/www/html;
        try_files \$uri =404;
    }

    # Redirect HTTP to HTTPS
    location / {
        return 301 https://\$host\$request_uri;
    }
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name $DOMAIN;

    # SSL certificates (managed by Certbot)
    ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers off;
    ssl_session_cache shared:${PROJECT_NAME}TLS:10m;

    # Root directory
    root $WEB_ROOT;
    index index.html;

    # Logging
    access_log /var/log/nginx/quantum_access.log;
    error_log /var/log/nginx/quantum_error.log;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Strict-Transport-Security "max-age=63072000" always;

    # Main location
    location / {
        try_files \$uri \$uri/ =404;
    }

    # Cache static assets
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2|ttf|eot|pdf)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Papers (Markdown files) - serve with correct content type
    location /papers/ {
        expires 1d;
        types {
            text/markdown md;
        }
        default_type text/markdown;
    }

    # Deny access to hidden files
    location ~ /\. {
        deny all;
    }

    # Error page handling
    error_page 500 502 503 504 = @maintenance;
    location @maintenance {
        root /var/www/html;
        add_header Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" always;
        add_header Pragma "no-cache" always;
        add_header Expires "0" always;
        rewrite ^ /$MAINTENANCE_PAGE_FILENAME break;
    }
}
EOF
else
    echo "  Generating HTTP-only configuration..."
    run_sudo tee "$NGINX_CONFIG" > /dev/null << EOF
# Nginx configuration for Quantum ($DEPLOY_TARGET)
# HTTP-only config - run certbot to enable HTTPS
# Auto-generated by startup script

server {
    listen 80;
    listen [::]:80;
    server_name $DOMAIN;

    # Root directory
    root $WEB_ROOT;
    index index.html;

    # Logging
    access_log /var/log/nginx/quantum_access.log;
    error_log /var/log/nginx/quantum_error.log;

    # ACME challenge for certbot
    location /.well-known/acme-challenge/ {
        root /var/www/html;
        try_files \$uri =404;
    }

    # Main location
    location / {
        try_files \$uri \$uri/ =404;
    }

    # Cache static assets
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2|ttf|eot|pdf)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Papers (Markdown files)
    location /papers/ {
        expires 1d;
        types {
            text/markdown md;
        }
        default_type text/markdown;
    }

    # Deny access to hidden files
    location ~ /\. {
        deny all;
    }

    # Error page handling
    error_page 500 502 503 504 = @maintenance;
    location @maintenance {
        root /var/www/html;
        add_header Cache-Control "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0" always;
        add_header Pragma "no-cache" always;
        add_header Expires "0" always;
        rewrite ^ /$MAINTENANCE_PAGE_FILENAME break;
    }
}
EOF
fi

# Create symlink if not exists
if [ ! -L "$NGINX_SITES_ENABLED/$NGINX_CONFIG_NAME" ]; then
    echo "  Creating sites-enabled symlink..."
    run_sudo ln -sf "$NGINX_CONFIG" "$NGINX_SITES_ENABLED/$NGINX_CONFIG_NAME"
fi

# Test nginx configuration
echo ""
echo "[5/6] Testing nginx configuration..."
if ! run_sudo nginx -t; then
    echo ""
    echo "ERROR: Nginx configuration test failed!"
    exit 1
fi
echo "  Nginx configuration OK"

# Reload nginx
run_sudo systemctl reload nginx
echo "  Nginx reloaded"

# ============================================================================
# SSL CERTIFICATE MONITOR
# ============================================================================
echo ""
echo "[6/6] Running SSL certificate monitor..."

echo "Checking SSL certificates for expiration..."

_check_ssl_cert_local() {
    local cert_path="$1"
    local cert_name="$2"

    if [ ! -f "$cert_path" ]; then
        return 1
    fi

    local expiry_date expiry_epoch now_epoch days_left
    expiry_date=$(openssl x509 -enddate -noout -in "$cert_path" 2>/dev/null | cut -d= -f2)
    if [ -z "$expiry_date" ]; then
        return 1
    fi

    expiry_epoch=$(date -d "$expiry_date" +%s 2>/dev/null)
    now_epoch=$(date +%s)
    days_left=$(( (expiry_epoch - now_epoch) / 86400 ))

    if [ "$days_left" -lt 0 ]; then
        echo "  EXPIRED: $cert_name"
    elif [ "$days_left" -lt 7 ]; then
        echo "  CRITICAL: $cert_name - $days_left days"
    elif [ "$days_left" -lt 14 ]; then
        echo "  WARNING: $cert_name - $days_left days"
    elif [ "$days_left" -lt 30 ]; then
        echo "  OK: $cert_name - $days_left days"
    else
        echo "  Valid: $cert_name - $days_left days"
    fi
    return 0
}

cert_found=false
if [ -n "${DOMAIN:-}" ]; then
    if [ -f "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" ]; then
        _check_ssl_cert_local "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" "$DOMAIN (Let's Encrypt)"
        cert_found=true
    fi
fi

if [ "$cert_found" = false ]; then
    echo "  No SSL certificates found to check"
fi

# ============================================================================
# VERIFY SITE IS ACCESSIBLE
# ============================================================================
echo ""
echo "Verifying site accessibility..."

sleep 2

if [ "$cert_valid" = true ]; then
    SITE_URL="https://$DOMAIN"
else
    SITE_URL="http://$DOMAIN"
fi

if curl -s --max-time 10 -o /dev/null -w "%{http_code}" "$SITE_URL" | grep -q "200\|301\|302"; then
    echo "  Site is accessible at $SITE_URL"
else
    echo "  WARNING: Site may not be accessible"
    echo "  Check: curl -I $SITE_URL"
fi

# ============================================================================
# SUMMARY
# ============================================================================
echo ""
echo "=============================================="
echo "  $PROJECT_NAME Startup Complete ($DEPLOY_TARGET)"
echo "=============================================="
echo ""
echo "Web Root: $WEB_ROOT"
echo "Domain: $DOMAIN"
echo "SSL: $cert_status"

if [ "$cert_valid" = true ]; then
    echo "URL: https://$DOMAIN"
else
    echo "URL: http://$DOMAIN"
    echo ""
    echo "To enable HTTPS, run:"
    echo "  sudo certbot --nginx -d $DOMAIN"
fi

echo ""
echo "Logs:"
echo "  Access: /var/log/nginx/quantum_access.log"
echo "  Errors: /var/log/nginx/quantum_error.log"
echo ""
echo "Troubleshooting:"
echo "  - Test nginx: sudo nginx -t"
echo "  - Check status: sudo systemctl status nginx"
echo "  - View errors: sudo tail -20 /var/log/nginx/quantum_error.log"
echo ""

# Only wait in interactive mode
if [ "$AUTO_DEPLOY" != "1" ] && [ -t 0 ]; then
    echo "Press Enter to exit..."
    read
fi
