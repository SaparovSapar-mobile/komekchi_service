import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../detail_screen/map.dart';

class SalgymBar extends StatelessWidget {
  final bool isDark;
  final Color textColor;
  const SalgymBar({super.key, required this.isDark, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    color: isDark ? AppColor.bgBlogDark : AppColor.bgPageLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFF4F2F2)),
                  ),
                  child: Icon(Icons.add_circle, color: AppColor.primary, size: 18,),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Salgym",
                      style: TextStyle(
                        color: isDark ? AppColor.titleDark : AppColor.primary,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Ýeriňizi giriziň ",
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
                    color: isDark ? AppColor.bgBlogDark : AppColor.bgPageLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFF4F2F2)),
                  ),
                  child: Icon(Icons.notifications, color: AppColor.primary, size: 18,),
                ),
          ),
        ],
      ),
    );
  }
}
