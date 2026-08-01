import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import '../../../../../../l10n/gen/app_localizations.dart';
import '../settings_card.dart';

/// "Meniň sahypam" (diňe agza bolan ulanyjylar üçin)
class MyPageSection extends StatelessWidget {
  final String? userName;

  const MyPageSection({super.key, this.userName});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgPageLight;
    final textStyle = AppTextStyle.medium12;
    final t = AppLocalizations.of(context)!;

    return SectionCard(
      text: t.myPage,
      children: [
        ListTile(
          leading: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.person, color: AppColor.primary),
          ),
          title: Text(
            userName ?? t.user,
            style: textStyle.copyWith(color: AppColor.titleText(context)),
          ),
          subtitle: Text(
            t.user,
            style: TextStyle(
              fontSize: 13,
              color: AppColor.descriptionText(context),
            ),
          ),
        ),
      ],
    );
  }
}
