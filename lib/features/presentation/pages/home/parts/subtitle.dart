import 'package:flutter/material.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../core/utils/theme/app_text_style.dart';

class Subtitle extends StatelessWidget {
  final String text;
  const Subtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textColor = AppColor.titleText(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(text, style: AppTextStyle.semiBold14.copyWith(color: textColor)),
          SizedBox(width: 7),
          Icon(Icons.keyboard_arrow_right, size: 20, color: textColor),
        ],
      ),
    );
  }
}
