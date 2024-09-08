#!/bin/bash

# MySQL Auto Installer for Ubuntu 22.04 https://github.com/CodeMeZone/mysql-auto-installer-ubuntu

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or using sudo"
  exit 1
fi

# Function to print section headers
print_header() {
    echo "===================================="
    echo "$1"
    echo "===================================="
}

# Update system
print_header "Updating System"
apt update && apt upgrade -y

# Install MySQL Server
print_header "Installing MySQL Server"
apt install mysql-server -y

# Start MySQL service
systemctl start mysql.service

# Secure MySQL installation
print_header "Securing MySQL Installation"

# Generate a random root password
ROOT_PASSWORD=$(openssl rand -base64 12)

# Set root password and remove anonymous users
mysql --user=root <<_EOF_ 2>/dev/null
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
FLUSH PRIVILEGES;
_EOF_

# Remove test database
mysql --user=root --password="${ROOT_PASSWORD}" -e "DROP DATABASE IF EXISTS test;" 2>/dev/null

# Prompt for new database and user creation
read -p "Enter new database name: " DB_NAME
read -p "Enter new database username: " DB_USER
DB_PASS=$(openssl rand -base64 12)

# Create new database and user
print_header "Creating New Database and User"
mysql --user=root --password="${ROOT_PASSWORD}" <<_EOF_ 2>/dev/null
CREATE DATABASE ${DB_NAME};
CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
_EOF_

# Print installation summary
print_header "Installation Complete"
echo "MySQL has been installed and secured."
echo "Root password: ${ROOT_PASSWORD}"
echo "New database: ${DB_NAME}"
echo "New user: ${DB_USER}"
echo "New user password: ${DB_PASS}"
echo ""
echo "Please save these credentials securely and delete this script."

# Restart MySQL service
systemctl restart mysql.service

print_header "MySQL Status"
systemctl status mysql.service
