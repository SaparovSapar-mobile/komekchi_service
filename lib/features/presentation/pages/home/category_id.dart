import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';

import '../../../../core/utils/theme/app_colors.dart';

class CategoryId extends StatefulWidget {
  final String title;
  const CategoryId({super.key, required this.title});

  @override
  State<CategoryId> createState() => _CategoryIdState();
}

class _CategoryIdState extends State<CategoryId> {
  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
  }

  final List<ServiceItem> services = [
    ServiceItem(title: 'Aýna ýuwmak', image: 'assets/images/hyzmat/image1.png'),
    ServiceItem(
      title: 'Balkon arassalamak',
      image: 'assets/images/hyzmat/image2.png',
    ),
    ServiceItem(
      title: 'Plesos Edip Bermek',
      image: 'assets/images/hyzmat/image3.png',
    ),
    ServiceItem(title: 'Aýna ýuwmak', image: 'assets/images/hyzmat/image1.png'),
    ServiceItem(title: 'Aýna ýuwmak', image: 'assets/images/hyzmat/image1.png'),
  ];

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    // final bg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor =  AppColor.titleText(context);
    // final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;

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
            AppBarWidget(textColor),
            // Back button + title + search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const SizedBox(height: 49),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context.push('/search');
                    },
                    icon: Image.asset(
                      "assets/images/icon/search.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),

            // List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 5),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final item = services[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16,
                      left: 22,
                      right: 22,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.push(
                          "/detail",
                          extra: {
                            "title": widget.title,
                            "image": services[index].image,
                            "titleImage": services[index].title,
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFEBEBEB)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Kartinka s badge
                            Stack(
                              children: [
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9.46),
                                    child: Image.asset(
                                      item.image,
                                      width: 352,
                                      height: 160,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                width: 332,
                                                height: 149,
                                                color: Colors.grey.shade200,
                                                child: const Icon(
                                                  Icons.image,
                                                  color: Colors.grey,
                                                  size: 40,
                                                ),
                                              ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Nazvanie + reiting
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "4.7",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    const Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceItem {
  final String title;
  final String image;

  ServiceItem({required this.title, required this.image});
}
