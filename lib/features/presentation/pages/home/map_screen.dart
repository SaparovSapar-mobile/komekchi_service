import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/theme/app_theme.dart';

class MapScreen extends StatefulWidget {
  final ValueChanged<String> onLocationSelected;
  const MapScreen({required this.onLocationSelected});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedPoint;
  LatLng? _myLocation;
  String _selectedAddress = '';
  final MapController _mapController = MapController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getMyLocation();
  }

  Future<void> _getMyLocation() async {
    try {
      // Proverka razresheniy
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLoading = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _isLoading = false);
        return;
      }

      // Poluchaem poziciyu
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final myLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _myLocation = myLatLng;
        _isLoading = false;
      });

      // Peremeschaem kameru na moyo mestopolozhenie
      Future.delayed(const Duration(milliseconds: 300), () {
        _mapController.move(myLatLng, 15);
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ===== KARTA =====
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _myLocation ?? const LatLng(37.9601, 58.3261),
              initialZoom: 14,
              onTap: (tapPosition, point) {
                setState(() {
                  _selectedPoint = point;
                  _selectedAddress =
                      '${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}';
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.yourcompany.yourapp',
              ),
              MarkerLayer(
                markers: [
                  // Moy marker (siniy krug)
                  if (_myLocation != null)
                    Marker(
                      point: _myLocation!,
                      width: 20,
                      height: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Vybrannyy marker (krasnaya bulávka)
                  if (_selectedPoint != null)
                    Marker(
                      point: _selectedPoint!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                ],
              ),
            ],
          ),

          // ===== LOADING =====
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),

          // ===== NAZAD =====
          Positioned(
            top: 50,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 18),
              ),
            ),
          ),

          // ===== KNOPKA MOEGO MESTOPOLOZHENIYA =====
          Positioned(
            bottom: 100,
            right: 16,
            child: GestureDetector(
              onTap: () {
                if (_myLocation != null) {
                  _mapController.move(_myLocation!, 15);
                }
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(Icons.my_location, color: Colors.blue),
              ),
            ),
          ),

          // ===== TASSYKLAMAK =====
          if (_selectedPoint != null)
            Positioned(
              bottom: 30,
              left: 16,
              right: 16,
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onLocationSelected(_selectedAddress);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tassyklamak',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}