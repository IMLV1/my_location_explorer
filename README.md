# My Location Explorer

แอป Flutter สำหรับ Lab 8 แสดงตำแหน่งปัจจุบันของผู้ใช้บนแผนที่ OpenStreetMap

## ผู้จัดทำ

- ชื่อ–นามสกุล: ธีธัช ปิตานุพงศ์
- รหัสนักศึกษา: 6630300394

## การเตรียมเครื่อง

1. ติดตั้ง Flutter SDK ที่รองรับ Dart ตาม `pubspec.yaml` (`^3.12.2`)
2. ติดตั้ง Android Studio และเตรียม Android Emulator หรือเชื่อมต่อโทรศัพท์ Android ที่เปิด USB debugging
3. ตรวจสอบความพร้อมด้วยคำสั่ง `flutter doctor`

หากรันบน iOS ต้องใช้ macOS พร้อม Xcode และอุปกรณ์หรือ Simulator ที่ตั้งค่าพร้อมใช้งาน

## วิธีติดตั้ง Package

เปิด Terminal ในโฟลเดอร์ `my_location_explorer` แล้วติดตั้ง Package ที่ระบุไว้ในโปรเจกต์:

```bash
flutter pub get
```

| Package | หน้าที่ |
| --- | --- |
| location | ตรวจสอบบริการตำแหน่ง ขอ Permission และอ่านพิกัดอุปกรณ์ |
| flutter_map | แสดงแผนที่ OpenStreetMap และ Marker |
| latlong2 | สร้างข้อมูลพิกัด LatLng |
| intl | จัดรูปแบบวันที่และเวลาอัปเดตตำแหน่ง |

หากเริ่มจากโปรเจกต์ใหม่ สามารถเพิ่ม Package ด้วยคำสั่งต่อไปนี้ (โปรเจกต์นี้เพิ่มไว้แล้ว):

```bash
flutter pub add location
flutter pub add flutter_map
flutter pub add latlong2
flutter pub add intl
```

## วิธีรันแอป

1. เปิด Emulator หรือเชื่อมต่ออุปกรณ์จริง
2. ตรวจสอบอุปกรณ์ที่พร้อมใช้งาน:

   ```bash
   flutter devices
   ```

3. รันแอปจากโฟลเดอร์โปรเจกต์:

   ```bash
   flutter run
   ```

   หากต้องการเลือกอุปกรณ์ ให้แทน `DEVICE_ID` ด้วยรหัสจาก `flutter devices`:

   ```bash
   flutter run -d DEVICE_ID
   ```

4. เปิดบริการ Location ของอุปกรณ์ และอนุญาตสิทธิ์เข้าถึงตำแหน่งเมื่อแอปร้องขอ
5. กดปุ่มอ่านตำแหน่งเพื่อดู Latitude, Longitude และเวลาอัปเดต จากนั้นกดดูบนแผนที่เพื่อแสดง Marker

ต้องเชื่อมต่ออินเทอร์เน็ตเพื่อโหลดแผนที่ หากใช้ Emulator ให้กำหนดตำแหน่งจำลองในเครื่องมือของ Emulator ก่อนทดสอบ
