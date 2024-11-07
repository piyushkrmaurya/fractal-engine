#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# --- 1. OpenSSL: Generate self-signed certs if they don't exist ---
KEY_FILE="/etc/ssl/private/self.key"
CERT_FILE="/etc/ssl/certs/self.crt"

if [ ! -f "$KEY_FILE" ] || [ ! -f "$CERT_FILE" ]; then
  echo "--- Generating self-signed SSL certificate ---"
  
  # Create directories if they don't exist
  mkdir -p /etc/ssl/private
  mkdir -p /etc/ssl/certs
  
  # Use openssl to generate a new cert and key
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$KEY_FILE" \
    -out "$CERT_FILE" \
    -subj "/C=IN/ST=UP/L=Varanasi/O=FractalEngine/CN=localhost"
  echo "--- SSL certificate generated ---"
else
  echo "--- SSL certificate found ---"
fi

# --- 2. Start Nginx ---
# Load the custom config file in the background
echo "--- Starting Nginx ---"
nginx -c /opt/fractal-engine/config/nginx.conf

# --- 3. Start Python App ---
echo "--- Starting Gunicorn (Python App) ---"
cd /opt/fractal-engine/app

# Run Gunicorn, binding to the loopback address on port 8000
# Nginx will proxy to this.
# 'exec' replaces the shell with the Gunicorn process,
# making it the main process (PID 1) for the container.
exec gunicorn --workers 4 --bind 127.0.0.1:8000 app:app
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 