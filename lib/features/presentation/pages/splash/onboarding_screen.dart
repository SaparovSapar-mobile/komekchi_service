import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../home/settings/bottom_sheet.dart';

part 'parts/onboarding_hero_section.dart';
part 'parts/onboarding_content_section.dart';
part 'parts/onboarding_bottom_buttons.dart';
part 'parts/onboarding_top_icons.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  int _pageIndex = 0;
  AppLanguage _selectedLanguage = AppLanguage.turkmen;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _markOnboardingSeen();
  }

  // Cold start checks this in main.dart — once it's set, onboarding is
  // skipped for good, even for a user who never logs in (guest mode).
  Future<void> _markOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
  }

  Future<void> _loadLanguage() async {
    final lang = await loadSavedAppLanguage();
    if (mounted) setState(() => _selectedLanguage = lang);
  }

  void _selectLanguage(AppLanguage lang) {
    setState(() => _selectedLanguage = lang);
    applyAppLanguage(lang);
  }

  List<Map<String, dynamic>> _pages(AppLocalizations t) => [
    {
      "title": t.onboardTitle1,
      "subtitle": t.onboardSubtitle1,
      "image": "assets/images/onboarding/image_1.png",
    },
    {
      "title": t.onboardTitle2,
      "subtitle": t.onboardSubtitle2,
      "image": "assets/images/onboarding/image_2.png",
    },
    {
      "title": t.onboardTitle3,
      "subtitle": t.onboardSubtitle3,
      "image": "assets/images/onboarding/image_3.png",
    },
  ];

  static const int _pageCount = 3;

  void _nextPage() {
    if (_pageIndex < _pageCount - 1) {
      setState(() => _pageIndex++);
    }
  }

  void _prevPage() {
    if (_pageIndex > 0) {
      setState(() => _pageIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final t = AppLocalizations.of(context)!;
    final pages = _pages(t);
    final page = pages[_pageIndex];

    // ✅ Адаптивные размеры
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double fontSizeTitle = screenWidth * 0.05;
    final double fontSizeSubtitle = screenWidth * 0.04;
    final double fontSizeButton = screenWidth * 0.04;
    final double buttonHeight = screenHeight * 0.066;
    final double bottomPadding = screenHeight * 0.036;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.pageBg(context),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColor.pageBg(context),
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null &&
              details.primaryVelocity! < -200) {
            _nextPage();
          }
          if (details.primaryVelocity != null &&
              details.primaryVelocity! > 200) {
            _prevPage();
          }
        },
        child: Stack(
          children: [
            // ─── Фон ───
            Container(
              color: AppColor.pageBg(context),
            ),

            Column(
              children: [
                _buildHeroSection(
                  context,
                  page,
                  screenWidth,
                  screenHeight,
                  isDark,
                ),
                _buildContentSection(
                  context,
                  page,
                  pages,
                  isDark,
                  screenWidth,
                  screenHeight,
                  fontSizeTitle,
                  fontSizeSubtitle,
                  buttonHeight,
                  bottomPadding,
                ),
              ],
            ),

            // ─── Кнопки снизу (Positioned — поверх всего) ───
            _buildBottomButtons(
              context,
              t,
              pages,
              isDark,
              screenWidth,
              buttonHeight,
              bottomPadding,
              fontSizeButton,
            ),

            // ─── Иконки сверху (язык + тёмная тема) ───
            ..._buildTopIcons(context, isDark, screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }
}
