import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/features/presentation/bloc/search/search_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/bronlar/bronlar_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/settings.dart';
import 'package:komekchi_service/injector.dart';

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
    final textColor = AppColor.titleText(context);

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
          BlocProvider(
            create: (_) => sl<SearchCubit>(),
            child: const SearchScreen(),
          ),
          BronlarScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 27, vertical: 7),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColor, width: 0.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                // Полупрозрачный фон — контент снизу виден
                color: isDark
                    ? AppColor.bgBlogDark.withOpacity(0.45)
                    : AppColor.bgPageLight.withOpacity(0.34),
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
                  left: 12,
                  right: 12,
                  // bottom: MediaQuery.of(context).padding.bottom + 8,
                  bottom: 5,
                  top: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: _buildNavItem(0, Icons.home, 'Esasy')),
                    Expanded(
                      child: _buildNavItem(1, Icons.manage_search, 'Gözleg'),
                    ),
                    Expanded(
                      child: _buildNavItem(2, Icons.date_range, 'Bronlar'),
                    ),
                    Expanded(
                      child: _buildNavItem(
                        3,
                        Icons.account_circle,
                        'Sazlamalar',
                      ),
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

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: index == 3 ? 8 : 12,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                    ? AppColor.bgPageDark.withOpacity(0.85)
                    : AppColor.primary.withOpacity(0.15))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isDark
                    ? (isSelected ? AppColor.bgBlogDark : AppColor.bgPageDark)
                    : Color(0xFFF6F8FD),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isSelected
                    ? AppColor.primary
                    : isDark
                    ? Colors.white
                    : Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
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
