import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  MAZOOM DESIGN SYSTEM — Color Tokens
// ─────────────────────────────────────────────

abstract class AppColor {
  // Primary
  static const Color primary = Color(0xFF2549E0);
  static const Color secondary = Color(0xFFFF5502);
  static const Color secondaryAlt = Color(0xFFF08134);

  // Warning / Status
  static const Color vipCard = Color(0xFFE48121);
  static const Color expertCard = Color(0xFFF8A800);
  static const Color newCard = Color(0xFF07AA00);
  static const Color gradus360 = Color(0xFFFF5950);

  // Info / System
  static const Color error = Color(0xFFD20820);
  static const Color success = Color(0xFF04B481);
  static const Color loadingBackground = Color(0xFFE4E4E2);

  // Light Background
  static const Color bgPageLight = Color(0xFFF1F0F0);
  static const Color bgBlogLight = Color(0xFF111111);

  // Dark Background
  static const Color bgPageDark = Color(0xFF3D3D3C);
  static const Color bgBlogDark = Color(0xFF232323);

  // Light Text
  static const Color titleTextLight = Color(0xFF2D2E26);
  static const Color descriptionTextLight = Color(0xFF60273F);

  // Dark Text
  static const Color titleTextDark = Color(0xFFF5F6F6);
  static const Color descriptionTextDark = Color(0xFFCCCCCC);
}

// ─────────────────────────────────────────────
//  TEXT THEMES
// ─────────────────────────────────────────────

TextTheme _buildTextTheme({required bool isDark}) {
  final titleColor =
      isDark ? AppColor.titleTextDark : AppColor.titleTextLight;
  final bodyColor = isDark
      ? AppColor.descriptionTextDark
      : AppColor.descriptionTextLight;

  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w700,
      color: titleColor,
      letterSpacing: -0.25,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w700,
      color: titleColor,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: titleColor,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: titleColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: titleColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: titleColor,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: titleColor,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: titleColor,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: titleColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: bodyColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: bodyColor,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: bodyColor,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: titleColor,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: bodyColor,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: bodyColor,
    ),
  );
}

// ─────────────────────────────────────────────
//  COLOR SCHEME
// ─────────────────────────────────────────────

const ColorScheme _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColor.primary,
  onPrimary: Colors.white,
  primaryContainer: Color(0xFFD9E0FF),
  onPrimaryContainer: Color(0xFF001258),
  secondary: AppColor.secondary,
  onSecondary: Colors.white,
  secondaryContainer: Color(0xFFFFDDD0),
  onSecondaryContainer: Color(0xFF3B0900),
  tertiary: AppColor.success,
  onTertiary: Colors.white,
  tertiaryContainer: Color(0xFFB8F5E1),
  onTertiaryContainer: Color(0xFF00341E),
  error: AppColor.error,
  onError: Colors.white,
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  surface: AppColor.bgPageLight,
  onSurface: AppColor.titleTextLight,
  surfaceContainerHighest: Color(0xFFE4E4E2),
  onSurfaceVariant: AppColor.descriptionTextLight,
  outline: Color(0xFFCCCCCC),
  outlineVariant: Color(0xFFE4E4E4),
  shadow: Color(0x1A000000),
  scrim: Color(0xFF000000),
  inverseSurface: AppColor.bgBlogDark,
  onInverseSurface: AppColor.titleTextDark,
  inversePrimary: Color(0xFFB3C2FF),
);

const ColorScheme _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFB3C2FF),
  onPrimary: Color(0xFF001258),
  primaryContainer: Color(0xFF0028A6),
  onPrimaryContainer: Color(0xFFD9E0FF),
  secondary: Color(0xFFFFB59A),
  onSecondary: Color(0xFF5F1500),
  secondaryContainer: Color(0xFF862200),
  onSecondaryContainer: Color(0xFFFFDDD0),
  tertiary: Color(0xFF5DDAAB),
  onTertiary: Color(0xFF003826),
  tertiaryContainer: Color(0xFF005139),
  onTertiaryContainer: Color(0xFFB8F5E1),
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: AppColor.bgPageDark,
  onSurface: AppColor.titleTextDark,
  surfaceContainerHighest: AppColor.bgBlogDark,
  onSurfaceVariant: AppColor.descriptionTextDark,
  outline: Color(0xFF606060),
  outlineVariant: Color(0xFF3D3D3C),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: AppColor.bgPageLight,
  onInverseSurface: AppColor.titleTextLight,
  inversePrimary: AppColor.primary,
);

// ─────────────────────────────────────────────
//  COMPONENT THEMES
// ─────────────────────────────────────────────

ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme cs) =>
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );

OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme cs) =>
    OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: cs.primary,
        side: BorderSide(color: cs.primary, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

TextButtonThemeData _textButtonTheme(ColorScheme cs) => TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: cs.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

InputDecorationTheme _inputDecorationTheme(ColorScheme cs) =>
    InputDecorationTheme(
      filled: true,
      fillColor: cs.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: cs.outline, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: cs.outline, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: cs.error, width: 1),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelStyle: TextStyle(color: cs.onSurfaceVariant),
      hintStyle:
          TextStyle(color: cs.onSurfaceVariant.withOpacity(0.6)),
    );

CardThemeData _cardTheme(ColorScheme cs) => CardThemeData(
      elevation: 0,
      color: cs.brightness == Brightness.light
          ? Colors.white
          : AppColor.bgBlogDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: cs.outlineVariant, width: 1),
      ),
      margin: const EdgeInsets.all(0),
    );

AppBarTheme _appBarTheme(ColorScheme cs) => AppBarTheme(
      backgroundColor: cs.surface,
      foregroundColor: cs.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: cs.shadow,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: cs.onSurface,
      ),
    );

SnackBarThemeData _snackBarTheme(ColorScheme cs) => SnackBarThemeData(
      backgroundColor: cs.inverseSurface,
      contentTextStyle: TextStyle(color: cs.onInverseSurface),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );

ChipThemeData _chipTheme(ColorScheme cs) => ChipThemeData(
      backgroundColor: cs.surfaceContainerHighest,
      labelStyle: TextStyle(
        color: cs.onSurface,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      side: BorderSide(color: cs.outlineVariant),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );

DividerThemeData _dividerTheme(ColorScheme cs) => DividerThemeData(
      color: cs.outlineVariant,
      thickness: 1,
      space: 1,
    );

// ─────────────────────────────────────────────
//  THEME BUILDERS
// ─────────────────────────────────────────────

ThemeData buildLightTheme() {
  const cs = _lightColorScheme;
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: cs,
    scaffoldBackgroundColor: AppColor.bgPageLight,
    textTheme: _buildTextTheme(isDark: false),
    elevatedButtonTheme: _elevatedButtonTheme(cs),
    outlinedButtonTheme: _outlinedButtonTheme(cs),
    textButtonTheme: _textButtonTheme(cs),
    inputDecorationTheme: _inputDecorationTheme(cs),
    cardTheme: _cardTheme(cs),
    appBarTheme: _appBarTheme(cs),
    snackBarTheme: _snackBarTheme(cs),
    chipTheme: _chipTheme(cs),
    dividerTheme: _dividerTheme(cs),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? cs.primary : cs.outline,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? cs.primary.withOpacity(0.3)
            : cs.surfaceContainerHighest,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? cs.primary : Colors.transparent,
      ),
      checkColor: WidgetStateProperty.all(cs.onPrimary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: cs.outline, width: 1.5),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? cs.primary : cs.outline,
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: cs.primary,
      linearTrackColor: cs.primaryContainer,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: cs.primary,
      unselectedItemColor: cs.onSurfaceVariant,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: cs.primaryContainer,
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      elevation: 8,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: cs.primary,
      unselectedLabelColor: cs.onSurfaceVariant,
      indicatorColor: cs.primary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      unselectedLabelStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: cs.inverseSurface,
        borderRadius: BorderRadius.circular(6),
      ),
      textStyle: TextStyle(color: cs.onInverseSurface, fontSize: 12),
    ),
  );
}

ThemeData buildDarkTheme() {
  const cs = _darkColorScheme;
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: cs,
    scaffoldBackgroundColor: AppColor.bgPageDark,
    textTheme: _buildTextTheme(isDark: true),
    elevatedButtonTheme: _elevatedButtonTheme(cs),
    outlinedButtonTheme: _outlinedButtonTheme(cs),
    textButtonTheme: _textButtonTheme(cs),
    inputDecorationTheme: _inputDecorationTheme(cs),
    cardTheme: _cardTheme(cs),
    appBarTheme: _appBarTheme(cs),
    snackBarTheme: _snackBarTheme(cs),
    chipTheme: _chipTheme(cs),
    dividerTheme: _dividerTheme(cs),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? cs.primary : cs.outline,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? cs.primary.withOpacity(0.3)
            : cs.surfaceContainerHighest,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? cs.primary : Colors.transparent,
      ),
      checkColor: WidgetStateProperty.all(cs.onPrimary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: cs.outline, width: 1.5),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? cs.primary : cs.outline,
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: cs.primary,
      linearTrackColor: cs.primaryContainer,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.bgBlogDark,
      selectedItemColor: cs.primary,
      unselectedItemColor: cs.onSurfaceVariant,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColor.bgBlogDark,
      indicatorColor: cs.primaryContainer,
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColor.bgBlogDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor.bgBlogDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      elevation: 8,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: cs.primary,
      unselectedLabelColor: cs.onSurfaceVariant,
      indicatorColor: cs.primary,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      unselectedLabelStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: cs.inverseSurface,
        borderRadius: BorderRadius.circular(6),
      ),
      textStyle: TextStyle(color: cs.onInverseSurface, fontSize: 12),
    ),
  );
}