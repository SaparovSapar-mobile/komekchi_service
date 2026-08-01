part of '../onboarding_screen.dart';

extension OnboardingBottomButtons on _WalkthroughScreenState {
  Widget _buildBottomButtons(
    BuildContext context,
    AppLocalizations t,
    List<Map<String, dynamic>> pages,
    bool isDark,
    double screenWidth,
    double buttonHeight,
    double bottomPadding,
    double fontSizeButton,
  ) {
    return Positioned(
      bottom: bottomPadding,
      left: screenWidth * 0.04,
      right: screenWidth * 0.04,
      child: _pageIndex == pages.length - 1
          ? SizedBox(
              height: buttonHeight,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: buttonHeight,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () => context.push('/login'),
                        child: Text(
                          t.authRegisterTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeButton,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: Container(
                      height: buttonHeight,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () => context.push('/main'),
                        child: Text(
                          t.onboardGuest,
                          style: TextStyle(
                            color: isDark
                                ? AppColor.bgBlogLight
                                : AppColor.primary,
                            fontSize: fontSizeButton,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              width: double.infinity,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF264FED),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  t.next,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeButton,
                  ),
                ),
              ),
            ),
    );
  }
}
