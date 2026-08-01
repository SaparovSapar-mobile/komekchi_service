import 'package:flutter/material.dart';
import 'package:komekchi_service/l10n/gen/app_localizations.dart';

/// Backend address types come as fixed codes ('home_address', 'work_address',
/// 'other') — map them to a localized label so the display changes with the
/// app language even though the code itself doesn't.
String addressTypeLabel(AppLocalizations t, String name) {
  switch (name) {
    case 'home_address':
      return t.addressTypeHome;
    case 'work_address':
      return t.addressTypeWork;
    case 'other':
      return t.addressTypeOther;
    default:
      return name;
  }
}

IconData addressTypeIcon(String name) {
  switch (name) {
    case 'home_address':
      return Icons.home_outlined;
    case 'work_address':
      return Icons.work_outline;
    default:
      return Icons.location_on_outlined;
  }
}
