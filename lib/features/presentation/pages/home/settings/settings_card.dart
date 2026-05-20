import 'package:flutter/material.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import 'settings.dart';

class SectionCard extends StatelessWidget {
  final List<Widget> children;
  final String text;
  const SectionCard({required this.children, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // final textColor = AppColor.titleText(context);
    // final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    // final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: Colors.grey.shade100, width: 0.5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:  11.0, top: 10),
            child: SectionTitle(title: text),
          ),

          Column(children: children),
        ],
      ),
    );
  }
}
