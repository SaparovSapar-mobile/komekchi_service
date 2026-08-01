import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../detail_screen/map.dart';

class SalgymBar extends StatelessWidget {
  final bool isDark;
  final Color textColor;
  const SalgymBar({super.key, required this.isDark, required this.textColor});

  @override
  Widget build(BuildContext context) {
     final isDark = Theme.of(context).brightness == Brightness.dark;
       final cardBg = AppColor.cardBg(context);
    final t = AppLocalizations.of(context)!;
    return Container(
      color: cardBg,
      padding: const EdgeInsets.only(bottom: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                showSalgyBottomSheet(context);
              },
              child: Row(
                children: [
                  Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: AppColor.pageBg(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.add_circle, color: AppColor.primary, size: 18,),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.salgymTitle,
                        style: TextStyle(
                          color: isDark ? AppColor.titleDark : AppColor.primary,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            t.salgymEnterLocation,
                            style: TextStyle(color: textColor, fontSize: 16),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 18,
                            color: textColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
      
            const Spacer(),
            GestureDetector(
              onTap: () {
                context.push("/bells");
              },
              child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: AppColor.pageBg(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.notifications, color: AppColor.primary, size: 18,),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
