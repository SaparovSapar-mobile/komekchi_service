import 'package:flutter/material.dart';

import '../bottom_sheet.dart';
import '../settings_card.dart';
import '../settings_row.dart';

/// "Akkountdan çykmak" section.
class LogoutSection extends StatelessWidget {
  final bool isLoggedIn;

  const LogoutSection({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      text: 'Akkountdan çykmak',
      children: [
        if (isLoggedIn) ...[
          SettingsRow(
            image: "assets/images/settings/logout.png",
            iconColor: Colors.blue,
            title: 'Çykmak',
            trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
            onTap: () {
              logOutShowBottomSheet(context);
            },
          ),
          SettingsRow(
            image: "assets/images/settings/trash.png",
            iconColor: Colors.red,
            title: 'Hasabym pozmak',
            trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
            onTap: () {},
          ),
        ],
        SettingsRow(
          isLast: true,
          image: "assets/images/settings/version.png",
          iconColor: Colors.blue,
          title: 'Programmany täzelemek',
          subtitle: 'Version 2.14.0',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Täze wersiýa',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
              const SizedBox(width: 4),
              Icon(Icons.refresh, size: 16, color: Colors.grey.shade500),
            ],
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
