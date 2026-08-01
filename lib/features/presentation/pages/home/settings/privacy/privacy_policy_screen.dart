import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/l10n/gen/app_localizations.dart';

/// Static privacy-policy page — content below is placeholder copy (matches
/// the pattern already used by the "why us" pages) until real legal text
/// is supplied.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    final descColor = AppColor.descriptionText(context);
    final t = AppLocalizations.of(context)!;

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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            AppBarWidget(textColor, isDark),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: textColor,
                    ),
                  ),
                  Text('Yza', style: TextStyle(fontSize: 16, color: textColor)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: AppColor.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.verified_user,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          t.privacyPolicy,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    _SectionTitle('1. Terms', textColor),
                    const SizedBox(height: 8),
                    _Paragraph(
                      'Tellus at sit ante rutrum suspendisse pretium, vitae '
                      'vel dignissim. Nunc, scelerisque adipiscing '
                      'condimentum massa dignissim tortor leo lacus. Sapien '
                      'felis ultrices fringilla nisi sit nibh. Etiam '
                      'volutpat nisl ornare lorem mus at a, et pulvinar.',
                      descColor,
                    ),
                    const SizedBox(height: 20),

                    _SectionTitle('2. Use License', textColor),
                    const SizedBox(height: 8),
                    _Paragraph(
                      'Fermentum erat nisl duis varius risus. Augue ac '
                      'facilisi porta metus enim. Ullamcorper lacus '
                      'praesent rhoncus, sapien rutrum nulla mattis vitae '
                      'ultrices.',
                      descColor,
                    ),
                    const SizedBox(height: 12),
                    _BulletList(
                      const [
                        'Fermentum erat nisl duis varius risus.',
                        'Augue ac facilisi porta metus enim.',
                        'Ullamcorper lacus praesent rhoncus, sapien rutrum '
                            'nulla mattis vitae ultrices.',
                        'Nunc, scelerisque adipiscing condimentum massa '
                            'dignissim tortor leo lacus.',
                      ],
                      descColor,
                    ),
                    const SizedBox(height: 20),

                    _Paragraph(
                      'Aliquam eget purus sit malesuada tempor euismod. '
                      'Eget commodo ultricies ut elit hendrerit risus. '
                      'Elementum tellus nisl lectus bibendum malesuada orci '
                      'dui. Nunc pharetra.',
                      descColor,
                    ),
                    const SizedBox(height: 24),
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

class _SectionTitle extends StatelessWidget {
  final String text;
  final Color color;
  const _SectionTitle(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: color),
    );
  }
}

class _Paragraph extends StatelessWidget {
  final String text;
  final Color color;
  const _Paragraph(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 13, color: color, height: 1.6),
      textAlign: TextAlign.justify,
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  final Color color;
  const _BulletList(this.items, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('•  ', style: TextStyle(fontSize: 13, color: color)),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(fontSize: 13, color: color, height: 1.5),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
