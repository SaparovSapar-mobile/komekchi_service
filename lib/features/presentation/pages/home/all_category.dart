import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/app_theme.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({super.key});

  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
  }

  final List<CategoryItem> categories = const [
    CategoryItem(
      title: 'Elektrikçi',
      image: 'assets/images/category/image1.png',
    ),
    CategoryItem(
      title: 'Arassaçylyk',
      image: 'assets/images/category/image2.png',
    ),
    CategoryItem(
      title: 'Ýük daşaýjy',
      image: 'assets/images/category/image3.png',
    ),
    CategoryItem(
      title: 'Agaç ussasy',
      image: 'assets/images/category/image4.png',
    ),
    CategoryItem(
      title: 'Reňkleýji',
      image: 'assets/images/category/image5.png',
    ),
    CategoryItem(title: 'Salon', image: 'assets/images/category/image6.png'),
    CategoryItem(
      title: 'Toý bezegleri',
      image: 'assets/images/category/image7.png',
    ),
    CategoryItem(
      title: 'Tehnika bejerijiler',
      image: 'assets/images/category/image8.png',
    ),
    CategoryItem(
      title: 'Öý abatlaýyş',
      image: 'assets/images/category/image9.png',
    ),
    CategoryItem(
      title: 'Maşyn ýuwmak',
      image: 'assets/images/category/image11.png',
    ),
    CategoryItem(
      title: 'Okuw gollanmalar',
      image: 'assets/images/category/image12.png',
    ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Divider(height: 2, color: Colors.grey[100]),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  const Text(
                    'All Category',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF5F7FF)),

            // List
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 60),
                color: const Color(0xFFF5F7FF),
                child: Container(

                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final item = categories[index];
                      return _CategoryTile(item: item);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final CategoryItem item;
  const _CategoryTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/categoryId', extra: item.title);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 46,
        child: Row(
          children: [
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: Color(0xFFF6F8FD),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.asset(
                item.image,
                width: 28,
                height: 28,
                errorBuilder: (_, __, ___) => Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F3FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.category,
                    color: AppColor.primary,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.black, size: 22),
          ],
        ),
      ),
    );
  }
}

class CategoryItem {
  final String title;
  final String image;
  const CategoryItem({required this.title, required this.image});
}
