import 'package:flutter/material.dart';
import 'package:komekchi_service/features/presentation/pages/auth/parts/auth_helper.dart';

/// Phone label + "+993" code box + phone field, used on [SelectedDate].
class PhoneInputSection extends StatelessWidget {
  final String label;
  final Color textColor;
  final TextEditingController controller;
  final Color inputBg;
  final Color cardBg;
  final Color borderColor;
  final Color hintColor;
  final bool readOnly;
  final Widget? suffix;

  const PhoneInputSection({
    super.key,
    required this.label,
    required this.textColor,
    required this.controller,
    required this.inputBg,
    required this.cardBg,
    required this.borderColor,
    required this.hintColor,
    required this.readOnly,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            codeBox('+993', textColor, cardBg, borderColor),
            const SizedBox(width: 10),
            Expanded(
              child: inputField(
                context: context,
                controller: controller,
                inputBg: inputBg,
                type: FieldType.phone,
                borderColor: borderColor,
                textColor: textColor,
                hintColor: hintColor,
                keyboardType: TextInputType.phone,
                readOnly: readOnly,
                suffix: suffix,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
