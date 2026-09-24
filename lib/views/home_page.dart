import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_location_explorer/views/package_info_page.dart';
import '../models/location_result.dart';
import '../services/location_service.dart';
import 'map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationService _locationService = LocationService();
  LocationResult? _locationResult;
  bool _isLoading = false;
  String? _errorMessage;
  Future<void> _loadLocation() async {

    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final data = await _locationService.getCurrentLocation();

      if (!mounted) return;

      setState(() {
        _locationResult = data;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e
            .toString()
            .replaceFirst(RegExp(r'^Exception:\s*'), '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Location Explorer'),
        actions: [
          IconButton(
            tooltip: 'ข้อมูล Package',
            icon: const Icon(Icons.extension),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => const PackageInfoPage(),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'อ่านตำแหน่งใหม่',
            onPressed: _isLoading ? null : _loadLocation,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 110),
          child: _buildContent(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isLoading ? null : _loadLocation,
        icon: const Icon(Icons.my_location),
        label: const Text('อ่านตำแหน่ง'),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('กำลังอ่านตำแหน่ง...'),
        ],
      );
    }

    if (_errorMessage != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            _errorMessage!,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _loadLocation,
            icon: const Icon(Icons.refresh),
            label: const Text('ลองใหม่'),
          ),
        ],
      );
    }

    final result = _locationResult;

    if (result == null) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_searching,
            size: 72,
            color: Colors.blue,
          ),
          SizedBox(height: 16),
          Text(
            'กดปุ่มเพื่ออ่านตำแหน่งปัจจุบัน',
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    final updatedAt = DateFormat(
      'dd/MM/yyyy HH:mm:ss',
    ).format(result.updateAt);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.location_on,
          color: Colors.green,
          size: 72,
        ),
        const SizedBox(height: 16),
        Text(
          'ตำแหน่งปัจจุบัน',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Latitude: ${result.latitude.toStringAsFixed(6)}',
                ),
                const SizedBox(height: 8),
                Text(
                  'Longitude: ${result.longitude.toStringAsFixed(6)}',
                ),
                const SizedBox(height: 12),
                Text('อัปเดตล่าสุด: $updatedAt'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => MapPage(
                  locationResult: result,
                ),
              ),
            );
          },
          icon: const Icon(Icons.map),
          label: const Text('ดูบนแผนที่'),
        ),
      ],
    );
  }
}
