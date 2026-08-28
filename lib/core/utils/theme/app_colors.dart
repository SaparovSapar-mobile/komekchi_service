import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  // ─── Primary ─────────────────────────────────────────────────────
  static const Color primary   = Color(0xFF264FED);
  static const Color secondary = Color(0xFFFF6600);
  static const Color tertiary  = Color(0xFFFE8E3A);

  // ─── Warning / Special cards ─────────────────────────────────────
  static const Color vipCard     = Color(0xFFFBB725);
  static const Color exportCard  = Color(0xFFF3690D);
  static const Color newCard     = Color(0xFF2BC171);
  static const Color gradus360   = Color(0xFFFF5050);

  // ─── Semantic ────────────────────────────────────────────────────
  static const Color error   = Color(0xFFDC2626);
  static const Color success = Color(0xFF047857);
  static const Color loading = Color(0xFFF4F2F2);

  // ─── Backgrounds ─────────────────────────────────────────────────
  static const Color bgPageLight = Color(0xFFF6F8FD);
  static const Color bgBlogLight = Color(0xFFFFFFFF);
  static const Color bgPageDark  = Color(0xFF3D3C3C);
  static const Color bgBlogDark  = Color(0xFF333333);

  // ─── Text colors ─────────────────────────────────────────────────
  static const Color titleLight       = Color(0xFF262626);
  static const Color descriptionLight = Color(0xFF90979F);
  static const Color titleDark        = Color(0xFFF6F6F6);
  static const Color descriptionDark  = Color(0xFFCCCCCC);
  static const Color borderColor = Color(0xFFD0D7FB);


  // ─── Text helpers (используй с context) ──────────────────────────

  /// Главный текст (заголовки, важный контент)
  static Color titleText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? titleDark
          : titleLight;

  /// Второстепенный текст (описания, подсказки)
  static Color descriptionText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? descriptionDark
          : descriptionLight;

  /// Фон страницы (внешний контейнер экрана)
  static Color pageBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? bgPageDark
          : bgPageLight;

  /// Фон карточек/полей внутри страницы
  static Color cardBg(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? bgBlogDark
          : bgBlogLight;

  /// Цвет рамки полей ввода/карточек
  static Color border(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF333333)
          : borderColor;
}