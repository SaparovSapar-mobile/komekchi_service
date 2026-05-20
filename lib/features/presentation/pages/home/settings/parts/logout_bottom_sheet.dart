import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';

class LogOutBottomSheet extends StatefulWidget {
  final ValueChanged<bool> onSelected;

  const LogOutBottomSheet({super.key, required this.onSelected});

  @override
  State<LogOutBottomSheet> createState() => _LogOutBottomSheetState();
}

class _LogOutBottomSheetState extends State<LogOutBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = AppTextStyle.semiBold18;
    final TextStyle textStyle1 = AppTextStyle.semiBold16;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColor.titleText(context);
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgPageLight;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Container(
            width: 56,
            height: 6,
            decoration: BoxDecoration(
              color: Color(0xFFD1D1D1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              const SizedBox(height: 10),

              // Warning icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  shape: BoxShape.circle,
                ),
                child: Image.asset("assets/images/logo/!.png"),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                'Siz hakykatdan hem ulgamdan \nçykmak isleýärsiňizmi?',
                textAlign: TextAlign.center,
                style: textStyle.copyWith(color: AppColor.titleText(context)),
              ),
              const SizedBox(height: 22),

              // Buttons row
              Row(
                children: [
                  // Yok button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onSelected(false);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: bg.withOpacity(0.80),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:  Text(
                        'Ýok',
                        style: textStyle1.copyWith(color: AppColor.titleText(context)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Howa button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onSelected(true);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: AppColor.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:  Text(
                        'Howa',
                        style: textStyle1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
            ],
          ),
        ),
      ],
    );
  }
}
