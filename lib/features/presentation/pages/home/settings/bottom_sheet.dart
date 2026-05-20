import 'package:flutter/material.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/parts/logout_bottom_sheet.dart';

// ─── Models ───────────────────────────────────────────────────────────────────

enum AppLanguage { turkmen, russian, english, system }

enum AppTheme { light, dark, system }

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
    final items = [
      _LangItem(AppLanguage.turkmen, 'Turkmen', '🇹🇲'),
      _LangItem(AppLanguage.russian, 'Rus dili', '🇷🇺'),
      _LangItem(AppLanguage.english, 'English', '🇬🇧'),
      _LangItem(
        AppLanguage.system,
        'Systems',
        null,
        icon: Icons.settings_outlined,
      ),
    ];

    return _SheetWrapper(
      label: 'Diller',
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
    final items = [
      _ThemeItem(AppTheme.light, 'Light', Icons.wb_sunny_outlined),
      _ThemeItem(AppTheme.dark, 'Dark', Icons.dark_mode_outlined),
      _ThemeItem(AppTheme.system, 'Systems', Icons.settings_outlined),
    ];

    return _SheetWrapper(
      label: 'Tema',
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
        onSelected: (confirmed) {
          if (confirmed) {
            // пользователь нажал "Howa"
          } else {
            // пользователь нажал "Yok"
          }
        },
      ),
    );
  }