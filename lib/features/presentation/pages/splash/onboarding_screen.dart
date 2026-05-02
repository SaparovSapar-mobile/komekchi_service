import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/main.dart';
import '../../../../core/utils/app_theme.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  int _pageIndex = 0;

  final List<Map<String, dynamic>> pages = [
    {
      "title": "Siziň üçin iň gowy - Kömekçi hyzmat",
      "subtitle":
          "Eliňiziň aşagynda dürli görnüş bilen, zerurlyklaryňyza laýyk hyzmaty aňsatlyk bilen tapyň.",
      "image": "assets/images/onboarding/image_1.png",
    },
    {
      "title": "Iş tejribesini anyklaň?",
      "subtitle":
          "Iş çözgütleri aňsatlyk bilen kabul etmek üçin hünärmenlerden tejribe iş başarnyklary bilen tanyş boluň.",
      "image": "assets/images/onboarding/image_2.png",
    },
    {
      "title": "Iş ýerine ýetirildi!",
      "subtitle":
          "Ussat hünärmenler siziň işiňiziň netijeli gowy ýerine ýetirilmegine üpjün ederler.",
      "image": "assets/images/onboarding/image_3.png",
    },
  ];

  void _nextPage() {
    if (_pageIndex < pages.length - 1) {
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
    final page = pages[_pageIndex];

    // ✅ Адаптивные размеры
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double fontSizeTitle = screenWidth * 0.05; // ~20px
    final double fontSizeSubtitle = screenWidth * 0.04; // ~16px
    final double fontSizeButton = screenWidth * 0.04; // ~16px
    final double fontSizeSkip = screenWidth * 0.045; // ~18px
    final double buttonHeight = screenHeight * 0.066; // ~56px
    final double bottomPadding = screenHeight * 0.036; // ~30px

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.primary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
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
              color: isDark ? const Color(0xFF3D3C3C) : const Color(0xFFF2F8FE),
            ),

            // ✅ Column с Expanded — больше не будет overflow
            Column(
              children: [
                // ─── Зона картинки — Expanded, занимает оставшееся место ───
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        // Градиентный блок
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 100),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(opacity: animation, child: child),
                          child: Container(
                            key: ValueKey('gradient_$_pageIndex'),
                            // ✅ Адаптивные margin вместо фиксированных
                            margin: _pageIndex == 1
                                ? EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.21,
                                  )
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
                                        Color(0xFF3D3C3C),
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
                          top: screenHeight * 0.17, // ✅ адаптивно (было 143)
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
                ),

                // ─── Нижний контейнер — ✅ без фиксированного height! ───
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.315,
                  // ❌ Было: height: 281 (фиксированное — вызывало overflow!)
                  // ✅ Стало: padding + контент сам определяет высоту
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: isDark
                        ? const Color(0xFF333333)
                        : const Color(0xFFF6F6F6),
                  ),
                  // ✅ Отступ снизу — место для кнопки (Positioned)
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.008,
                    bottom: buttonHeight + bottomPadding + screenHeight * 0.02,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ─── Заголовок ───
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                        ),
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
                                  color: isDark
                                      ? const Color(0xFFF6F6F6)
                                      : Colors.black,
                                  fontSize: fontSizeTitle, // ✅ адаптивный
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.012), // ~11px
                      // ─── Подзаголовок ───
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                        ),
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
                                  fontSize: fontSizeSubtitle, // ✅ адаптивный
                                  color: const Color(0xFFCCCCCC),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.040), // ~40px
                      // ─── Dots ───
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          pages.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.01,
                            ),
                            width: i == _pageIndex
                                ? screenWidth * 0.1
                                : screenWidth * 0.018,
                            height: i == _pageIndex
                                ? screenHeight * 0.009
                                : screenHeight * 0.005,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: i == _pageIndex
                                  ? const Color(0xFF264FED)
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ─── Кнопки снизу (Positioned — поверх всего) ───
            Positioned(
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
                                color: const Color(0xFF264FED),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () => context.push('/login'),
                                child: Text(
                                  "Agza bolmak",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSizeButton, // ✅ адаптивный
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
                                border: Border.all(
                                  color: const Color(0xFF264FED),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () => context.push('/main'),
                                child: Text(
                                  "Gezelenç",
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF264FED),
                                    fontSize: fontSizeButton, // ✅ адаптивный
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
                          "Indiki",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeButton, // ✅ адаптивный
                          ),
                        ),
                      ),
                    ),
            ),

            // ─── Skip ───
            Positioned(
              left: screenWidth * 0.05,
              top: screenHeight * 0.059, // ~50px адаптивно
              child: GestureDetector(
                onTap: () => context.push('/login'),
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: const Color(0xFF264FED),
                    fontSize: fontSizeSkip, // ✅ адаптивный
                  ),
                ),
              ),
            ),

            // ─── Dark mode toggle ───
            Positioned(
              right: screenWidth * 0.05,
              top: screenHeight * 0.059,
              child: GestureDetector(
                onTap: () {
                  themeNotifier.value = themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                },
                child: isDark
                    ? Container(
                        padding: EdgeInsets.all(screenWidth * 0.023),
                        child: Image.asset(
                          "assets/images/logo/bedtimee.png",
                          width: screenWidth * 0.041, // ~16px
                          height: screenWidth * 0.041,
                        ),
                      )
                    : Image.asset(
                        "assets/images/logo/bedtime1.png",
                        width: screenWidth * 0.09, // ~35px
                        height: screenWidth * 0.09,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
