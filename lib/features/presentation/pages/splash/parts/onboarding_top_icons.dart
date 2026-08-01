part of '../onboarding_screen.dart';

extension OnboardingTopIcons on _WalkthroughScreenState {
  List<Widget> _buildTopIcons(
    BuildContext context,
    bool isDark,
    double screenWidth,
    double screenHeight,
  ) {
    return [
      // ─── Language ───
      Positioned(
        left: screenWidth * 0.05,
        top: screenHeight * 0.059,
        child: GestureDetector(
          onTap: () {
            showLanguageSheet(
              context,
              selected: _selectedLanguage,
              onSelected: _selectLanguage,
            );
          },
          child: Icon(Icons.language, size: 22, color: AppColor.primary),
        ),
      ),

      // ─── Dark mode toggle ───
      Positioned(
        right: screenWidth * 0.05,
        top: screenHeight * 0.040,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => toggleAppTheme(),
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            child: isDark
                ? Image.asset(
                    "assets/images/logo/white.png",
                    width: screenWidth * 0.038,
                    height: screenWidth * 0.038,
                  )
                : Image.asset(
                    "assets/images/logo/bedtimee.png",
                    width: screenWidth * 0.040,
                    height: screenWidth * 0.040,
                  ),
          ),
        ),
      ),
    ];
  }
}
