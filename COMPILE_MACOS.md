# Hướng dẫn Compile DDOS trên macOS

## Yêu cầu
- macOS với Xcode đã cài đặt
- Command Line Tools: `xcode-select --install`

## Bước 1: Copy files sang macOS

Sao chép các file sau sang macOS:
```
DDOS.h
DDOS.m
DDOS.mm
main.m
encrypt.h
Info.plist
entitlements.xml
build.sh
```

## Bước 2: Compile trên macOS

```bash
cd /path/to/DDOS
chmod +x build.sh
./build.sh
```

Hoặc compile thủ công:

```bash
# Compile binary
clang -arch arm64 -arch arm64e \
      -isysroot $(xcrun --sdk iphoneos --show-sdk-path) \
      -miphoneos-version-min=7.0 \
      -fobjc-arc \
      -framework UIKit \
      -framework Foundation \
      -framework UserNotifications \
      -o DDOS \
      main.m DDOS.m DDOS.mm

# Sign với ldid (cài ldid: brew install ldid)
ldid -Sentitlements.xml DDOS

# Tạo IPA structure
mkdir -p build/Payload/DDOS.app
cp DDOS build/Payload/DDOS.app/
cp Info.plist build/Payload/DDOS.app/
cd build
zip -r ../DDOS.ipa Payload
cd ..
```

## Bước 3: Install với TrollStore

1. Copy `DDOS.ipa` về iPhone
2. Mở TrollStore
3. Install DDOS.ipa
4. Done!

## Lưu ý

- File `DDOS.ipa` hiện tại từ WSL **KHÔNG THỂ** install được vì không có binary thực
- BẮT BUỘC phải compile trên macOS với Xcode
- Sau khi compile, binary sẽ là Mach-O ARM64 và TrollStore mới sign được

## Troubleshooting

**Lỗi: "ldid: Unknown header magic"**
- Nguyên nhân: File executable không phải Mach-O binary
- Giải pháp: Compile lại trên macOS

**Lỗi: "No such file or directory"**
- Kiểm tra đã copy đủ file chưa
- Đảm bảo có file `encrypt.h`
