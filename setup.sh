#!/bin/bash

# Function to check if a package is installed
is_installed() {
    dpkg -l | grep -q "$1" || docker ps -a | grep -q "$1"
}

# Function to create and optimize swap file
create_swap() {
    echo "Checking for existing swap file..."
    if [ "$(swapon --show | wc -l)" -gt 0 ]; then
        echo "Swap file is already configured."
        return
    fi

    # Get RAM size in MB
    ram_size=$(free -m | awk '/^Mem:/{print $2}')
    echo "Detected RAM size: ${ram_size}MB"

    # Calculate swap size (recommended: 1.5 times the RAM size)
    swap_size=$((ram_size * 3 / 2))  # Use 1.5 times the RAM size
    if [ $swap_size -lt 1024 ]; then
        swap_size=1024  # Minimum swap size
    fi
    echo "Creating swap file of size: ${swap_size}MB"

    # Create swap file
    sudo fallocate -l "${swap_size}M" /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile

    # Add to fstab for persistent swap
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

    echo "Swap file created and enabled."
}

# Function to install Python
install_python() {
    echo "Available versions for Python:"
    echo "1. Python 3.10"
    echo "2. Python 3.11"
    echo "3. Python 3.12"
    echo "4. Python 3.9"
    echo "5. Python 3.8"
    read -p "Choose a version (1-5): " version_choice

    case $version_choice in
        1) version="3.10" ;;
        2) version="3.11" ;;
        3) version="3.12" ;;
        4) version="3.9" ;;
        5) version="3.8" ;;
        *) echo "Invalid choice"; return ;;
    esac

    if is_installed "python$version"; then
        echo "Python $version is already installed."
    else
        echo "Installing Python $version..."
        sudo apt-get install -y "python$version"
    fi
}

# Function to install Golang
install_golang() {
    echo "Available versions for Golang:"
    echo "1. Go 1.16"
    echo "2. Go 1.17"
    echo "3. Go 1.18"
    echo "4. Go 1.19"
    echo "5. Go 1.20"
    read -p "Choose a version (1-5): " version_choice

    case $version_choice in
        1) version="1.16" ;;
        2) version="1.17" ;;
        3) version="1.18" ;;
        4) version="1.19" ;;
        5) version="1.20" ;;
        *) echo "Invalid choice"; return ;;
    esac

    if is_installed "golang-go"; then
        echo "Golang $version is already installed."
    else
        echo "Installing Golang $version..."
        wget "https://golang.org/dl/go$version.linux-amd64.tar.gz" -O /tmp/go.tar.gz
        sudo tar -C /usr/local -xzf /tmp/go.tar.gz
        echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
        source ~/.bashrc
    fi
}

# Function to install Node.js and npm
install_nodejs() {
    echo "Available versions for Node.js:"
    echo "1. Node.js 14"
    echo "2. Node.js 16"
    echo "3. Node.js 18"
    echo "4. Node.js 19"
    echo "5. Node.js 20"
    read -p "Choose a version (1-5): " version_choice

    case $version_choice in
        1) version="14" ;;
        2) version="16" ;;
        3) version="18" ;;
        4) version="19" ;;
        5) version="20" ;;
        *) echo "Invalid choice"; return ;;
    esac

    if is_installed "nodejs"; then
        echo "Node.js $version is already installed."
    else
        echo "Installing Node.js $version..."
        curl -fsSL "https://deb.nodesource.com/setup_$version.x" | sudo -E bash -
        sudo apt-get install -y nodejs
    fi
}

# Function to install Docker
install_docker() {
    if is_installed "docker"; then
        echo "Docker is already installed."
    else
        echo "Installing Docker..."
        sudo apt-get update
        sudo apt-get install -y docker.io
        sudo systemctl start docker
        sudo systemctl enable docker
    fi
}

# Function to install JDK
install_jdk() {
    echo "Available versions for JDK:"
    echo "1. OpenJDK 8"
    echo "2. OpenJDK 11"
    echo "3. OpenJDK 17"
    echo "4. OpenJDK 18"
    echo "5. OpenJDK 19"
    read -p "Choose a version (1-5): " version_choice

    case $version_choice in
        1) version="8" ;;
        2) version="11" ;;
        3) version="17" ;;
        4) version="18" ;;
        5) version="19" ;;
        *) echo "Invalid choice"; return ;;
    esac

    if is_installed "openjdk-$version-jdk"; then
        echo "OpenJDK $version is already installed."
    else
        echo "Installing OpenJDK $version..."
        sudo apt-get install -y "openjdk-$version-jdk"
    fi
}

