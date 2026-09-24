import 'package:flutter/material.dart';

class PackageInfoPage extends StatelessWidget {
  const PackageInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Package Information'),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.my_location),
            title: Text('location'),
            subtitle: Text(
              'ตรวจสอบบริการตำแหน่ง ขอ Permission '
                  'และอ่านพิกัดของอุปกรณ์',
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('flutter_map'),
            subtitle: Text(
              'แสดงแผนที่ OpenStreetMap และ Marker',
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.place),
            title: Text('latlong2'),
            subtitle: Text(
              'สร้างข้อมูลพิกัด LatLng '
                  'และรองรับการคำนวณระยะทาง',
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text('intl'),
            subtitle: Text(
              'จัดรูปแบบวันและเวลาที่อ่านตำแหน่งล่าสุด',
            ),
          ),
        ],
      ),
    );
  }
}