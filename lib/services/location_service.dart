import 'package:location/location.dart';
import '../models/location_result.dart';

class LocationService {
  final Location _location = Location();
  Future<LocationResult> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    // TODO 1: ตรวจสอบว่า Location Service เปิดอยู่หรือไม่
    // หากปิดอยู่ ให้ขอเปิดด้วย requestService()
    // หากผู้ใช้ไม่เปิด ให้ throw Exception
    // TODO 2: ตรวจสอบ Permission ด้วย hasPermission()
    // หากยังไม่ได้รับอนุญาต ให้เรียก requestPermission()
    // TODO 3: หาก Permission ถูกปฏิเสธ ให้ throw Exception
    // TODO 4: เรียก getLocation() เพื่ออ่านข้อมูลตำแหน่ง
    // TODO 5: ตรวจสอบ latitude และ longitude ว่าไม่เป็น null
    // TODO 6: คืนค่า LocationResult
    // throw UnimplementedError();


    serviceEnabled = await _location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      
      if (!serviceEnabled) throw Exception("location Service is disabled");
    }

    permissionGranted = await _location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
    }
    
    if (permissionGranted != PermissionStatus.granted && permissionGranted != PermissionStatus.grantedLimited) throw Exception("Location permission denied");
    
    final data = await _location.getLocation();
    
    if (data.latitude == null || data.longitude == null) throw Exception("Unable to get location");
    
    return LocationResult(latitude: data.latitude, longitude: data.longitude, updateAt: DateTime.now());
  }
}
