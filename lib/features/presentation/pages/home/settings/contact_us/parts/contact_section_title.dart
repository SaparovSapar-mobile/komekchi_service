import 'package:flutter/material.dart';

/// Section header used throughout the contact-us page (Kontaktlar, Social
/// media salgylanmalar, Karta salgymyz).
class ContactSectionTitle extends StatelessWidget {
  final String title;
  final Color textColor;

  const ContactSectionTitle({
    super.key,
    required this.title,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
