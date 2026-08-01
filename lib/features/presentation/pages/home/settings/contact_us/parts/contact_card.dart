import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';

class ContactItem {
  final String image;
  final String text;
  final Color color;

  const ContactItem({
    required this.image,
    required this.text,
    required this.color,
  });
}

/// Card listing [items] as rows (icon + text + external-link arrow),
/// separated by dividers — used for both the "Kontaktlar" and
/// "Social media salgylanmalar" sections.
class ContactCard extends StatelessWidget {
  final Color cardBg;
  final List<ContactItem> items;

  const ContactCard({super.key, required this.cardBg, required this.items});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final dividerColor = isDark
        ? Colors.white12
        : Colors.black.withValues(alpha: 0.08);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return Column(
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 32,
                        height: 32,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColor.bgBlogDark
                              : AppColor.bgBlogLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(item.image, width: 8, height: 8),
                      ),
                      const SizedBox(width: 12),
                      // Text
                      Expanded(
                        child: Text(
                          item.text,
                          style: TextStyle(fontSize: 14, color: textColor),
                        ),
                      ),
                      // Arrow
                      Icon(
                        Icons.north_east,
                        size: 16,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ],
                  ),
                ),
              ),
              if (i < items.length - 1)
                Divider(
                  height: 1,
                  thickness: 0.5,
                  indent: 58,
                  color: dividerColor,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
