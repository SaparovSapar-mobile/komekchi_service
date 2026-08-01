import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../l10n/gen/app_localizations.dart';
import '../settings_card.dart';
import '../settings_row.dart';

/// "Biz barada" section.
class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return SectionCard(
      text: t.aboutUs,
      children: [
        SettingsRow(
          image: "assets/images/settings/!.png",
          iconColor: Colors.blue,
          title: t.aboutCompany,
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          onTap: () => context.push('/24goldaw'),
        ),
        SettingsRow(
          image: "assets/images/settings/contactus.png",
          iconColor: Colors.blue,
          title: t.contactUs,
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          onTap: () {
            context.push('/contactUs');
          },
        ),
        SettingsRow(
          image: "assets/images/settings/chat.png",
          iconColor: Colors.blue,
          title: t.writeLetter,
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          onTap: () {
            context.push('/nagilelik');
          },
        ),
        SettingsRow(
          image: "assets/images/settings/verify.png",
          iconColor: Colors.blue,
          title: t.privacyPolicy,
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          onTap: () => context.push('/privacyPolicy'),
        ),
      ],
    );
  }
}
