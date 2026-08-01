import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Office location shown on the map card below.
const double _officeLat = 37.955645;
const double _officeLon = 58.425630;

Future<void> _openOfficeInMaps() async {
  final uri = Uri.parse('https://www.google.com/maps?q=$_officeLat,$_officeLon');
  await launchUrl(uri);
}

/// "Karta salgymyz" card: static map image + address, both tap to open the
/// office location in Google Maps.
class OfficeMapCard extends StatelessWidget {
  final Color cardBg;
  final Color subTextColor;

  const OfficeMapCard({
    super.key,
    required this.cardBg,
    required this.subTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Map placeholder
          GestureDetector(
            onTap: _openOfficeInMaps,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Image.asset('assets/images/service/map.png'),
                ),
              ),
            ),
          ),
          // Address row
          GestureDetector(
            onTap: _openOfficeInMaps,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF007AFF),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Aşgabat şäheri, Berkararlyk etraby, 2127 (G.Gulyýew) köçe, 25",
                      style: TextStyle(fontSize: 13, color: subTextColor),
                    ),
                  ),
                  const Icon(
                    Icons.north_east,
                    size: 18,
                    color: Color(0xFF007AFF),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
