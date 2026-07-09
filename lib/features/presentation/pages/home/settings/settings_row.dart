import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class SettingsRow extends StatelessWidget {
  final String image;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget trailing;
  final VoidCallback? onTap;
  final bool isLast;

  const SettingsRow({
    required this.image,
    required this.iconColor,
    required this.title,
    required this.trailing,
    this.subtitle,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // final textColor = AppColor.titleText(context);
    final cardBg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final TextStyle textStyle = AppTextStyle.medium12;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 20.0 : 10.0),
      child: SizedBox(
        height: 40,
        child: ListTile(
          onTap: onTap,
          leading: SizedBox(
            width: 26,
            height: 26,
            child: Container(
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: 16,
                height: 16,
                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),
          ),
          title: Text(
            title,
            style: textStyle.copyWith(color: AppColor.titleText(context)),
          ),
          subtitle: subtitle != null
              ? Padding(
                padding: const EdgeInsets.only(bottom:  3.0),
                child: Text(
                    subtitle!,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
              )
              : null,
          trailing: trailing,
        ),
      ),
    );
  }
}
