import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/location_result.dart';

class MapPage extends StatelessWidget {
  final LocationResult locationResult;

  const MapPage({
    super.key,
    required this.locationResult,
  });

  void _showCoordinates(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'You are here',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'Latitude: '
                    '${locationResult.latitude.toStringAsFixed(6)}',
              ),
              const SizedBox(height: 8),
              Text(
                'Longitude: '
                    '${locationResult.longitude.toStringAsFixed(6)}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = LatLng(
      locationResult.latitude,
      locationResult.longitude,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('แผนที่ตำแหน่งปัจจุบัน'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: currentPosition,
          initialZoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate:
            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.my_location_explorer',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: currentPosition,
                width: 150,
                height: 90,
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () => _showCoordinates(context),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'You are here',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.location_on,
                        size: 56,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const RichAttributionWidget(
            attributions: [
              TextSourceAttribution('OpenStreetMap contributors'),
            ],
          ),
        ],
      ),
    );
  }
}