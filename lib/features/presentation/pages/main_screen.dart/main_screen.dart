import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:komekchi_service/features/presentation/pages/home/bronlar/bronlar_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/settings.dart';

import '../../../../core/utils/theme/app_colors.dart';
import '../home/home_screen.dart';
import '../home/search/serach_screen.dart';
import 'dart:ui';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
 
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // ← Dobav eto
  bool _showScrollToTop = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 300) {
        if (!_showScrollToTop) setState(() => _showScrollToTop = true);
      } else {
        if (_showScrollToTop) setState(() => _showScrollToTop = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final textColor =  AppColor.titleText(context);

    return Scaffold(
      backgroundColor: AppColor.primary,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),

      floatingActionButton: _currentIndex == 0 && _showScrollToTop
          ? SizedBox(
              height: 44,
              width: 44,
              child: FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                backgroundColor: AppColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.arrow_upward, color: Colors.white),
              ),
            )
          : null,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(scrollController: _scrollController),
          SearchScreen(),
          BronlarScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 27),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColor, width: 0.5),
          borderRadius: BorderRadius.circular(50)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                // Полупрозрачный фон — контент снизу виден
                color: isDark ? AppColor.bgPageDark.withOpacity(0.64) : AppColor.bgPageLight.withOpacity(0.34),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withOpacity(0.12),
                    width: 2,
                  ),
                  left: BorderSide(
                    color: Colors.white.withOpacity(0.12),  
                    width: 1,
                  ),
                  right: BorderSide(
                    color: Colors.white.withOpacity(0.12),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).padding.bottom + 8,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      0,
                      "assets/images/bottom/home.png",
                      "assets/images/bottom_dark/icon.png",
                      "assets/images/bottom/image.png",
                      'Esasy',
                    ),
                    _buildNavItem(
                      1,
                      "assets/images/bottom/image2.png",
                      "assets/images/bottom_dark/icon2.png",
                      "assets/images/bottom/iamge2.png",
                      'Gözleg',
                    ),
                    _buildNavItem(
                      2,
                      "assets/images/bottom/date_range.png",
                      "assets/images/bottom_dark/icon3.png",
                      "assets/images/bottom/image3.png",
                      'Bronlar',
                    ),
                    _buildNavItem(
                      3,
                      "assets/images/bottom/account_circle.png",
                      "assets/images/bottom_dark/icon4.png",
                      "assets/images/bottom/iamge4.png",
                      'Sazlamalar',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String lightIcon,
    String darkIcon,
    String activeIcon,
    String label,
  ) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primary.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected
                  ? activeIcon
                  : isDark
                  ? darkIcon // тёмная тема — dark иконка
                  : lightIcon, // светлая тема — light иконка
              width:isSelected ? 26 :  isDark ? 26 : 20,
              height: isSelected ? 26 : isDark ? 26 : 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? AppColor.primary
                    : isDark
                    ? Colors.white60
                    : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
