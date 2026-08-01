part of '../onboarding_screen.dart';

extension OnboardingContentSection on _WalkthroughScreenState {
  Widget _buildContentSection(
    BuildContext context,
    Map<String, dynamic> page,
    List<Map<String, dynamic>> pages,
    bool isDark,
    double screenWidth,
    double screenHeight,
    double fontSizeTitle,
    double fontSizeSubtitle,
    double buttonHeight,
    double bottomPadding,
  ) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.315,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: isDark ? AppColor.bgBlogDark : AppColor.titleDark,
      ),
      padding: EdgeInsets.only(
        top: screenHeight * 0.008,
        bottom: buttonHeight + bottomPadding + screenHeight * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ─── Заголовок ───
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.15),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: SizedBox(
                height: screenHeight * 0.04,
                child: Center(
                  child: Text(
                    page["title"],
                    maxLines: 2,
                    key: ValueKey('title_$_pageIndex'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? const Color(0xFFF6F6F6) : Colors.black,
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.012),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.15),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: SizedBox(
                height: screenHeight * 0.08,
                child: Center(
                  child: Text(
                    page["subtitle"],
                    maxLines: 3,
                    key: ValueKey('subtitle_$_pageIndex'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSizeSubtitle,
                      color: const Color(0xFFCCCCCC),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.040),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                width: i == _pageIndex
                    ? screenWidth * 0.1
                    : screenWidth * 0.018,
                height: i == _pageIndex
                    ? screenHeight * 0.009
                    : screenHeight * 0.005,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: i == _pageIndex
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
