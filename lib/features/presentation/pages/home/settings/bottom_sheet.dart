import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/parts/logout_bottom_sheet.dart';
import 'package:komekchi_service/l10n/gen/app_localizations.dart';
import 'package:komekchi_service/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─── Models ───────────────────────────────────────────────────────────────────

enum AppLanguage { turkmen, russian, english, system }

enum AppTheme { light, dark, system }

// ─── Language switching ────────────────────────────────────────────────────────

/// Shared by the Settings screen and onboarding's language icon — updates
/// [localeNotifier] (so the whole app re-renders in the new language) and
/// persists the choice so it survives an app restart.
Future<void> applyAppLanguage(AppLanguage lang) async {
  final Locale? locale = switch (lang) {
    AppLanguage.turkmen => const Locale('tk'),
    AppLanguage.russian => const Locale('ru'),
    AppLanguage.english => const Locale('en'),
    AppLanguage.system => null,
  };
  localeNotifier.value = locale;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('app_language', lang.name);
  if (locale != null) {
    await prefs.setString('app_locale', locale.languageCode);
  } else {
    await prefs.remove('app_locale');
  }
}

Future<AppLanguage> loadSavedAppLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString('app_language');
  return AppLanguage.values.firstWhere(
    (l) => l.name == saved,
    // No explicit choice saved yet — the app is following the device
    // locale (see main.dart), so reflect that instead of claiming Turkmen.
    orElse: () => AppLanguage.system,
  );
}

// ─── Theme switching ───────────────────────────────────────────────────────────

/// Mirrors [applyAppLanguage]: updates [themeNotifier] and persists the
/// choice so it survives an app restart (main.dart applies it on cold start).
Future<void> applyAppTheme(AppTheme theme) async {
  themeNotifier.value = switch (theme) {
    AppTheme.light => ThemeMode.light,
    AppTheme.dark => ThemeMode.dark,
    AppTheme.system => ThemeMode.system,
  };

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('app_theme', theme.name);
}

Future<AppTheme> loadSavedAppTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString('app_theme');
  return AppTheme.values.firstWhere(
    (t) => t.name == saved,
    orElse: () => AppTheme.system,
  );
}

/// Quick light↔dark flip used by the small toggle icons on onboarding/auth
/// screens — routes through [applyAppTheme] so it persists instead of
/// silently falling out of sync with the Settings screen.
Future<void> toggleAppTheme() async {
  final next = themeNotifier.value == ThemeMode.light
      ? AppTheme.dark
      : AppTheme.light;
  await applyAppTheme(next);
}

// ─── Bottom-sheet helpers ──────────────────────────────────────────────────────

void showLanguageSheet(
  BuildContext context, {
  required AppLanguage selected,
  required ValueChanged<AppLanguage> onSelected,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => _LanguageSheet(selected: selected, onSelected: onSelected),
  );
}

void showThemeSheet(
  BuildContext context, {
  required AppTheme selected,
  required ValueChanged<AppTheme> onSelected,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => _ThemeSheet(selected: selected, onSelected: onSelected),
  );
}

// ─── Language Sheet ────────────────────────────────────────────────────────────

class _LanguageSheet extends StatelessWidget {
  final AppLanguage selected;
  final ValueChanged<AppLanguage> onSelected;

  const _LanguageSheet({required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final items = [
      _LangItem(AppLanguage.turkmen, t.languageTurkmen, '🇹🇲'),
      _LangItem(AppLanguage.russian, t.languageRussian, '🇷🇺'),
      _LangItem(AppLanguage.english, t.languageEnglish, '🇬🇧'),
      _LangItem(
        AppLanguage.system,
        t.systemOption,
        null,
        icon: Icons.settings_outlined,
      ),
    ];

    return _SheetWrapper(
      label: t.language,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          final isLast = item == items.last;
          return _SheetTile(
            leading: item.flag != null
                ? Text(item.flag!, style: const TextStyle(fontSize: 22))
                : Icon(item.icon, size: 22, color: Colors.blueAccent),
            title: item.title,
            selected: selected == item.lang,
            showDivider: !isLast,
            onTap: () {
              onSelected(item.lang);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}

class _LangItem {
  final AppLanguage lang;
  final String title;
  final String? flag;
  final IconData? icon;
  const _LangItem(this.lang, this.title, this.flag, {this.icon});
}

// ─── Theme Sheet ───────────────────────────────────────────────────────────────

class _ThemeSheet extends StatelessWidget {
  final AppTheme selected;
  final ValueChanged<AppTheme> onSelected;

  const _ThemeSheet({required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final items = [
      _ThemeItem(AppTheme.light, t.themeLight, Icons.wb_sunny_outlined),
      _ThemeItem(AppTheme.dark, t.themeDark, Icons.dark_mode_outlined),
      _ThemeItem(AppTheme.system, t.systemOption, Icons.settings_outlined),
    ];

    return _SheetWrapper(
      label: t.theme,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: items.map((item) {
          final isLast = item == items.last;
          return _SheetTile(
            leading: Icon(item.icon, size: 22, color: Colors.blueAccent),
            title: item.title,
            selected: selected == item.theme,
            showDivider: !isLast,
            onTap: () {
              onSelected(item.theme);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}

class _ThemeItem {
  final AppTheme theme;
  final String title;
  final IconData icon;
  const _ThemeItem(this.theme, this.title, this.icon);
}

// ─── Shared Widgets ────────────────────────────────────────────────────────────

/// Outer wrapper: dark overlay bg + white card + drag handle + section label
class _SheetWrapper extends StatelessWidget {
  final String label;
  final Widget child;

  const _SheetWrapper({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    // final labelColor = isDark ? Colors.white54 : Colors.black45;

    return Container(
      // Full-width dark tinted background (matches screenshot)
      // color: Colors.transparent,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // ── Drag handle ──
          Container(
            width: 73,
            height: 6,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          // ── White card ──
          Container(
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                child,
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Single row inside the sheet
class _SheetTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final bool selected;
  final bool showDivider;
  final VoidCallback onTap;

  const _SheetTile({
    required this.leading,
    required this.title,
    required this.selected,
    required this.showDivider,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedBg = isDark
        ? const Color(0xFF2C2C2E)
        : const Color(0xFFF0F2FF);
    final dividerColor = isDark ? Colors.white12 : const Color(0xFFE8E8E8);

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            decoration: BoxDecoration(
              color: selected ? selectedBg : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                SizedBox(width: 30, child: Center(child: leading)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                if (selected)
                  const Icon(Icons.circle, size: 10, color: Color(0xFF3D5AFE)),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.5,
            indent: 52,
            endIndent: 8,
            color: dividerColor,
          ),
      ],
    );
  }
}

void logOutShowBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => LogOutBottomSheet(
      onSelected: (confirmed) async {
        if (confirmed) {
          await ApiService().logout();
          if (context.mounted) context.go('/login');
        }
      },
    ),
  );
}
