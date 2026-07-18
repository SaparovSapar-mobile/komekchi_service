import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:komekchi_service/features/domain/usecases/notification_usecase.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../../../../../main.dart';
import 'bottom_sheet.dart';
import 'parts/about_us_section.dart';
import 'parts/general_settings_section.dart';
import 'parts/logout_section.dart';
import 'parts/my_page_section.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool sesliBildirisler = true;
  bool pinKod = true;

  AppLanguage _selectedLanguage = AppLanguage.turkmen;
  AppTheme _selectedTheme = AppTheme.dark;

  String? _userName;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadLanguage();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    setState(() {
      _isLoggedIn = token != null;
      _userName = prefs.getString('name');
    });
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('app_language');
    final lang = AppLanguage.values.firstWhere(
      (l) => l.name == saved,
      orElse: () => AppLanguage.turkmen,
    );
    if (mounted) setState(() => _selectedLanguage = lang);
  }

  Future<void> _selectLanguage(AppLanguage lang) async {
    setState(() => _selectedLanguage = lang);

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

  Future<void> _toggleNotifications() async {
    final newValue = !sesliBildirisler;
    setState(() => sesliBildirisler = newValue);

    if (!_isLoggedIn) return;

    final result = await sl<UpdateNotificationPreferenceUsecase>().call(
      isNotification: newValue,
    );
    if (!mounted) return;
    result.fold((failure) {
      setState(() => sesliBildirisler = !newValue);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failure.message)));
    }, (_) {});
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
                    if (_isLoggedIn) ...[
                      MyPageSection(userName: _userName),
                      const SizedBox(height: 16),
                    ],

                    GeneralSettingsSection(
                      selectedLanguage: _selectedLanguage,
                      languageLabel: _languageLabel,
                      onLanguageSelected: (lang) {
                        setState(() => _selectedLanguage = lang);
                      },
                      selectedTheme: _selectedTheme,
                      themeLabel: _themeLabel,
                      onThemeSelected: (theme) {
                        setState(() => _selectedTheme = theme);

                        // Если используешь themeNotifier из main.dart:
                        themeNotifier.value = theme == AppTheme.light
                            ? ThemeMode.light
                            : theme == AppTheme.dark
                            ? ThemeMode.dark
                            : ThemeMode.system;
                      },
                      notificationsEnabled: sesliBildirisler,
                      onToggleNotifications: _toggleNotifications,
                      pinEnabled: pinKod,
                      onTogglePin: () => setState(() => pinKod = !pinKod),
                    ),

                    const SizedBox(height: 16),

                    const AboutUsSection(),

                    const SizedBox(height: 16),

                    LogoutSection(isLoggedIn: _isLoggedIn),

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
