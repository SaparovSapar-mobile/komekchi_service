import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:komekchi_service/features/presentation/pages/auth/auth_screen.dart.dart';

Widget inputField({
  required TextEditingController controller,
  String? text,
  required Color inputBg,
  required Color borderColor,
  required Color textColor,
  required Color hintColor,
  FieldType type = FieldType.text,
  bool obscure = false,
  TextInputType keyboardType = TextInputType.text,
  Widget? suffix,
  String? Function(String?)? validator,
}) {
  return Container(
    height: 52,
    decoration: BoxDecoration(
      color: inputBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: borderColor),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            inputFormatters: type == FieldType.phone
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                  ]
                : [],
            validator:
                validator ??
                (type == FieldType.phone
                    ? (value) {
                        if (value == null || value.length < 8) {
                          return "Dolzhno byt 8 cifr";
                        }
                        return null;
                      }
                    : null),
            style: TextStyle(color: textColor, fontSize: 15),
            decoration: InputDecoration(
              hintText: text,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              hintStyle: TextStyle(color: hintColor),
            ),
          ),
        ),
        if (suffix != null) suffix,
      ],
    ),
  );
}

Widget codeBox(String code, Color textColor, Color inputBg, Color borderColor) {
  return Container(
    height: 52,
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      color: inputBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: borderColor),
    ),
    child: Center(
      child: Text(
        code,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}


enum FieldType { phone, code, text }

