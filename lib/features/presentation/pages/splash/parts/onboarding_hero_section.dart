part of '../onboarding_screen.dart';

extension OnboardingHeroSection on _WalkthroughScreenState {
  Widget _buildHeroSection(
    BuildContext context,
    Map<String, dynamic> page,
    double screenWidth,
    double screenHeight,
    bool isDark,
  ) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: Container(
                key: ValueKey('gradient_$_pageIndex'),
                margin: _pageIndex == 1
                    ? EdgeInsets.symmetric(horizontal: screenWidth * 0.21)
                    : _pageIndex == 0
                    ? EdgeInsets.only(
                        left: screenWidth * 0.295,
                        top: screenHeight * 0.327,
                      )
                    : EdgeInsets.only(
                        right: screenWidth * 0.246,
                        top: screenHeight * 0.327,
                      ),
                height: _pageIndex == 1
                    ? screenHeight * 0.635
                    : screenHeight * 0.204,
                width: _pageIndex == 1
                    ? screenWidth * 0.579
                    : screenWidth * 0.754,
                decoration: BoxDecoration(
                  gradient: isDark
                      ? LinearGradient(
                          begin: _pageIndex == 1
                              ? Alignment.bottomCenter
                              : _pageIndex == 2
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          end: _pageIndex == 1
                              ? Alignment.topCenter
                              : _pageIndex == 2
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          colors: const [
                            AppColor.bgPageDark,
                            Color(0xFFFF994B),
                          ],
                        )
                      : LinearGradient(
                          begin: _pageIndex == 1
                              ? Alignment.bottomCenter
                              : _pageIndex == 2
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          end: _pageIndex == 1
                              ? Alignment.topCenter
                              : _pageIndex == 2
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          colors: const [
                            Color(0xFFF2F8FE),
                            Color(0xFFFF994B),
                          ],
                        ),
                ),
              ),
            ),

            // ─── Картинка ───
            Positioned(
              top: screenHeight * 0.17,
              right: 0,
              left: 0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.05),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  page["image"],
                  key: ValueKey(page["image"]),
                  height: screenHeight * 0.48,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
