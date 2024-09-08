# MySQL Auto Installer for Ubuntu 22.04

This bash script automates the process of installing and configuring MySQL Server on Ubuntu 22.04. It provides a streamlined way to set up a secure MySQL installation with a new database and user.

## Features

- Automatically updates the system
- Installs MySQL Server
- Secures the MySQL installation:
  - Sets a random root password
  - Removes anonymous users
  - Disables remote root login
  - Removes the test database
- Creates a new database and user
- Displays installation summary with credentials
- Restarts MySQL service and shows its status

## Prerequisites

- Ubuntu 22.04 LTS
- Sudo privileges

## Installation

1. Clone this repository or download the `mysql_installer.sh` script.
2. Make the script executable:
   ```
   chmod +x mysql_installer.sh
   ```

## Usage

1. Run the script with sudo privileges:
   ```
   sudo ./mysql_installer.sh
   ```
2. Follow the prompts to enter the new database name and username.
3. The script will display the installation summary, including:
   - MySQL root password
   - New database name
   - New database username and password

**Important:** Make sure to save the displayed credentials securely, as they will not be shown again.

## Security Note

This script generates random passwords for both the root user and the new user. After running the script, it's recommended to:

1. Save the displayed credentials in a secure password manager.
2. Delete the script or move it to a secure location, as it contains sensitive information.

## Customization

You can modify the script to suit your specific needs, such as:

- Adjusting MySQL configuration settings
- Adding more security measures
- Changing the password generation method

## Troubleshooting

If you encounter any issues during installation, check the following:

1. Ensure you're running the script with sudo privileges.
2. Verify that your system meets the prerequisites.
3. Check the MySQL log files for any error messages:
   ```
   sudo tail -f /var/log/mysql/error.log
   ```

## Contributing

Contributions to improve the script are welcome. Please feel free to submit a Pull Request.

## License

This script is released under the MIT License. See the [LICENSE](LICENSE) file for details.

## Disclaimer

This script is provided as-is, without any warranty. Always review scripts before running them with root privileges and ensure you understand the actions they perform.
