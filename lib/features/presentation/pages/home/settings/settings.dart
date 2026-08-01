import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/pin_storage.dart';
import 'package:komekchi_service/features/domain/usecases/notification_usecase.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../l10n/gen/app_localizations.dart';
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
  bool pinKod = false;

  AppLanguage _selectedLanguage = AppLanguage.turkmen;
  AppTheme _selectedTheme = AppTheme.dark;

  String? _userName;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadLanguage();
    _loadTheme();
    _loadPin();
  }

  Future<void> _loadTheme() async {
    final theme = await loadSavedAppTheme();
    if (mounted) setState(() => _selectedTheme = theme);
  }

  Future<void> _loadPin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() => pinKod = prefs.getBool(pinEnabledStorageKey) ?? false);
  }

  /// Turning it on with no PIN saved yet opens the setup screen first —
  /// the toggle only flips once a PIN actually exists.
  Future<void> _togglePin(bool enable) async {
    final prefs = await SharedPreferences.getInstance();

    if (enable) {
      final hasPin = prefs.getString(pinCodeStorageKey) != null;
      if (!hasPin) {
        final created = await context.push<bool>('/pinCode');
        if (created == true && mounted) setState(() => pinKod = true);
        return;
      }
      await prefs.setBool(pinEnabledStorageKey, true);
      setState(() => pinKod = true);
    } else {
      await prefs.setBool(pinEnabledStorageKey, false);
      setState(() => pinKod = false);
    }
  }

  Future<void> _openPinScreen() async {
    final result = await context.push<bool>('/pinCode');
    if (result == true && mounted) setState(() => pinKod = true);
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
    final lang = await loadSavedAppLanguage();
    if (mounted) setState(() => _selectedLanguage = lang);
  }

  Future<void> _selectLanguage(AppLanguage lang) async {
    setState(() => _selectedLanguage = lang);
    await applyAppLanguage(lang);
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
  String _languageLabel(AppLocalizations t) {
    switch (_selectedLanguage) {
      case AppLanguage.turkmen:
        return t.languageTurkmen;
      case AppLanguage.russian:
        return t.languageRussian;
      case AppLanguage.english:
        return t.languageEnglish;
      case AppLanguage.system:
        return t.systemOption;
    }
  }

  String _themeLabel(AppLocalizations t) {
    switch (_selectedTheme) {
      case AppTheme.light:
        return t.themeLight;
      case AppTheme.dark:
        return t.themeDark;
      case AppTheme.system:
        return t.systemOption;
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
    final bg = AppColor.pageBg(context);
    final t = AppLocalizations.of(context)!;

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
                      languageLabel: _languageLabel(t),
                      onLanguageSelected: _selectLanguage,
                      selectedTheme: _selectedTheme,
                      themeLabel: _themeLabel(t),
                      onThemeSelected: (theme) {
                        setState(() => _selectedTheme = theme);
                        applyAppTheme(theme);
                      },
                      notificationsEnabled: sesliBildirisler,
                      onToggleNotifications: _toggleNotifications,
                      pinEnabled: pinKod,
                      onTogglePin: () => _togglePin(!pinKod),
                      onTapPin: _openPinScreen,
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
