import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';

import '../../../../../../core/utils/theme/app_colors.dart';

class Toleg extends StatelessWidget {
  const Toleg({super.key});

  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.pageBg(context);
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    final borderColor = AppColor.border(context);

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
            AppBarWidget(textColor, isDark), Divider(height: 1, color: bg),

            // Back
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  Text('Yza', style: TextStyle(fontSize: 16, color: textColor)),
                ],
              ),
            ),
            Divider(height: 1, color: bg),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon + Title
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F0FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            size: 34,
                            color: AppColor.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                         Text(
                          'Töleg mümkinçilikleri',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Intro text
                    Text(
                      'Biz müşderilerimize amatly bolar ýaly dürli töleg görnüşlerini hödürleýäris.',
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),

                    // Payment options list
                    ...[
                      _PaymentItem(
                        title: 'Nagt töleg',
                        subtitle: 'Sargyt gelende nagt töleg.',
                        bg: textColor,
                      ),
                      _PaymentItem(
                        title: 'Terminal töleg',
                        subtitle: 'Sargydy bank kart arkaly töleg.',
                        bg: textColor,

                      ),
                      _PaymentItem(
                        title: 'Onlaýn töleg',
                        subtitle: 'Sargydy bank kart arkaly töleg.',
                        bg: textColor,

                      ),
                    ],

                    const SizedBox(height: 16),

                    // Bottom text
                    Text(
                      'arkaly amala aşyryp bilersiňiz. Şeýle hem öňünden bron eden hyzmatlarynyz üçin öňünden ýa-da hyzmat ýerine ýetirildenden soň töleg etmek mümkinçiligi bardyr.\nBiziň maksadymyz — töleg prosesini mümkin boldugyça ýeňil, çalt we amatly etmekdir.',
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
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

class _PaymentItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bg;

  const _PaymentItem({required this.title, required this.subtitle, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 22),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:  TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: bg,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
