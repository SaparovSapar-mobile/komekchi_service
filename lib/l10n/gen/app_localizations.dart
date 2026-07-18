import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('tk'),
  ];

  /// Settings section header
  ///
  /// In tk, this message translates to:
  /// **'Sazlamalar'**
  String get settingsTitle;

  /// No description provided for @language.
  ///
  /// In tk, this message translates to:
  /// **'Diller'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In tk, this message translates to:
  /// **'Tema'**
  String get theme;

  /// No description provided for @myAddresses.
  ///
  /// In tk, this message translates to:
  /// **'Salgylarym'**
  String get myAddresses;

  /// No description provided for @voiceNotifications.
  ///
  /// In tk, this message translates to:
  /// **'Sesli bildirişler'**
  String get voiceNotifications;

  /// No description provided for @pinCode.
  ///
  /// In tk, this message translates to:
  /// **'Pin kod'**
  String get pinCode;

  /// No description provided for @languageTurkmen.
  ///
  /// In tk, this message translates to:
  /// **'Türkmen'**
  String get languageTurkmen;

  /// No description provided for @languageRussian.
  ///
  /// In tk, this message translates to:
  /// **'Rus dili'**
  String get languageRussian;

  /// No description provided for @languageEnglish.
  ///
  /// In tk, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @systemOption.
  ///
  /// In tk, this message translates to:
  /// **'Ulgam'**
  String get systemOption;

  /// No description provided for @themeLight.
  ///
  /// In tk, this message translates to:
  /// **'Ýagty'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In tk, this message translates to:
  /// **'Garaňky'**
  String get themeDark;

  /// No description provided for @aboutUs.
  ///
  /// In tk, this message translates to:
  /// **'Biz barada'**
  String get aboutUs;

  /// No description provided for @aboutCompany.
  ///
  /// In tk, this message translates to:
  /// **'Karhana barada'**
  String get aboutCompany;

  /// No description provided for @contactUs.
  ///
  /// In tk, this message translates to:
  /// **'Biz bilen habarlaşmak'**
  String get contactUs;

  /// No description provided for @writeLetter.
  ///
  /// In tk, this message translates to:
  /// **'Hat yazmak'**
  String get writeLetter;

  /// No description provided for @privacyPolicy.
  ///
  /// In tk, this message translates to:
  /// **'Gizlinlik syýasaty'**
  String get privacyPolicy;

  /// No description provided for @logoutSection.
  ///
  /// In tk, this message translates to:
  /// **'Akkountdan çykmak'**
  String get logoutSection;

  /// No description provided for @logout.
  ///
  /// In tk, this message translates to:
  /// **'Çykmak'**
  String get logout;

  /// No description provided for @deleteAccount.
  ///
  /// In tk, this message translates to:
  /// **'Hasabym pozmak'**
  String get deleteAccount;

  /// No description provided for @appUpdate.
  ///
  /// In tk, this message translates to:
  /// **'Programmany täzelemek'**
  String get appUpdate;

  /// No description provided for @newVersion.
  ///
  /// In tk, this message translates to:
  /// **'Täze wersiýa'**
  String get newVersion;

  /// No description provided for @myPage.
  ///
  /// In tk, this message translates to:
  /// **'Meniň sahypam'**
  String get myPage;

  /// No description provided for @user.
  ///
  /// In tk, this message translates to:
  /// **'Ulanyjy'**
  String get user;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'tk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'tk':
      return AppLocalizationsTk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
