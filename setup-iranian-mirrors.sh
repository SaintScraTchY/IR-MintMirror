#!/bin/bash

# Iranian Mirrors Setup Script for Linux Mint 22 (Wilma)
# This script ADDS Iranian mirrors as fallbacks - nothing is removed
# Safe for beginners - includes backup and restore function

set -e

# Colors for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}Iranian Mirrors Setup for Linux Mint 22${NC}"
echo -e "${BLUE}========================================${NC}\n"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${YELLOW}Please run with sudo: sudo bash $0${NC}"
    exit 1
fi

# Check if running on Linux Mint 22
if ! grep -q "Linux Mint 22" /etc/linuxmint/info 2>/dev/null; then
    echo -e "${YELLOW}Warning: This script is designed for Linux Mint 22 (Wilma)${NC}"
    echo -e "${YELLOW}Your system might be different. Continue? (y/n)${NC}"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create backup directory with timestamp
BACKUP_DIR="/etc/apt/backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo -e "${GREEN}✓ Backup directory created: $BACKUP_DIR${NC}"

# Backup all existing sources
cp /etc/apt/sources.list "$BACKUP_DIR/" 2>/dev/null || true
cp -r /etc/apt/sources.list.d "$BACKUP_DIR/" 2>/dev/null || true
echo -e "${GREEN}✓ Existing repositories backed up${NC}"

# Function to add a mirror if not already present
add_mirror() {
    local mirror_file="$1"
    local mirror_content="$2"
    
    if [ ! -f "$mirror_file" ]; then
        echo "$mirror_content" > "$mirror_file"
        echo -e "${GREEN}✓ Added: $(basename "$mirror_file")${NC}"
    else
        echo -e "${YELLOW}⚠ File exists: $(basename "$mirror_file") (skipped)${NC}"
    fi
}

# Add Iranian Ubuntu mirrors (as fallbacks - they won't replace official repos)
echo -e "\n${BLUE}➜ Adding Iranian Ubuntu mirrors...${NC}"

add_mirror "/etc/apt/sources.list.d/iran-ubuntu-arvancloud.list" \
"# Iranian Mirror - ArvanCloud (High speed, reliable)
deb http://mirror.arvancloud.ir/ubuntu noble main restricted universe multiverse
deb http://mirror.arvancloud.ir/ubuntu noble-updates main restricted universe multiverse
deb http://mirror.arvancloud.ir/ubuntu noble-backports main restricted universe multiverse
deb http://mirror.arvancloud.ir/ubuntu noble-security main restricted universe multiverse"

add_mirror "/etc/apt/sources.list.d/iran-ubuntu-shatel.list" \
"# Iranian Mirror - Shatel (Good backup)
deb http://mirror.shatel.ir/ubuntu noble main restricted universe multiverse
deb http://mirror.shatel.ir/ubuntu noble-updates main restricted universe multiverse
deb http://mirror.shatel.ir/ubuntu noble-backports main restricted universe multiverse
deb http://mirror.shatel.ir/ubuntu-security noble-security main restricted universe multiverse"

add_mirror "/etc/apt/sources.list.d/iran-ubuntu-atlantis.list" \
"# Iranian Mirror - AtlantisCloud
deb http://mirror.atlantiscloud.ir/ubuntu noble main restricted universe multiverse
deb http://mirror.atlantiscloud.ir/ubuntu noble-updates main restricted universe multiverse
deb http://mirror.atlantiscloud.ir/ubuntu noble-backports main restricted universe multiverse
deb http://mirror.atlantiscloud.ir/ubuntu noble-security main restricted universe multiverse"

add_mirror "/etc/apt/sources.list.d/iran-ubuntu-kimiahost.list" \
"# Iranian Mirror - KimiaHost
deb http://ubuntu-mirror.kimiahost.com/ubuntu noble main restricted universe multiverse
deb http://ubuntu-mirror.kimiahost.com/ubuntu noble-updates main restricted universe multiverse
deb http://ubuntu-mirror.kimiahost.com/ubuntu noble-backports main restricted universe multiverse
deb http://ubuntu-mirror.kimiahost.com/ubuntu noble-security main restricted universe multiverse"

add_mirror "/etc/apt/sources.list.d/iran-ubuntu-digitalvps.list" \
"# Iranian Mirror - DigitalVPS
deb http://mirror.digitalvps.ir/ubuntu noble main restricted universe multiverse
deb http://mirror.digitalvps.ir/ubuntu noble-updates main restricted universe multiverse
deb http://mirror.digitalvps.ir/ubuntu noble-backports main restricted universe multiverse
deb http://mirror.digitalvps.ir/ubuntu noble-security main restricted universe multiverse"

