import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';

import '../../../../../core/utils/theme/app_colors.dart';

// ============================================================
// МОДЕЛЬ ЛОКАЦИИ
// ============================================================
class LocationItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isAdd;

  const LocationItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.isAdd = false,
  });
}

// ============================================================
// ВИДЖЕТ ДИАЛОГА
// ============================================================
class SalgymLocationDialog extends StatelessWidget {
  const SalgymLocationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = [
      const LocationItem(
        title: 'Salgym',
        subtitle: 'Ýeriňizi giriziň',
        icon: Icons.add,
        iconColor: AppColor.primary,
        isAdd: true,
      ),
      const LocationItem(
        title: 'Salgym',
        subtitle: 'Iş ýerim',
        icon: Icons.location_on,
        iconColor: Color(0xFF3D3DC4),
      ),
    ];

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColor.primary,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: locations
              .map((loc) => _LocationTile(item: loc))
              .toList(),
        ),
      ),
    );
  }
}

class _LocationTile extends StatelessWidget {
  final LocationItem item;

  const _LocationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // Иконка слева
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              color: item.iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),

          // Текст по центру
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3D3DC4),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF555555),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: Color(0xFF555555),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Колокольчик справа
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.notifications,
              color: Color(0xFF3D3DC4),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}