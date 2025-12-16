#!/bin/bash

# Build script for DDOS IPA
# Creates an IPA package for iOS installation with valid Mach-O binary

set -e

APP_NAME="DDOS"
BUILD_DIR="build"
PAYLOAD_DIR="$BUILD_DIR/Payload"
APP_DIR="$PAYLOAD_DIR/$APP_NAME.app"

echo "🔨 Building $APP_NAME.ipa..."

# Clean previous builds
rm -f *.ipa *.deb *.dylib
rm -rf "$BUILD_DIR"
mkdir -p "$APP_DIR"

# Copy Info.plist
echo "📋 Copying Info.plist..."
cp Info.plist "$APP_DIR/"

# Copy entitlements
cp entitlements.xml "$APP_DIR/" 2>/dev/null || true

# Check if we're on macOS with iOS SDK
if command -v xcrun &> /dev/null; then
    echo "📦 Compiling executable with Xcode..."
    
    clang -arch arm64 -arch arm64e \
        -isysroot $(xcrun --sdk iphoneos --show-sdk-path) \
        -miphoneos-version-min=7.0 \
        -fobjc-arc \
        -framework UIKit \
        -framework Foundation \
        -framework UserNotifications \
        -o "$APP_DIR/$APP_NAME" \
        main.m DDOS.m DDOS.mm
    
    echo "✅ Compiled successfully!"
    
    # Sign the binary
    if command -v ldid &> /dev/null; then
        echo "✍️  Signing binary..."
        ldid -Sentitlements.xml "$APP_DIR/$APP_NAME"
        echo "✅ Signed with ldid"
    fi
else
    echo "⚠️  iOS SDK not found - creating Mach-O binary stub..."
    
    # Create minimal Mach-O binary stub using Python
    if command -v python3 &> /dev/null; then
        python3 create_stub.py "$APP_DIR/$APP_NAME"
        chmod +x "$APP_DIR/$APP_NAME"
        echo "✅ Created Mach-O binary stub (valid for signing)"
        echo "⚠️  Note: This is a stub binary. For full functionality, compile on macOS"
    else
        echo "❌ Python3 not found. Cannot create binary stub."
        echo "   Install python3 or compile on macOS with Xcode"
        exit 1
    fi
fi

# Create IPA
echo "📦 Creating IPA package..."
cd "$BUILD_DIR"
zip -qr "../$APP_NAME.ipa" Payload
cd ..

echo ""
echo "✅ Build complete!"
echo "📦 Output: $APP_NAME.ipa"
echo ""
echo "📱 Install with: TrollStore, ESign, Sideloadly, or AltStore"
echo ""
ls -lh "$APP_NAME.ipa"

