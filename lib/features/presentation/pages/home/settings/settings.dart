import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../main.dart';
import 'bottom_sheet.dart';
import 'settings_card.dart';
import 'settings_row.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool sesliBildirisler = true;
  bool pinKod = true;
  final TextStyle textStyle = AppTextStyle.medium12;

  AppLanguage _selectedLanguage = AppLanguage.turkmen;
  AppTheme _selectedTheme = AppTheme.dark;

  String? _userName;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    setState(() {
      _isLoggedIn = token != null;
      _userName = prefs.getString('name');
    });
  }

  // Текст для отображения в строке настроек
  String get _languageLabel {
    switch (_selectedLanguage) {
      case AppLanguage.turkmen:
        return 'Türkmen';
      case AppLanguage.russian:
        return 'Rus dili';
      case AppLanguage.english:
        return 'English';
      case AppLanguage.system:
        return 'Systems';
    }
  }

  String get _themeLabel {
    switch (_selectedTheme) {
      case AppTheme.light:
        return 'Ýagty';
      case AppTheme.dark:
        return 'Garaňky';
      case AppTheme.system:
        return 'Systems';
    }
  }

  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColor.titleText(context);
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgPageLight;
    // final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;

    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        // padding: const EdgeInsets.only(bottom: 75.0),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Header
            AppBarWidget(textColor, isDark),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 12,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Meniň sahypam (diňe agza bolan ulanyjylar üçin)
                    if (_isLoggedIn) ...[
                      SectionCard(
                        text: 'Meniň sahypam',
                        children: [
                          ListTile(
                            leading: Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: AppColor.primary,
                              ),
                            ),
                            title: Text(
                              _userName ?? 'Ulanyjy',
                              style: textStyle.copyWith(
                                color: AppColor.titleText(context),
                              ),
                            ),
                            subtitle: Text(
                              'Ulanyjy',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.descriptionText(context),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                    ],

                    // Sazlamalar
                    SectionCard(
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
                                _languageLabel,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.descriptionText(context),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                          onTap: () {
                            showLanguageSheet(
                              context,
                              selected: _selectedLanguage,
                              onSelected: (lang) {
                                setState(() => _selectedLanguage = lang);
                              },
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
                                _themeLabel,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                          onTap: () {
                            showThemeSheet(
                              context,
                              selected: _selectedTheme,
                              onSelected: (theme) {
                                setState(() => _selectedTheme = theme);

                                // Если используешь themeNotifier из main.dart:
                                themeNotifier.value = theme == AppTheme.light
                                    ? ThemeMode.light
                                    : theme == AppTheme.dark
                                    ? ThemeMode.dark
                                    : ThemeMode.system;
                              },
                            );
                          },
                        ),
                        SettingsRow(
                          image: "assets/images/settings/location.png",
                          iconColor: Colors.red,
                          title: 'Salgylarym',
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                          ),
                          onTap: () {},
                        ),
                        SettingsRow(
                          image: "assets/images/settings/cart.png",
                          iconColor: Colors.orange,
                          title: 'Kartlarym',
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                          ),
                          onTap: () => context.push('/kartlarym'),
                        ),
                        SettingsRow(
                          image: "assets/images/settings/bell.png",
                          iconColor: Colors.blue,
                          title: 'Sesli bildirişler',
                          onTap: () {
                            setState(() {
                              sesliBildirisler = !sesliBildirisler;
                            });
                          },
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                sesliBildirisler = !sesliBildirisler;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 40,
                              height: 20,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: sesliBildirisler
                                    ? const Color(0xFF264FED)
                                    : const Color(0xFF222222),
                              ),
                              child: Align(
                                alignment: sesliBildirisler
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SettingsRow(
                          image: "assets/images/settings/lock.png",
                          iconColor: Colors.blue,
                          title: 'Pin kod',
                          onTap: () => context.push('/pinCode'),
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                pinKod = !pinKod;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 40,
                              height: 20,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: pinKod
                                    ? const Color(0xFF264FED)
                                    : const Color(0xFF222222),
                              ),
                              child: Align(
                                alignment: pinKod
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Biz barada
                    SectionCard(
                      text: 'Biz barada',
                      children: [
                        SettingsRow(
                          image: "assets/images/settings/!.png",
                          iconColor: Colors.blue,
                          title: 'Karhana barada',
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                          ),
                          onTap: () => context.push('/24goldaw'),
                        ),
                        SettingsRow(
                          image: "assets/images/settings/contactus.png",
                          iconColor: Colors.blue,
                          title: 'Biz bilen habarlaşmak',
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                          ),
                          onTap: () {
                            context.push('/contactUs');
                          },
                        ),
                        SettingsRow(
                          image: "assets/images/settings/chat.png",
                          iconColor: Colors.blue,
                          title: 'Hat yazmak',
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                          ),
                          onTap: () {
                            context.push('/nagilelik');
                          },
                        ),
                        SettingsRow(
                          image: "assets/images/settings/verify.png",
                          iconColor: Colors.blue,
                          title: 'Gizlinlik syýasaty',
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Akkountdan çykmak
                    SectionCard(
                      text: 'Akkountdan çykmak',
                      children: [
                        if (_isLoggedIn) ...[
                          SettingsRow(
                            image: "assets/images/settings/logout.png",
                            iconColor: Colors.blue,
                            title: 'Çykmak',
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.grey.shade400,
                            ),
                            onTap: () {
                              logOutShowBottomSheet(context);
                            },
                          ),
                          SettingsRow(
                            image: "assets/images/settings/trash.png",
                            iconColor: Colors.red,
                            title: 'Hasabym pozmak',
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.grey.shade400,
                            ),
                            onTap: () {},
                          ),
                        ],
                        SettingsRow(
                          isLast: true,
                          image: "assets/images/settings/version.png",
                          iconColor: Colors.blue,
                          title: 'Programmany täzelemek',
                          subtitle: 'Version 2.14.0',
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Täze wersiýa',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.refresh,
                                size: 16,
                                color: Colors.grey.shade500,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Section title widget
class SectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const SectionTitle({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColor.titleText(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