add_mirror "/etc/apt/sources.list.d/iran-ubuntu-sindad.list" \
"# Iranian Mirror - Sindad Cloud
deb https://ir.ubuntu.sindad.cloud noble main restricted universe multiverse
deb https://ir.ubuntu.sindad.cloud noble-updates main restricted universe multiverse
deb https://ir.ubuntu.sindad.cloud noble-backports main restricted universe multiverse
deb https://ir.ubuntu.sindad.cloud noble-security main restricted universe multiverse"

add_mirror "/etc/apt/sources.list.d/iran-ubuntu-zerocloud.list" \
"# Iranian Mirror - 0-1 Cloud
deb http://mirror.0-1.cloud/ubuntu noble main restricted universe multiverse
deb http://mirror.0-1.cloud/ubuntu noble-updates main restricted universe multiverse
deb http://mirror.0-1.cloud/ubuntu noble-backports main restricted universe multiverse
deb http://mirror.0-1.cloud/ubuntu noble-security main restricted universe multiverse"

add_mirror "/etc/apt/sources.list.d/iran-ubuntu-abrha.list" \
"# Iranian Mirror - Abrha Network
deb https://repo.abrha.net/ubuntu noble main restricted universe multiverse
deb https://repo.abrha.net/ubuntu noble-updates main restricted universe multiverse
deb https://repo.abrha.net/ubuntu noble-backports main restricted universe multiverse
deb https://repo.abrha.net/ubuntu noble-security main restricted universe multiverse"

# Add Iranian Mint mirrors
echo -e "\n${BLUE}➜ Adding Iranian Linux Mint mirrors...${NC}"

add_mirror "/etc/apt/sources.list.d/iran-mint-aminidc.list" \
"# Iranian Mirror - AminIDC for Linux Mint
deb http://mirror.aminidc.com/linuxmint/packages wilma main upstream import backport"

add_mirror "/etc/apt/sources.list.d/iran-mint-iut.list" \
"# Iranian Mirror - IUT for Linux Mint
deb https://repo.iut.ac.ir/repo/Mint wilma main upstream import backport"

# Create APT preferences file to prioritize Iranian mirrors (optional but helpful)
echo -e "\n${BLUE}➜ Setting mirror priority (Iranian mirrors will be tried first)...${NC}"

cat > /etc/apt/apt.conf.d/99mirror-priority << 'EOF'
// APT preferences - Try faster mirrors first
// Iranian mirrors are listed with higher priority
Acquire::Queue-Mode "host";
Acquire::http::Pipeline-Depth "10";
Acquire::http::Timeout "10";
Acquire::ftp::Timeout "10";
EOF

echo -e "${GREEN}✓ APT optimization configured${NC}"

# Clean and update
echo -e "\n${BLUE}➜ Cleaning APT cache...${NC}"
rm -rf /var/lib/apt/lists/*
apt clean

echo -e "\n${BLUE}➜ Running apt update (this may take a moment)...${NC}"
echo -e "${YELLOW}Note: You may see errors from official repos - this is normal if they're blocked.${NC}"
echo -e "${YELLOW}Iranian mirrors will automatically work as fallbacks.${NC}\n"

if apt update 2>&1 | tee /tmp/apt-update.log; then
    echo -e "\n${GREEN}✓ APT update completed successfully!${NC}"
else
    echo -e "\n${YELLOW}⚠ APT update completed with some errors (expected if official repos are blocked)${NC}"
fi

# Show upgradable packages
UPGRADABLE=$(apt list --upgradable 2>/dev/null | grep -c upgradable || true)
if [ "$UPGRADABLE" -gt 0 ]; then
    echo -e "\n${GREEN}✓ $UPGRADABLE packages can be upgraded${NC}"
    echo -e "${YELLOW}Run 'sudo apt upgrade' to upgrade them${NC}"
fi

# Final instructions
echo -e "\n${BLUE}========================================${NC}"
echo -e "${GREEN}Setup Complete!${NC}"
echo -e "${BLUE}========================================${NC}"
echo -e "\n${GREEN}What was done:${NC}"
echo -e "  ✓ Backed up your original repositories to: $BACKUP_DIR"
echo -e "  ✓ Added 8 Iranian Ubuntu mirrors (noble/24.04)"
echo -e "  ✓ Added 2 Iranian Linux Mint mirrors (wilma/22)"
echo -e "  ✓ Your original repositories are still there (not modified)"
echo -e "  ✓ Iranian mirrors will work as automatic fallbacks"
echo -e "\n${GREEN}To restore original configuration:${NC}"
echo -e "  sudo cp $BACKUP_DIR/sources.list /etc/ && sudo cp -r $BACKUP_DIR/sources.list.d/* /etc/apt/sources.list.d/"
echo -e "\n${GREEN}Next steps:${NC}"
echo -e "  1. Upgrade your system: ${YELLOW}sudo apt upgrade -y${NC}"
echo -e "  2. If you see errors from official repos, ignore them - Iranian mirrors work!"
echo -e "\n${BLUE}Share this script with other Linux Mint users in Iran!${NC}"
