import 'package:flutter/widgets.dart';

import '../../features/domain/entities/about.dart';
import '../../features/domain/entities/aksiya.dart';
import '../../features/domain/entities/banners.dart';
import '../../features/domain/entities/category.dart';
import '../../features/domain/entities/common.dart';
import '../../features/domain/entities/subcategory.dart';

/// Picks the field matching the app's current language out of the three
/// backend-supplied variants (Turkmen/Russian/English). Unlike local UI
/// strings (AppLocalizations), these come from content the backend already
/// translated per-item — they just weren't being switched with the rest of
/// the UI.
String localizedField(
  BuildContext context, {
  required String tm,
  required String ru,
  required String en,
}) {
  switch (Localizations.localeOf(context).languageCode) {
    case 'ru':
      return ru;
    case 'en':
      return en;
    default:
      return tm;
  }
}

extension CategoryItemLocalization on CategoryItem {
  String name(BuildContext context) =>
      localizedField(context, tm: nameTm, ru: nameRu, en: nameEn);
  String desc(BuildContext context) =>
      localizedField(context, tm: descTm, ru: descRu, en: descEn);
}

extension SubcategoryItemLocalization on SubcategoryItem {
  String name(BuildContext context) =>
      localizedField(context, tm: nameTm, ru: nameRu, en: nameEn);
  String desc(BuildContext context) =>
      localizedField(context, tm: descTm, ru: descRu, en: descEn);
}

extension AboutItemLocalization on AboutItem {
  String name(BuildContext context) =>
      localizedField(context, tm: nameTm, ru: nameRu, en: nameEn);
  String desc(BuildContext context) =>
      localizedField(context, tm: descTm, ru: descRu, en: descEn);
}

extension WarningDescLocalization on WarningDesc {
  String desc(BuildContext context) =>
      localizedField(context, tm: descTm, ru: descRu, en: descEn);
}

extension BannerItemLocalization on BannerItem {
  String img(BuildContext context) =>
      localizedField(context, tm: imgTm, ru: imgRu, en: imgEn);
}

extension AksiyaItemLocalization on AksiyaItem {
  String img(BuildContext context) =>
      localizedField(context, tm: imgTm, ru: imgRu, en: imgEn);
}
