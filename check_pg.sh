#!/bin/bash

echo "🔍 Checking PostgreSQL Installation..."

# 1. Check if PostgreSQL is installed
if ! command -v psql > /dev/null; then
  echo "❌ PostgreSQL is NOT installed."
  exit 1
else
  echo "✅ PostgreSQL is installed: $(psql --version)"
fi

# 2. Check service status
echo -n "🧪 Checking service status... "
if systemctl is-active --quiet postgresql; then
  echo "✅ Running"
else
  echo "❌ Not running. Try: sudo systemctl start postgresql"
fi

# 3. Check for PostgreSQL packages
echo "📦 Checking installed packages..."
dpkg -l | grep postgresql

# 4. Check for 'postgres' user
echo -n "👤 Checking for 'postgres' user... "
if id "postgres" &>/dev/null; then
  echo "✅ Found"
else
  echo "❌ Not found. You may need to reinstall or add user."
fi

# 5. Check configuration files
CONF_DIR="/etc/postgresql"
if [ -d "$CONF_DIR" ]; then
  echo "📁 Config directory found: $CONF_DIR"
  echo "📄 Key configs:"
  find $CONF_DIR -name "postgresql.conf"
  find $CONF_DIR -name "pg_hba.conf"
else
  echo "❌ Config directory not found!"
fi

# 6. Check for password authentication
echo -n "🔐 Checking pg_hba.conf for 'md5' or 'scram-sha-256'... "
HBA_FILE=$(find $CONF_DIR -name "pg_hba.conf" | head -n 1)
if grep -Eq 'md5|scram-sha-256' "$HBA_FILE"; then
  echo "✅ Password auth enabled"
else
  echo "⚠️ Warning: Only peer or trust auth enabled"
fi

# 7. List PostgreSQL roles
echo "👥 Listing PostgreSQL users (roles)..."
sudo -u postgres psql -tAc "SELECT rolname FROM pg_roles;"

# 8. Advise
echo ""
echo "📋 Summary:"
echo "- Ensure the service is enabled: sudo systemctl enable postgresql"
echo "- Use 'sudo -u postgres psql' to access the DB"
echo "- Consider setting a password for the 'postgres' role"
echo "- Use pgAdmin or a GUI if preferred for management"

echo "✅ Check complete."

