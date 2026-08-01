import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';
import 'package:komekchi_service/l10n/gen/app_localizations.dart';

class BottomSheetShikayat extends StatefulWidget {
  final ValueChanged<bool> onSelected;

  const BottomSheetShikayat({super.key, required this.onSelected});

  @override
  State<BottomSheetShikayat> createState() => _BottomSheetShikayatState();
}

class _BottomSheetShikayatState extends State<BottomSheetShikayat> {
  @override
  Widget build(BuildContext context) {
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    final t = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Container(
            width: 56,
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0xFFD1D1D1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              const SizedBox(height: 20),

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
                t.complainSheetTitle,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 32),

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
                        backgroundColor: AppColor.bgPageDark,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        t.no,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
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
                      child: Text(
                        t.yes,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ],
    );
  }
}
