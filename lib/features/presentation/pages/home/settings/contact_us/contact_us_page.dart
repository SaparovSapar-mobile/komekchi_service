import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';

import '../../../../../../core/utils/theme/app_colors.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final cardBg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
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

                    // Biz bilen habarlaşmak
                    GestureDetector(
                      onTap: () => context.push('/hatYazmak'),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColor.primary.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.support_agent,
                                size: 20,
                                color: AppColor.primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Biz bilen habarlaşmak',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: textColor,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Kontaktlar section
                    _SectionTitle(title: 'Kontaktlar', textColor: textColor),
                    _ContactCard(
                      cardBg: cardBg,
                      items: const [
                        _ContactItem(
                          icon: Icons.phone_outlined,
                          text: '+993 63509004',
                          color: AppColor.primary,
                        ),
                        _ContactItem(
                          icon: Icons.phone_outlined,
                          text: '+993 63509004',
                          color: AppColor.primary,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Social media section
                    _SectionTitle(
                      title: 'Social media salgylanmalar',
                      textColor: textColor,
                    ),
                    _ContactCard(
                      cardBg: cardBg,
                      items: const [
                        _ContactItem(
                          icon: Icons.music_note_rounded,
                          text: 'komekchieller@',
                          color: Colors.black,
                        ),
                        _ContactItem(
                          icon: Icons.send_rounded,
                          text: 'komekchieller@',
                          color: Color(0xFF0088CC),
                        ),
                        _ContactItem(
                          icon: Icons.camera_alt_rounded,
                          text: 'komekchieller@',
                          color: Color(0xFFE1306C),
                        ),
                        _ContactItem(
                          icon: Icons.email_rounded,
                          text: 'komekchieller@',
                          color: Color(0xFFEA4335),
                        ),
                        _ContactItem(
                          icon: Icons.work_rounded,
                          text: 'komekchieller@',
                          color: Color(0xFF0077B5),
                        ),
                        _ContactItem(
                          icon: Icons.chat_rounded,
                          text: 'komekchieller@',
                          color: Color(0xFF25D366),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Karta section
                    _SectionTitle(
                      title: 'Karta salgymyz',
                      textColor: textColor,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          // Map placeholder
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Container(
                              height: 160,
                              color: const Color(0xFFE5E5E5),
                              child:  Center(
                                child: Image.asset('assets/images/service/map.png')
                              ),
                            ),
                          ),
                          // Address row
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [ 
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Color(0xFF007AFF),
                                  size: 22,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Söwda merkezi "Uniwersmag" 3-nji gat,\ndükan belgi C42 Magtymguly 73, Aşgabat',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: subTextColor,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.north_east,
                                  size: 18,
                                  color: Color(0xFF007AFF),
                                ),
                              ], 
                            ),
                          ),
                        ],
                      ),
                    ),

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

// ─── Section Title ───────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  final Color textColor;

  const _SectionTitle({required this.title, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}

// ─── Contact Item Model ───────────────────────────────────────────
class _ContactItem {
  final IconData icon;
  final String text;
  final Color color;

  const _ContactItem({
    required this.icon,
    required this.text,
    required this.color,
  });
}

// ─── Contact Card ─────────────────────────────────────────────────
class _ContactCard extends StatelessWidget {
  final Color cardBg;
  final List<_ContactItem> items;

  const _ContactCard({required this.cardBg, required this.items});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final dividerColor = isDark
        ? Colors.white12
        : Colors.black.withOpacity(0.08);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return Column(
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: item.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(item.icon, color: item.color, size: 18),
                      ),
                      const SizedBox(width: 12),
                      // Text
                      Expanded(
                        child: Text(
                          item.text,
                          style: TextStyle(fontSize: 14, color: textColor),
                        ),
                      ),
                      // Arrow
                      Icon(
                        Icons.north_east,
                        size: 16,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ],
                  ),
                ),
              ),
              if (i < items.length - 1)
                Divider(
                  height: 1,
                  thickness: 0.5,
                  indent: 58,
                  color: dividerColor,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
