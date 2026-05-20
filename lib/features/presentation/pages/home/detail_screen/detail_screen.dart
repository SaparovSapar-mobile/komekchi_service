import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/features/presentation/pages/home/detail_screen/nagilelik_bottomsheet.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import 'map.dart';

class DetailScreen extends StatefulWidget {
  final String? title;
  final String image;
  final String? titleImage;
  const DetailScreen({
    super.key,
    this.title,
    required this.image,
    this.titleImage,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  bool isFavorite = false;
  int price = 50;
  bool isExpanded = false;

  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSalgyBottomSheet(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    // final bg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    // final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
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
            Divider(height: 1, color: Color(0xFFF5F7FF)),

            // Back button + title + more
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
                    widget.title!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => showNagilelikBottomSheet(context),
                    icon: const Icon(Icons.more_vert, color: Colors.black),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Color(0xFFF5F7FF)),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kartinka
                    Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                widget.image,
                                width: 350,
                                height: 184,
                                // fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 350,
                                  height: 184,
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Badge
                      ],
                    ),

                    // Category breadcrumb
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(6),
                            ),

                            child: Text(
                              "Kategoriýa",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 16,
                            color: Colors.grey.shade400,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              widget.title!,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColor.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        widget.titleImage!,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Views + favorite + rating
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          const Text(
                            '10K',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.remove_red_eye_outlined,
                            size: 16,
                            color: Colors.black,
                          ),
                          const Spacer(),
                          Container(
                            width: 32,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0xFFF6F8FD),
                            ),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => isFavorite = !isFavorite),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 22,
                                color: isFavorite
                                    ? Colors.red
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0xFFF6F8FD),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  '4.7',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Orange info banner
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFCFBFB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/icon/image1.png",
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFFF6600),
                                  ),
                                  children: const [
                                    TextSpan(
                                      text:
                                          'Biziň arassaçylyk işleri hyzmatymyzda 40% arzanladyş bar! ',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Bahasy + counter
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bahasy',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF3D3C3C),
                                ),
                              ),
                              Text(
                                '50 tmt',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.primary,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Counter
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (quantity > 1)
                                    setState(() {
                                      quantity--;
                                      price -= 50;
                                    });
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: const Icon(Icons.remove, size: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                    price += 50;
                                  });
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColor.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Barada (description)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 6,
                      ),
                      child: Text(
                        'Barada',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: isExpanded
                                  ? 'Hapyny gündelik wagtlarda, nahardan öň ya-da soň kabul etmek maslahat berilýär. Hapynyň ýokumly täsirleri adatça 15-30 minutdan soň başlaýar we 4-6 sagat dowam edýär.'
                                  : 'Hapyny gündelik wagtlarda, nahardan öň ya-da soň kabul etmek maslahat berilýär. Hapynyň ýokumly täsirleri adatça 15-30 minutdan soň başlaýar... ',
                            ),

                            TextSpan(
                              text: isExpanded ? ' Ýygna' : ' Ähliisini Okamak',
                              style: TextStyle(color: AppColor.primary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action buttons: Call, Chat, Map, Share
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/details/image1.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Jaň etmek",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF3D3C3C),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/details/image2.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                  const SizedBox(height: 4),

                                  Text(
                                    "SMS",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF3D3C3C),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/details/image3.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                  const SizedBox(height: 4),

                                  Text(
                                    "Karta",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF3D3C3C),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/details/image4.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                  const SizedBox(height: 4),

                                  Text(
                                    "Paýlaşmak",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF3D3C3C),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [],
                          ),
                        ],
                      ),
                    ),

                    // Price breakdown
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _PriceRow(
                              label: 'Hyzmat bahasy:',
                              value: '200 TMT',
                            ),
                            const SizedBox(height: 8),
                            _PriceRow(label: 'Arzanladyş:', value: '15%'),
                            const SizedBox(height: 8),
                            _PriceRow(
                              label: 'Maslahat bermek:',
                              value: '20.00 man',
                            ),
                            const SizedBox(height: 12),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/icon/i.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Töleg şertleri: 100% göteriml öňünden bank ulgamynyň üsti bilen tölemek şertinde.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.32,
                                  height: 53,
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    top: 4,
                                    bottom: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Jemi:",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "${price * quantity} tmt",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFFF5050),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.push("/date");
                                    },
                                    child: Container(
                                      width: screenWidth * 0.6,
                                      height: 53,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 38.5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.primary,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Tassyklamak",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 4.5),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: 23,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;

  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class ServiceItem {
  final String title;
  final String image;

  ServiceItem({required this.title, required this.image});
}
