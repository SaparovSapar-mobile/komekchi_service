import 'package:flutter/material.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import '../../../auth/parts/auth_helper.dart';

class TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const TabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
     final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor = AppColor.titleText(context);
   
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12, ),
          decoration: BoxDecoration(
            color: isSelected ? cardBg : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? textColor : AppColor.descriptionText(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


 Widget buildEmailField(BuildContext context ,TextEditingController emailController) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final textColor = AppColor.titleText(context);
    return Column(
      key: const ValueKey('email'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'Email salgyňyz',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'example@gmail.com',
            hintStyle: TextStyle(color: AppColor.descriptionText(context), fontSize: 15),
            filled: true,
            fillColor: bg,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.primary, width: 1),
            ),
          ),
        ),
      ],
    );
  }


 Widget buildPhoneField(BuildContext context, TextEditingController regPhoneController) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;
    final inputBg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final hintColor = isDark ? Colors.white38 : Colors.black38;
    return Column(
      key: const ValueKey('phone'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'Telefon belgiňiz',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.titleText(context),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            codeBox('+993', AppColor.titleText(context), inputBg, borderColor),
            const SizedBox(width: 10),
            Expanded(
              child: inputField(
                controller: regPhoneController,
                inputBg: inputBg,
                type: FieldType.phone,
                borderColor: borderColor,
                textColor: AppColor.titleText(context),
                hintColor: hintColor,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
      ],
    );
  }
