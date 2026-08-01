import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class BildirislerScreen extends StatelessWidget {
  const BildirislerScreen({super.key});

  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
  }

  final List<BildirisItem> items = const [
    BildirisItem(
      image: "assets/images/bells/image1.png",
      title: 'Arassaçylyk',
      subtitle: 'Aýna ýuwmak',
      date: '11.11.2026  19:00',
      description: 'Görkezilen hyzmatymyzda 10% arzanlady...',
      status: BildirisStatus.okaldy,
      hasArrow: true,
    ),
    BildirisItem(
      image: "assets/images/bells/image2.png",
      title: 'Maşyn ýuwmak',
      subtitle: 'Tutuş salony plesos etmek',
      date: '11.11.2026  19:00',
      description: 'Täze goşulan kategoriýamyzdan peýdalan...',
      status: BildirisStatus.okaldy,
      hasArrow: true,
    ),
    BildirisItem(
      image: "assets/images/bells/image1.png",
      title: 'Arassaçylyk',
      subtitle: 'Aýna ýuwmak',
      date: '11.11.2026  19:00',
      description: 'Ýetişiň! 20% ARZANLADYŞ...',
      status: BildirisStatus.okalmady,
      hasArrow: true,
    ),
    BildirisItem(
      image: "assets/images/bells/image3.png",
      title: 'Ýerine ýetirildi',
      subtitle: '',
      date: '11.11.2026  19:00',
      description: 'Siziň hyzmatyňyz üstünlikli...',
      status: BildirisStatus.okalmady,
      hasArrow: false,
    ),
    BildirisItem(
      image: "assets/images/bells/image3.png",
      title: 'Hyzmat ýatyryldy',
      subtitle: '',
      date: '11.11.2026  19:00',
      description: 'Siziň hyzmatyňyz üstünlikli...',
      status: BildirisStatus.okalmady,
      hasArrow: false,
    ),
    BildirisItem(
      image: "assets/images/bells/image5.png",
      title: 'Bildiriş!!!',
      subtitle: '',
      date: '11.11.2026  19:00',
      description: 'Hormatly müşderi, hyzmat...',
      status: BildirisStatus.okalmady,
      hasArrow: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.pageBg(context);
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);

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
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Header
            AppBarWidget(textColor, isDark), Divider(height: 1, color: cardBg),

            // Back + Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                   Text(
                    'Bildirişler',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColor.titleText(context),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: cardBg),

            // List
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(color: cardBg),
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1, color: cardBg),
                  itemBuilder: (context, index) {
                    return _BildirisCard(item: items[index], bg: bg,);
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

class _BildirisCard extends StatelessWidget {
  final BildirisItem item;
  final Color bg;
  const _BildirisCard({required this.item, required this.bg});

  @override
  Widget build(BuildContext context) {
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 112,

        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2.5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(item.image, width: 38, height: 38),
                ),
                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // Title + arrow
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style:  TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                                ),
                                if (item.subtitle.isNotEmpty)
                                  Text(
                                    item.subtitle,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColor.descriptionText(context),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (item.hasArrow)
                            Icon(
                              Icons.chevron_right,
                              color: textColor,
                              size: 20,
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Date
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              item.date,
              style: TextStyle(fontSize: 12, color: AppColor.descriptionText(context)),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.description,
                    style: TextStyle(fontSize: 12, color: AppColor.descriptionText(context)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                // Status
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Text(
                        item.status == BildirisStatus.okaldy
                            ? 'okaldy'
                            : 'okalmady',
                        style: TextStyle(
                          fontSize: 10,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item.status == BildirisStatus.okaldy
                              ? Color(0xFF047857)
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum BildirisStatus { okaldy, okalmady }

class BildirisItem {
  final String image;
  final String title;
  final String subtitle;
  final String date;
  final String description;
  final BildirisStatus status;
  final bool hasArrow;

  const BildirisItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.description,
    required this.status,
    required this.hasArrow,
  });
}
