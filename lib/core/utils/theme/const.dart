import 'package:flutter/material.dart';

import 'app_colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? AppColor.bgPageDark : AppColor.bgPageLight,
      height: 6,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
    );
  }
}
