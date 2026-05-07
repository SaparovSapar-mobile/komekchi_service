import 'package:flutter/material.dart';
abstract class AppColor {
  // Primary
  static const Color primary = Color(0xFF2549E0);
  static const Color secondary = Color(0xFFFF6600);
  static const Color secondaryAlt = Color(0xFFFE8E3A);

  // Warning / Status
  static const Color vipCard = Color(0xFFE48121);
  static const Color expertCard = Color(0xFFF8A800);
  static const Color newCard = Color(0xFF07AA00);
  static const Color gradus360 = Color(0xFFFF5950);

  // Info / System
  static const Color error = Color(0xFFD20820);
  static const Color success = Color(0xFF04B481);
  static const Color borderColor = Color(0xFFD0D7FB);

  // Light Background
  static const Color bgPageLight = Color(0xFFF6F8FD);
  static const Color bgBlogLight = Color(0xFFFFFFFF);

  // Dark Background
  static const Color bgPageDark = Color(0xFF3D3C3C);
  static const Color bgBlogDark = Color(0xFF333333);

  // Light Text
  static const Color titleTextLight = Color(0xFF262626);
  static const Color descriptionTextLight = Color(0xFF90979F);

  // Dark Text
  static const Color titleTextDark = Color(0xFFF6F6F6);
  static const Color descriptionTextDark = Color(0xFFCCCCCC);
}
