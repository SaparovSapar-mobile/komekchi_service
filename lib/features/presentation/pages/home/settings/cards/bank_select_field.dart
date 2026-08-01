import 'package:flutter/material.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import 'card_model.dart';

/// Тапабельное поле "Bank saýla" — открывает bottom sheet со списком банков.
class BankSelectField extends StatelessWidget {
  final BankOption selected;
  final ValueChanged<BankOption> onChanged;

  const BankSelectField({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final inputBg = AppColor.pageBg(context);
    final borderColor = AppColor.border(context);
    final textColor = AppColor.titleText(context);

    return GestureDetector(
      onTap: () => _showBankSheet(context),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: inputBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Image.asset(selected.logo, width: 55, height: 50),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                selected.name,
                style: TextStyle(color: textColor, fontSize: 15),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: textColor),
          ],
        ),
      ),
    );
  }

  void _showBankSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        final bg = AppColor.cardBg(context);
        final textColor = AppColor.titleText(sheetContext);

        return Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Bank saýlaň',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              ...kBanks.map((bank) {
                final isSelected = bank.name == selected.name;
                return InkWell(
                  onTap: () {
                    onChanged(bank);
                    Navigator.pop(sheetContext);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Image.asset(bank.logo, width: 67, height: 46),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            bank.name,
                            style: TextStyle(fontSize: 15, color: textColor),
                          ),
                        ),
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: isSelected
                              ? AppColor.primary
                              : Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
