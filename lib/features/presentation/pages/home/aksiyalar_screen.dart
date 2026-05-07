import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';

import '../../../../core/utils/theme/app_colors.dart';

class AksiyalarScreen extends StatelessWidget {
  const AksiyalarScreen({super.key});

  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
  }

  final List<AksiyaItem> items = const [
    AksiyaItem(image: 'assets/images/service/image_4.png'),
    AksiyaItem(image: 'assets/images/service/image_5.png'),
    AksiyaItem(image: 'assets/images/service/image_4.png'),
    AksiyaItem(image: 'assets/images/service/image_5.png'),
    AksiyaItem(image: 'assets/images/service/image_4.png'),
    AksiyaItem(image: 'assets/images/service/image_5.png'),
    AksiyaItem(image: 'assets/images/service/image_4.png'),
    AksiyaItem(image: 'assets/images/service/image_5.png'),
    AksiyaItem(image: 'assets/images/service/image_4.png'),
    AksiyaItem(image: 'assets/images/service/image_5.png'),
  ];

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
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 31.0,
                vertical: 10.31,
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo/mini_logo.png",
                    width: 37.14,
                    height: 38.42,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Kömekçi\nHyzmat",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    getCurrentDate(),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(width: 2),
                  const Text("|"),
                  const SizedBox(width: 2),
                  const Icon(Icons.cloud, size: 16, color: Colors.black45),
                  const Text(
                    " 32° Aşgabat",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: const Color(0xFFF5F7FF)),

            // Back + Title + Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  const Text(
                    'Aksiyalar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/images/icon/search.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: const Color(0xFFF5F7FF)),

            // Grid
            Expanded(
              child: Container(
                color: const Color(0xFFF5F7FF),
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1.4,
                  ),
                  itemBuilder: (context, index) {
                    return _AksiyaCard(item: items[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AksiyaCard extends StatelessWidget {
  final AksiyaItem item;
  const _AksiyaCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/detail", extra: item.image);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.asset(
          width: 171.55,
          height: 104.51,
          item.image,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.transparent,
            child: const Icon(Icons.person, size: 60, color: Colors.white30),
          ),
        ),
      ),
    );
  }
}

class AksiyaItem {
  final String image;

  const AksiyaItem({required this.image});
}
