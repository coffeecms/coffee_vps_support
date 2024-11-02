#Coffee VPS Support - https://blog.lowlevelforest.com/

This repository contains a Bash script for automating the installation of various development tools and server management applications on Ubuntu. The script includes options for creating and optimizing a swap file based on system resources, and allows users to choose specific versions of the software to install.

## Features

- Install Python (multiple versions)
- Install Golang (multiple versions)
- Install Node.js and npm (multiple versions)
- Install Docker
- Install JDK (multiple versions)
- Install Git
- Install aaPanel
- Install CyberPanel
- Install Nginx
- Install Caddy Server
- Install Webmin
- Install VestaCP
- Install Virtualmin
- Automatically create and optimize a swap file

## Prerequisites

- An Ubuntu server (18.04 or later)
- Sudo privileges

## Installation

1. **Clone the repository:**

   Open your terminal and run:

   ```bash
   git clone https://github.com/coffeecms/coffee_vps_support.git
   cd coffee_vps_support
   ```

2. **Make the script executable:**

   Run the following command to make the script executable:

   ```bash
   chmod +x setup.sh
   ```

3. **Run the script:**

   Execute the script with the following command:

   ```bash
   ./setup.sh
   ```

   Follow the on-screen instructions to select the software you want to install.

## Usage

When you run the script, you will be presented with a menu of options. Here's an example of how to use the script:

1. **Create/Optimize Swap File:**
   - Choose option `1` to create a swap file based on your RAM size. The script will automatically calculate and create a swap file.

2. **Install Python:**
   - Choose option `2`. The script will list available versions of Python. For example, if you want to install Python 3.11, choose `2` when prompted.

3. **Install Golang:**
   - Choose option `3`, then select the version you wish to install from the list.

4. **Install Node.js and npm:**
   - Choose option `4` and select the desired version.

5. **Install Docker:**
   - Choose option `5` to install Docker.

6. **Install other software:**
   - Follow similar steps for JDK, Git, aaPanel, CyberPanel, Nginx, Caddy Server, Webmin, VestaCP, and Virtualmin.

## Example

Here is an example interaction with the script:

```
Menu:
1. Create/Optimize Swap File
2. Install Python
3. Install Golang
4. Install Node.js & npm
5. Install Docker
...
Choose an option (1-16): 2

Available versions for Python:
1. Python 3.10
2. Python 3.11
3. Python 3.12
4. Python 3.9
5. Python 3.8
Choose a version (1-5): 2

Installing Python 3.11...
```

## Important Notes

- **Existing Installations:** The script checks for existing installations of each application before attempting to install it.
- **Swap File:** The script will not create a swap file if one already exists.
- **System Updates:** It is recommended to update your system (`sudo apt-get update`) before running the script.

## Contribution

Feel free to contribute to this project by submitting pull requests or opening issues for any bugs or feature requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
