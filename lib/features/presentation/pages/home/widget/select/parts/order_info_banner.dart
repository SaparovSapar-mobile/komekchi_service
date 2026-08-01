import 'package:flutter/material.dart';

/// Orange info banner shown above the order form fields on [SelectedDate].
class OrderInfoBanner extends StatelessWidget {
  final Color cardBg;
  final String text;

  const OrderInfoBanner({super.key, required this.cardBg, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF6F8FD), width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Image.asset(
                "assets/images/icon/i.png",
                width: 15.0,
                height: 15.0,
              ),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFFF6600),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
