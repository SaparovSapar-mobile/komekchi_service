import 'package:flutter/material.dart';
import 'package:komekchi_service/features/presentation/pages/auth/parts/auth_helper.dart';

/// Label + text field row, used for the name/address/note inputs on
/// [SelectedDate].
class LabeledInputField extends StatelessWidget {
  final String label;
  final Color textColor;
  final TextEditingController controller;
  final Color inputBg;
  final Color borderColor;
  final Color hintColor;
  final String hint;
  final TextInputType keyboardType;
  final bool readOnly;
  final Widget? suffix;
  final VoidCallback? onTap;

  const LabeledInputField({
    super.key,
    required this.label,
    required this.textColor,
    required this.controller,
    required this.inputBg,
    required this.borderColor,
    required this.hintColor,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.suffix,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        inputField(
          context: context,
          controller: controller,
          inputBg: inputBg,
          borderColor: borderColor,
          textColor: textColor,
          hintColor: hintColor,
          text: hint,
          keyboardType: keyboardType,
          readOnly: readOnly,
          suffix: suffix,
          onTap: onTap,
        ),
      ],
    );
  }
}
