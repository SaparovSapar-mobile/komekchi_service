import 'package:flutter/material.dart';

import '../../../../../l10n/gen/app_localizations.dart';
import 'bronlar_screen.dart';

class StatusBadge extends StatelessWidget {
  final BronStatus status;
  const StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case BronStatus.pending:
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange;
        label = t.statusPending;
        break;
      case BronStatus.completed:
        bgColor = Colors.green.shade50;
        textColor = Colors.green;
        label = t.tabCompleted;
        break;
      case BronStatus.cancelled:
        bgColor = Colors.red.shade50;
        textColor = Colors.red;
        label = t.tabCancelled;
        break;
      case BronStatus.unknown:
        bgColor = Colors.grey.shade200;
        textColor = Colors.grey;
        label = t.statusUnknown;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: textColor, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
