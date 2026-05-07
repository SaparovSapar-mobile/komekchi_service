import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';
import 'package:komekchi_service/features/presentation/pages/home/bronlar/bronlar_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/sazlamalar.dart';

import '../../../../core/utils/theme/app_colors.dart';
import '../home/home_screen.dart';
import '../home/search/serach_screen.dart';

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
          HomeScreen(
            scrollController: _scrollController,
          ), // ← pereday controller
          SearchScreen(),
          BronlarScreen(),
          SazlamalarScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColor.primary,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/bottom/home.png",
                width: 18,
                height: 34,
              ),
              activeIcon: Image.asset(
                "assets/images/bottom/image.png",
                width: 34,
                height: 34,
              ),
              label: 'Esasy',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/bottom/image2.png",
                width: 18,
                height: 34,
              ),
              activeIcon: Image.asset(
                "assets/images/bottom/iamge2.png",
                width: 34,
                height: 34,
              ),
              label: 'Gözleg',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/bottom/date_range.png",
                width: 18,
                height: 34,
              ),
              activeIcon: Image.asset(
                "assets/images/bottom/image3.png",
                width: 34,
                height: 34,
              ),
              label: 'Bronlar',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/bottom/account_circle.png",
                width: 18,
                height: 34,
              ),
              activeIcon: Image.asset(
                "assets/images/bottom/iamge4.png",
                width: 34,
                height: 34,
              ),
              label: 'Sazlamalar',
            ),
          ],
        ),
      ),
    );
  }
}


