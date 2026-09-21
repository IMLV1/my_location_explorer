import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PackageInfoPage extends StatefulWidget {
  const PackageInfoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return PackageInfoPageState();
  }
}

class PackageInfoPageState extends State<PackageInfoPage> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.extension),
      title: const Text('location'),
      subtitle: const Text(
        'อ่านตำแหน่งและจัดการ Permission ของอุปกรณ์',
      ),
    );
  }
}