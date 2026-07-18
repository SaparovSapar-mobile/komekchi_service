import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import '../bottom_sheet.dart';
import '../settings_card.dart';
import '../settings_row.dart';
import 'settings_toggle_switch.dart';

/// "Sazlamalar" section: language, theme, addresses, cards,
/// notifications and PIN toggles.
class GeneralSettingsSection extends StatelessWidget {
  final AppLanguage selectedLanguage;
  final String languageLabel;
  final ValueChanged<AppLanguage> onLanguageSelected;

  final AppTheme selectedTheme;
  final String themeLabel;
  final ValueChanged<AppTheme> onThemeSelected;

  final bool notificationsEnabled;
  final VoidCallback onToggleNotifications;

  final bool pinEnabled;
  final VoidCallback onTogglePin;

  const GeneralSettingsSection({
    super.key,
    required this.selectedLanguage,
    required this.languageLabel,
    required this.onLanguageSelected,
    required this.selectedTheme,
    required this.themeLabel,
    required this.onThemeSelected,
    required this.notificationsEnabled,
    required this.onToggleNotifications,
    required this.pinEnabled,
    required this.onTogglePin,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      text: 'Sazlamalar',
      children: [
        SettingsRow(
          image: "assets/images/settings/translate.png",
          iconColor: Colors.blue,
          title: 'Diller',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                languageLabel,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColor.descriptionText(context),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
          onTap: () {
            showLanguageSheet(
              context,
              selected: selectedLanguage,
              onSelected: onLanguageSelected,
            );
          },
        ),

        SettingsRow(
          image: "assets/images/settings/luna.png",
          iconColor: Colors.indigo,
          title: 'Tema',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                themeLabel,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
          onTap: () {
            showThemeSheet(
              context,
              selected: selectedTheme,
              onSelected: onThemeSelected,
            );
          },
        ),
        SettingsRow(
          image: "assets/images/settings/location.png",
          iconColor: Colors.red,
          title: 'Salgylarym',
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          onTap: () {},
        ),
        // SettingsRow(
        //   image: "assets/images/settings/cart.png",
        //   iconColor: Colors.orange,
        //   title: 'Kartlarym',
        //   trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
        //   onTap: () => context.push('/kartlarym'),
        // ),
        SettingsRow(
          image: "assets/images/settings/bell.png",
          iconColor: Colors.blue,
          title: 'Sesli bildirişler',
          onTap: onToggleNotifications,
          trailing: SettingsToggleSwitch(
            value: notificationsEnabled,
            onTap: onToggleNotifications,
          ),
        ),
        SettingsRow(
          image: "assets/images/settings/lock.png",
          iconColor: Colors.blue,
          title: 'Pin kod',
          onTap: () => context.push('/pinCode'),
          trailing: SettingsToggleSwitch(value: pinEnabled, onTap: onTogglePin),
        ),
      ],
    );
  }
}
