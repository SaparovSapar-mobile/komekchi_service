import 'package:flutter/material.dart';

/// "Töleg şekili" dropdown-style tappable field, used on [SelectedDate].
class PaymentTypeField extends StatelessWidget {
  final Color cardBg;
  final Color textColor;
  final String? selected;
  final String hint;
  final VoidCallback onTap;

  const PaymentTypeField({
    super.key,
    required this.cardBg,
    required this.textColor,
    required this.selected,
    required this.hint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selected ?? hint,
                style: TextStyle(
                  fontSize: 15,
                  color: selected != null ? textColor : Colors.grey.shade400,
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey.shade500),
          ],
        ),
      ),
    );
  }
}
