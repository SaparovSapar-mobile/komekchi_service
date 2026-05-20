import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/features/presentation/pages/home/detail_screen/map.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/banner_slider.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/horizontal_service_list.dart';

import '../../../../core/utils/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  const HomeScreen({super.key, required this.scrollController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ServiceItem> services = [
    ServiceItem(
      title: 'Elektriçi',
      image: 'assets/images/newcategory/image.png',
    ),
    ServiceItem(
      title: 'Arassaçylyk',
      image: 'assets/images/newcategory/image2.png',
    ),
    ServiceItem(
      title: 'Ýük daşaýjy',
      image: 'assets/images/newcategory/image3.png',
    ),
    ServiceItem(
      title: 'Agaç ussa',
      image: 'assets/images/newcategory/image4.png',
    ),
    ServiceItem(
      title: 'Reňkleýji',
      image: 'assets/images/newcategory/image5.png',
    ),
    ServiceItem(title: 'Salon', image: 'assets/images/newcategory/image6.png'),
    ServiceItem(
      title: 'Toý bezegleri',
      image: 'assets/images/newcategory/image7.png',
    ),
    ServiceItem(
      title: 'Tehniki bejerijiler',
      image: 'assets/images/newcategory/image8.png',
    ),
    ServiceItem(
      title: 'Öý abatlaýyş',
      image: 'assets/images/newcategory/image9.png',
    ),
    ServiceItem(
      title: 'Hemmesi',
      image: 'assets/images/newcategory/image10.png',
    ),
  ];

  final List<BizItem> biz = [
    BizItem(image: 'assets/images/bizbarada/image1.png'),
    BizItem(image: 'assets/images/bizbarada/image2.png'),
    BizItem(image: 'assets/images/bizbarada/image3.png'),
    BizItem(image: 'assets/images/bizbarada/image4.png'),
    BizItem(image: 'assets/images/bizbarada/image5.png'),
    BizItem(image: 'assets/images/bizbarada/image6.png'),
  ];

  // void _showLocationDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: true, // закрыть при нажатии вне диалога
  //     builder: (context) => const SalgymLocationDialog(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor =  AppColor.titleText(context);
    // final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBarWidget(textColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showSalgyBottomSheet(context);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/logo/container.png",
                        width: 42,
                        height: 42,
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Salgym",
                            style: TextStyle(
                              color: isDark
                                  ? AppColor.titleDark
                                  : AppColor.primary,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Ýeriňizi giriziň ",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 18,
                                color: textColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),
                GestureDetector(
                  onTap: () {
                    context.push("/bells");
                  },
                  child: Image.asset(
                    "assets/images/logo/bells.png",
                    width: 42,
                    height: 42,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom ),
              controller: widget.scrollController,
              child: Column(
                children: [
                  const DividerWidget(),

                  GestureDetector(
                    onTap: () {
                      context.push("/allCategory");
                    },
                    child: const Subtitle(text: "Hyzmatlar"),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    itemCount: services.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 1,
                          childAspectRatio: 0.65,
                        ),
                    itemBuilder: (context, index) {
                      final item = services[index];
                      final cellWidth =
                          (MediaQuery.of(context).size.width - 28 - 8 * 4) / 5;

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              index == services.length - 1
                                  ? context.push("/allCategory")
                                  : context.push(
                                      "/categoryId",
                                      extra: services[index].title,
                                    );
                            },
                            child: Container(
                              width: cellWidth,
                              height: cellWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: cardBg,
                              ),
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: cellWidth,
                            child: Text(
                              item.title,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.028,
                                    color: textColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const DividerWidget(),
                  BannerSlider(),
                  const DividerWidget(),
                  HorizontalServiceList(
                    inAksiya: false,
                    text: "7/24 hyzmatlar",
                  ),
                  const DividerWidget(),
                  HorizontalServiceList(
                    inAksiya: false,
                    text: "Öňde baryjylar",
                  ),
                  const DividerWidget(),
                  HorizontalServiceList(inAksiya: true, text: "Aksiýalar"),
                  const DividerWidget(),
                  BannerSlider(),
                  const DividerWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 15.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Näme üçin biz?", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    itemCount: biz.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 80,
                        ),
                    itemBuilder: (context, index) {
                      final item = biz[index];
                      return GestureDetector(
                        onTap: () {
                          index == 0
                              ? context.push("/24goldaw")
                              : index == 1
                              ? context.push("/istertibi")
                              : index == 2
                              ? context.push("/kepilligi")
                              : index == 3
                              ? context.push("/hyzmatlar")
                              : index == 4
                              ? context.push("/toleg")
                              : context.push("/ynamdar");
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            item.image,
                            width: 110,
                            height: 80,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image, color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  final String text;
  const Subtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =  AppColor.titleText(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(text, style: TextStyle(color: textColor),),
          SizedBox(width: 7),
          Icon(Icons.keyboard_arrow_right, size: 20, color: textColor),
        ],
      ),
    );
  }
}

class ServiceItem {
  final String title;
  final String image;

  ServiceItem({required this.title, required this.image});
}

class BizItem {
  final String image;

  BizItem({required this.image});
}

Padding AppBarWidget(Color textColor) {


  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.31),
    child: Row(
      children: [
        Image.asset("assets/images/logo/appbar.png", width: 61, height: 29),
        const Spacer(),
        Text(
          getCurrentDate(),
          style: TextStyle(fontSize: 12, color: textColor),
        ),
        const SizedBox(width: 2),
        const Text("|"),
        const SizedBox(width: 2),
         Icon(Icons.cloud, size: 12, color: textColor),
         Text(
          " 32° Aşgabat",
          style: TextStyle(fontSize: 12, color: textColor),
        ),
      ],
    ),
  );
}

String getCurrentDate() {
  final now = DateTime.now();

  final day = now.day.toString().padLeft(2, '0');
  final month = now.month.toString().padLeft(2, '0');
  final year = now.year;

  return '$day.$month.$year';
}
