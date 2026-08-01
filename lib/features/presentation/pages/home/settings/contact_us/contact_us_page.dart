import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/contact_us/parts/contact_card.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/contact_us/parts/contact_section_title.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/contact_us/parts/contact_support_row.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/contact_us/parts/office_map_card.dart';

import '../../../../../../core/utils/theme/app_colors.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.cardBg(context);
    final cardBg = AppColor.pageBg(context);
    final textColor = AppColor.titleText(context);
    final subTextColor = AppColor.descriptionText(context);

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
          color: bg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            AppBarWidget(textColor, isDark),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Yza (back)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                              color: textColor,
                            ),
                          ),
                          Text(
                            'Yza',
                            style: TextStyle(fontSize: 16, color: textColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    ContactSupportRow(
                      cardBg: cardBg,
                      textColor: textColor,
                      label: 'Biz bilen habarlaşmak',
                      onTap: () => context.push('/hatYazmak'),
                    ),

                    const SizedBox(height: 24),

                    // Kontaktlar section
                    ContactSectionTitle(
                      title: 'Kontaktlar',
                      textColor: textColor,
                    ),
                    ContactCard(
                      cardBg: cardBg,
                      items: const [
                        ContactItem(
                          image: 'assets/images/social/call.png',
                          text: '+993 63509004',
                          color: AppColor.primary,
                        ),
                        ContactItem(
                          image: 'assets/images/social/call.png',
                          text: '+993 63509004',
                          color: AppColor.primary,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Social media section
                    ContactSectionTitle(
                      title: 'Social media salgylanmalar',
                      textColor: textColor,
                    ),
                    ContactCard(
                      cardBg: cardBg,
                      items: const [
                        ContactItem(
                          image: 'assets/images/social/tiktok.png',
                          text: 'komekchieller@',
                          color: AppColor.primary,
                        ),
                        ContactItem(
                          image: 'assets/images/social/telegram.png',
                          text: 'komekchieller@',
                          color: AppColor.primary,
                        ),
                        ContactItem(
                          image: 'assets/images/social/instagram.png',
                          text: 'komekchieller@',
                          color: AppColor.primary,
                        ),
                        ContactItem(
                          image: 'assets/images/social/gmail.png',
                          text: 'komekchieller@',
                          color: AppColor.primary,
                        ),
                        ContactItem(
                          image: 'assets/images/social/linkedin.png',
                          text: 'komekchieller@',
                          color: AppColor.primary,
                        ),
                        ContactItem(
                          image: 'assets/images/social/what.png',
                          text: 'komekchieller@',
                          color: AppColor.primary,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Karta section
                    ContactSectionTitle(
                      title: 'Karta salgymyz',
                      textColor: textColor,
                    ),
                    OfficeMapCard(cardBg: cardBg, subTextColor: subTextColor),

                    const SizedBox(height: 32),
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
