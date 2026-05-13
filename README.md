# IR-MintMirror - Iranian Mirrors for Linux Mint 22

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Linux Mint 22](https://img.shields.io/badge/Linux%20Mint-22-blue.svg)](https://linuxmint.com/)
[![Iranian Mirrors](https://img.shields.io/badge/Iranian-Mirrors-green.svg)](https://github.com/SaintScraTchY/IR-MintMirror)

**Automatic Iranian mirror configuration for Linux Mint 22 (Wilma)** – Adds domestic mirrors as fallbacks without removing official repositories. Perfect for Iranian users facing international connection issues.

## 📋 Table of Contents
- [Who This Is For](#-who-this-is-for)
- [What This Script Does](#-what-this-script-does)
- [Mirrors Included](#-mirrors-included)
- [Quick Installation](#-quick-installation)
- [Step-by-Step Guide](#-step-by-step-guide)
- [What to Expect](#-what-to-expect)
- [Verification](#-verification)
- [Restore Backup](#-restore-backup)
- [FAQ](#-faq)
- [Share This Project](#-share-this-project)

## 🎯 Who This Is For

| **Compatible Systems** | **Version** | **Codename** |
|------------------------|-------------|--------------|
| Linux Mint 22 | 22.x | Wilma |
| Linux Mint 22.1 | 22.1 | Xia |
| Ubuntu 24.04 (limited) | 24.04 | Noble |

**⚠️ Important:** This script is specifically designed for **Linux Mint 22 (Wilma)**. It may work on Ubuntu 24.04 but is not fully tested.

**🇮🇷 Primary Audience:** Iranian Linux users who experience:
- Slow or failed connections to international Ubuntu/Mint repositories
- Timeouts when running `sudo apt update`
- Need for domestic mirror fallbacks

## ✅ What This Script Does

| **Action** | **Safe?** | **Description** |
|------------|-----------|-----------------|
| Creates backup | ✅ Yes | Saves your original repository configuration |
| Adds Iranian mirrors | ✅ Yes | Creates NEW files in `/etc/apt/sources.list.d/` |
| Keeps official repos | ✅ Yes | **Nothing is removed or commented out** |
| Sets timeouts | ✅ Yes | Prevents hanging on slow connections |
| Runs apt update | ✅ Yes | Tests the new configuration |

**❌ What it DOES NOT do:**
- Remove or modify your existing repositories
- Replace official Ubuntu/Mint repos
- Force you to use only Iranian mirrors
- Break your system configuration

## 🪞 Mirrors Included

### Ubuntu 24.04 (Noble) Mirrors – 8 Iranian Mirrors

| # | Mirror Name | URL | Type |
|---|-------------|-----|------|
| 1 | ArvanCloud | `http://mirror.arvancloud.ir/ubuntu` | 🇮🇷 High-speed |
| 2 | Shatel | `http://mirror.shatel.ir/ubuntu` | 🇮🇷 ISP |
| 3 | AtlantisCloud | `http://mirror.atlantiscloud.ir/ubuntu` | 🇮🇷 Cloud |
| 4 | KimiaHost | `http://ubuntu-mirror.kimiahost.com/ubuntu` | 🇮🇷 Hosting |
| 5 | DigitalVPS | `http://mirror.digitalvps.ir/ubuntu` | 🇮🇷 VPS |
| 6 | Sindad Cloud | `https://ir.ubuntu.sindad.cloud` | 🇮🇷 HTTPS |
| 7 | 0-1 Cloud | `http://mirror.0-1.cloud/ubuntu` | 🇮🇷 Cloud |
| 8 | Abrha Network | `https://repo.abrha.net/ubuntu` | 🇮🇷 Network |

**Each mirror includes 4 suites:** `noble`, `noble-updates`, `noble-backports`, `noble-security`

### Linux Mint 22 (Wilma) Mirrors – 2 Iranian Mirrors

| # | Mirror Name | URL | Type |
|---|-------------|-----|------|
| 1 | AminIDC | `http://mirror.aminidc.com/linuxmint/packages` | 🇮🇷 Hosting |
| 2 | IUT | `https://repo.iut.ac.ir/repo/Mint` | 🇮🇷 University |

**Each includes:** `wilma main upstream import backport`

### Total Repository Lines Added
- **Ubuntu:** 8 mirrors × 4 suites = 32 repository lines
- **Mint:** 2 mirrors × 1 suite = 2 repository lines
- **Total:** 34 new repository entries (all as fallbacks)

## 🚀 Quick Installation

### One-Line Install (Easiest)
```bash
wget -O setup-iranian-mirrors.sh https://raw.githubusercontent.com/SaintScraTchY/IR-MintMirror/main/setup-iranian-mirrors.sh && sudo bash setup-iranian-mirrors.sh

### Using curl (if wget not available)
```bash
curl -o setup-iranian-mirrors.sh https://raw.githubusercontent.com/SaintScraTchY/IR-MintMirror/main/setup-iranian-mirrors.sh && sudo bash setup-iranian-mirrors.sh
```

### Manual Download
```bash
# Download
wget https://raw.githubusercontent.com/SaintScraTchY/IR-MintMirror/main/setup-iranian-mirrors.sh

# Make executable
chmod +x setup-iranian-mirrors.sh

# Run with sudo
sudo ./setup-iranian-mirrors.sh
```

## 📖 Step-by-Step Guide for Beginners

### Step 1: Open Terminal
- Press `Ctrl + Alt + T` on your keyboard
- Or find "Terminal" in your application menu

### Step 2: Download and Run
Copy and paste this entire line into terminal, then press `Enter`:
```bash
wget -O setup-iranian-mirrors.sh https://raw.githubusercontent.com/SaintScraTchY/IR-MintMirror/main/setup-iranian-mirrors.sh && sudo bash setup-iranian-mirrors.sh
```

### Step 3: Enter Your Password
- When prompted, type your user password (you won't see it as you type)
- Press `Enter`

### Step 4: Wait for Completion
- The script will show colored output as it works
- It will automatically run `sudo apt update`
- Total time: a few seconds or a few minutes depending your internet connection or old your repositories were

### Step 5: Upgrade Your System (Optional but Recommended)
```bash
sudo apt upgrade -y
```

## 👀 What to Expect

### Normal Output (Successful)
```
========================================
Iranian Mirrors Setup for Linux Mint 22
========================================

✓ Backup directory created: /etc/apt/backup-20260113-120000
✓ Existing repositories backed up

➜ Adding Iranian Ubuntu mirrors...
✓ Added: iran-ubuntu-arvancloud.list
✓ Added: iran-ubuntu-shatel.list
...

➜ Running apt update...
Hit:1 http://mirror.arvancloud.ir/ubuntu noble InRelease
Get:2 http://mirror.aminidc.com/linuxmint/packages wilma InRelease
...
Fetched 55.9 MB in 41s (1,380 kB/s)
✓ APT update completed successfully!
```

### Expected Errors (Normal – Can Be Ignored)
You may see these errors – they're **not a problem** because Iranian mirrors work:
```
W: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/noble/InRelease
W: Failed to fetch http://security.ubuntu.com/ubuntu/dists/noble-security/InRelease
```
**Why this happens:** Official Ubuntu servers are blocked from Iran. APT automatically tries Iranian mirrors as fallbacks.

## ✅ Verification

### Check if Iranian mirrors were added:
```bash
ls -la /etc/apt/sources.list.d/iran-*
```

### See all configured repositories:
```bash
grep -rh "^deb " /etc/apt/sources.list /etc/apt/sources.list.d/*.list | grep -E "(arvancloud|shatel|atlantis|kimiahost|digitalvps|sindad|0-1|abrha|aminidc|iut)"
```

### Count Iranian mirror lines (should be 34+):
```bash
grep -rh "^deb " /etc/apt/sources.list.d/iran-* | wc -l
```

### Test update speed:
```bash
time sudo apt update
```

## 🔄 Restore Backup

If anything goes wrong (very unlikely), restore your original configuration:

### Find your backup:
```bash
ls -la /etc/apt/backup-*
```

### Restore (replace YYYYMMDD-HHMMSS with actual timestamp):
```bash
sudo cp /etc/apt/backup-YYYYMMDD-HHMMSS/sources.list /etc/apt/
sudo cp -r /etc/apt/backup-YYYYMMDD-HHMMSS/sources.list.d/* /etc/apt/sources.list.d/
```

### Clean and update:
```bash
sudo rm -rf /var/lib/apt/lists/*
sudo apt update
```

## ❓ FAQ

### Q: Will this remove my official repositories?
**A:** No! Nothing is removed or commented out. Iranian mirrors are added as **additional** sources.

### Q: Why do I see errors from archive.ubuntu.com?
**A:** Those are the official Ubuntu servers. They're often blocked from Iran. APT automatically tries Iranian mirrors as fallbacks – the errors are harmless.

### Q: Can I use this on Linux Mint 21 or 20?
**A:** No, this is specifically for Mint 22 (Wilma) which uses Ubuntu 24.04 (Noble). Older versions use different codenames.

### Q: Will this work on Ubuntu 24.04?
**A:** Possibly, but not tested. The Mint mirrors won't work on Ubuntu.

### Q: How do I uninstall?
**A:** Just delete the added files:
```bash
sudo rm /etc/apt/sources.list.d/iran-*.list
sudo rm /etc/apt/apt.conf.d/99mirror-priority
sudo apt update
```

### Q: The script says "Warning: This script is designed for Linux Mint 22"
**A:** That's just a warning. If you're on Mint 22, type `y` to continue. If you're on a different system, don't proceed.

### Q: My apt update is still hanging on some mirrors
**A:** Press `Ctrl + C` to cancel, then run:
```bash
sudo rm -rf /var/lib/apt/lists/*
sudo apt update --fix-missing
```

### Q: Is this Created by AI?
**A:** 😉 yep. (lol)
## 📢 Share This Project

**Help other Linux Mint users in Iran!** Share these links:

- **GitHub Repository:** https://github.com/SaintScraTchY/IR-MintMirror
- **Direct Script:** https://raw.githubusercontent.com/SaintScraTchY/IR-MintMirror/main/setup-iranian-mirrors.sh
- **One-line install:**
  ```bash
  wget -O setup-iranian-mirrors.sh https://raw.githubusercontent.com/SaintScraTchY/IR-MintMirror/main/setup-iranian-mirrors.sh && sudo bash setup-iranian-mirrors.sh
  ```

## 📝 License

MIT License – Free for anyone to use, modify, and share.

## 🙏 Credits

- Mirrors provided by: ArvanCloud, Shatel, AtlantisCloud, KimiaHost, DigitalVPS, Sindad Cloud, 0-1 Cloud, Abrha Network, AminIDC, IUT
- Created for the Iranian Linux community

---

**⭐ Star this repository if it helped you!**
