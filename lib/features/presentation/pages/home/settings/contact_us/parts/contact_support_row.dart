import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';

/// "Biz bilen habarlaşmak" tappable row — opens the write-a-letter screen.
class ContactSupportRow extends StatelessWidget {
  final Color cardBg;
  final Color textColor;
  final String label;
  final VoidCallback onTap;

  const ContactSupportRow({
    super.key,
    required this.cardBg,
    required this.textColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.support_agent,
                size: 20,
                color: AppColor.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 20, color: textColor),
          ],
        ),
      ),
    );
  }
}
