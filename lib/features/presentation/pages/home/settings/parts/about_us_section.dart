import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../settings_card.dart';
import '../settings_row.dart';

/// "Biz barada" section.
class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      text: 'Biz barada',
      children: [
        SettingsRow(
          image: "assets/images/settings/!.png",
          iconColor: Colors.blue,
          title: 'Karhana barada',
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          onTap: () => context.push('/24goldaw'),
        ),
        SettingsRow(
          image: "assets/images/settings/contactus.png",
          iconColor: Colors.blue,
          title: 'Biz bilen habarlaşmak',
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          onTap: () {
            context.push('/contactUs');
          },
        ),
        SettingsRow(
          image: "assets/images/settings/chat.png",
          iconColor: Colors.blue,
          title: 'Hat yazmak',
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          onTap: () {
            context.push('/nagilelik');
          },
        ),
        SettingsRow(
          image: "assets/images/settings/verify.png",
          iconColor: Colors.blue,
          title: 'Gizlinlik syýasaty',
          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
          onTap: () {},
        ),
      ],
    );
  }
}