# Function to install Git
install_git() {
    if is_installed "git"; then
        echo "Git is already installed."
    else
        echo "Installing Git..."
        sudo apt-get update
        sudo apt-get install -y git
        echo "Git has been installed successfully."
    fi
}

# Function to install aaPanel
install_aapanel() {
    if is_installed "aapanel"; then
        echo "aaPanel is already installed."
    else
        echo "Installing aaPanel..."
        curl -sL http://www.aapanel.com/script/install-ubuntu.sh | sudo bash
    fi
}

# Function to install CyberPanel
install_cyberpanel() {
    if is_installed "cyberpanel"; then
        echo "CyberPanel is already installed."
    else
        echo "Installing CyberPanel..."
        sudo sh <(curl -sL https://cyberpanel.net/install.sh)
    fi
}

# Function to install Nginx
install_nginx() {
    if is_installed "nginx"; then
        echo "Nginx is already installed."
    else
        echo "Installing Nginx..."
        sudo apt-get update
        sudo apt-get install -y nginx
        sudo systemctl start nginx
        sudo systemctl enable nginx
    fi
}

# Function to install Caddy Server
install_caddy() {
    if is_installed "caddy"; then
        echo "Caddy Server is already installed."
    else
        echo "Installing Caddy Server..."
        sudo apt-get update
        sudo apt-get install -y caddy
        sudo systemctl start caddy
        sudo systemctl enable caddy
    fi
}

# Function to install Caddy via Docker
install_caddy_docker() {
    if is_installed "caddy"; then
        echo "Caddy Server is already installed."
    else
        echo "Installing Caddy Server via Docker..."
        sudo docker run -d --name caddy -p 80:80 -p 443:443 \
        -v caddy_data:/data \
        -v caddy_config:/config \
        caddy
    fi
}

# Function to install Webmin
install_webmin() {
    if is_installed "webmin"; then
        echo "Webmin is already installed."
    else
        echo "Installing Webmin..."
        sudo apt-get update
        sudo apt-get install -y software-properties-common
        wget -qO - http://www.webmin.com/jcameron-key.asc | sudo apt-key add -
        sudo add-apt-repository "deb http://download.webmin.com/download/repository sarge contrib"
        sudo apt-get update
        sudo apt-get install -y webmin
    fi
}

# Function to install VestaCP
install_vestacp() {
    if is_installed "vestacp"; then
        echo "VestaCP is already installed."
    else
        echo "Installing VestaCP..."
        curl -O https://vestacp.com/pub/vst-install.sh
        sudo bash vst-install.sh
        rm -f vst-install.sh
    fi
}

# Function to install Virtualmin
install_virtualmin() {
    if is_installed "virtualmin"; then
        echo "Virtualmin is already installed."
    else
        echo "Installing Virtualmin..."
        cd /tmp
        wget http://software.virtualmin.com/gpl/scripts/install.sh
        sudo bash install.sh
    fi
}

# Main menu
while true; do
    echo "Menu:"
    echo "1. Create/Optimize Swap File"
    echo "2. Install Python"
    echo "3. Install Golang"
    echo "4. Install Node.js & npm"
    echo "5. Install Docker"
    echo "6. Install JDK"
    echo "7. Install Git"
    echo "8. Install aaPanel"
    echo "9. Install CyberPanel"
    echo "10. Install Nginx"
    echo "11. Install Caddy Server"
    echo "12. Install Caddy Server (Docker)"
    echo "13. Install Webmin"
    echo "14. Install VestaCP"
    echo "15. Install Virtualmin"
    echo "16. Exit"
    read -p "Choose an option (1-16): " choice

    case $choice in
        1) create_swap ;;
        2) install_python ;;
        3) install_golang ;;
        4) install_nodejs ;;
        5) install_docker ;;
        6) install_jdk ;;
        7) install_git ;;
        8) install_aapanel ;;
        9) install_cyberpanel ;;
        10) install_nginx ;;
        11) install_caddy ;;
        12) install_caddy_docker ;;
        13) install_webmin ;;
        14) install_vestacp ;;
        15) install_virtualmin ;;
        16) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice" ;;
    esac
done
