import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/utils/theme/app_colors.dart';

/// Yandex Static Maps works in Turkmenistan without a VPN and without an
/// API key for basic tile rendering. The Geocoder, however, does require a
/// key (confirmed: it responds "Missing apikey" rather than being blocked).
/// Once a key is obtained, drop it here and reverse geocoding turns on
/// automatically — until then we fall back to showing raw coordinates.
const String _yandexGeocoderApiKey = '';

class MapScreen extends StatefulWidget {
  final ValueChanged<String> onLocationSelected;
  const MapScreen({required this.onLocationSelected});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double _centerLat = 37.9601;
  double _centerLon = 58.3261;
  int _zoom = 16;

  Offset _dragOffset = Offset.zero;
  // Yandex Static Maps caps the requested image at 650x450 px. We request
  // it at the screen's aspect ratio (within that cap) and stretch the
  // result with BoxFit.cover to actually fill the screen — _displayScale
  // is how much larger the shown image is than the one we requested.
  Size _mapSize = const Size(650, 450);
  double _displayScale = 1;

  bool _isLocating = true;
  bool _isGeocoding = false;
  String _selectedAddress = '';
  final Dio _geoDio = Dio();

  @override
  void initState() {
    super.initState();
    _getMyLocation();
  }

  @override
  void dispose() {
    _geoDio.close();
    super.dispose();
  }

  String get _staticMapUrl =>
      'https://static-maps.yandex.ru/1.x/?ll=$_centerLon,$_centerLat'
      '&z=$_zoom&size=${_mapSize.width.round()},${_mapSize.height.round()}&l=map';

  // Standard spherical Web Mercator pixel projection (same convention used
  // by Yandex/Google/OSM slippy tiles) — lets us turn a drag gesture in
  // screen pixels into a new center lat/lon at the current zoom.
  double _lonToWorldX(double lon, int z) => (lon + 180.0) / 360.0 * (256 << z);

  double _latToWorldY(double lat, int z) {
    final latRad = lat * math.pi / 180;
    final y = (1 - math.log(math.tan(latRad) + 1 / math.cos(latRad)) / math.pi) / 2;
    return y * (256 << z);
  }

  double _worldXToLon(double x, int z) => x / (256 << z) * 360.0 - 180.0;

  double _worldYToLat(double y, int z) {
    final n = math.pi - 2 * math.pi * y / (256 << z);
    return 180.0 / math.pi * math.atan(0.5 * (math.exp(n) - math.exp(-n)));
  }

  void _panCenterBy(Offset screenDelta) {
    // The displayed image is scaled up from the requested (Yandex-capped)
    // size to fill the screen, so a screen-pixel drag covers more native
    // map pixels than its raw distance — divide out that scale first.
    final nativeDelta = screenDelta / _displayScale;
    final worldX = _lonToWorldX(_centerLon, _zoom) - nativeDelta.dx;
    final worldY = _latToWorldY(_centerLat, _zoom) - nativeDelta.dy;
    _centerLon = _worldXToLon(worldX, _zoom);
    _centerLat = _worldYToLat(worldY, _zoom);
  }

  void _onPanEnd() {
    setState(() {
      _panCenterBy(_dragOffset);
      _dragOffset = Offset.zero;
    });
    _reverseGeocode(_centerLat, _centerLon);
  }

  Future<void> _reverseGeocode(double lat, double lon) async {
    setState(() {
      _selectedAddress = '${lat.toStringAsFixed(5)}, ${lon.toStringAsFixed(5)}';
    });

    if (_yandexGeocoderApiKey.isEmpty) return;

    setState(() => _isGeocoding = true);
    try {
      final response = await _geoDio.get(
        'https://geocode-maps.yandex.ru/1.x/',
        queryParameters: {
          'apikey': _yandexGeocoderApiKey,
          'geocode': '$lon,$lat',
          'format': 'json',
          'lang': 'ru_RU',
        },
      );
      final members = response.data['response']['GeoObjectCollection']
          ['featureMember'] as List?;
      final address = members?.isNotEmpty == true
          ? members!.first['GeoObject']['metaDataProperty']
              ['GeocoderMetaData']['text'] as String?
          : null;
      if (!mounted) return;
      setState(() {
        if (address != null && address.isNotEmpty) _selectedAddress = address;
        _isGeocoding = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isGeocoding = false);
    }
  }

  Future<void> _getMyLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLocating = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _isLocating = false);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;
      setState(() {
        _centerLat = position.latitude;
        _centerLon = position.longitude;
        _isLocating = false;
      });
      _reverseGeocode(_centerLat, _centerLon);
    } catch (_) {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E9F0),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final availW = constraints.maxWidth;
          final availH = constraints.maxHeight;
          final screenAspect = availW / availH;
          const maxW = 650.0;
          const maxH = 450.0;

          if (screenAspect <= maxW / maxH) {
            _mapSize = Size(maxH * screenAspect, maxH);
          } else {
            _mapSize = Size(maxW, maxW / screenAspect);
          }
          _displayScale = availH / _mapSize.height;

          return Stack(
            children: [
              // ===== KARTA =====
              Positioned.fill(
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() => _dragOffset += details.delta);
                  },
                  onPanEnd: (_) => _onPanEnd(),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRect(
                        child: Transform.translate(
                          offset: _dragOffset,
                          child: Image.network(
                            _staticMapUrl,
                            key: ValueKey(_staticMapUrl),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xFFE5E9F0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Karta ýüklenip bilmedi',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Fixed center pin — the map moves under it.
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 36),
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ===== ZOOM =====
              Positioned(
                bottom: 190,
                right: 16,
                child: Column(
                  children: [
                    _RoundIconButton(
                      icon: Icons.add,
                      onTap: () {
                        setState(() => _zoom = math.min(_zoom + 1, 19));
                      },
                    ),
                    const SizedBox(height: 8),
                    _RoundIconButton(
                      icon: Icons.remove,
                      onTap: () {
                        setState(() => _zoom = math.max(_zoom - 1, 3));
                      },
                    ),
                  ],
                ),
              ),

              // ===== LOADING =====
              if (_isLocating) const Center(child: CircularProgressIndicator()),

              // ===== NAZAD =====
              Positioned(
                top: 50,
                left: 16,
                child: _RoundIconButton(
                  icon: Icons.arrow_back_ios_new,
                  iconSize: 18,
                  onTap: () => Navigator.pop(context),
                ),
              ),

              // ===== KNOPKA MOEGO MESTOPOLOZHENIYA =====
              Positioned(
                bottom: 130,
                right: 16,
                child: _RoundIconButton(
                  icon: Icons.my_location,
                  iconColor: Colors.blue,
                  onTap: _getMyLocation,
                ),
              ),

              // ===== TASSYKLAMAK =====
              Positioned(
                bottom: 30,
                left: 16,
                right: 16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
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
                      child: Row(
                        children: [
                          if (_isGeocoding) ...[
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Expanded(
                            child: Text(
                              _selectedAddress,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 52,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _selectedAddress.isEmpty
                            ? null
                            : () {
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
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double iconSize;
  final Color iconColor;

  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    this.iconSize = 22,
    this.iconColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
          ],
        ),
        child: Icon(icon, size: iconSize, color: iconColor),
      ),
    );
  }
}
