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

  /// No description provided for @homeServices.
  ///
  /// In tk, this message translates to:
  /// **'Hyzmatlar'**
  String get homeServices;

  /// No description provided for @home247Services.
  ///
  /// In tk, this message translates to:
  /// **'7/24 hyzmatlar'**
  String get home247Services;

  /// No description provided for @homeTopProviders.
  ///
  /// In tk, this message translates to:
  /// **'Öňde baryjylar'**
  String get homeTopProviders;

  /// No description provided for @homePromotions.
  ///
  /// In tk, this message translates to:
  /// **'Aksiýalar'**
  String get homePromotions;

  /// No description provided for @homeWhyUs.
  ///
  /// In tk, this message translates to:
  /// **'Näme üçin biz?'**
  String get homeWhyUs;

  /// No description provided for @homeServiceNotFound.
  ///
  /// In tk, this message translates to:
  /// **'Hyzmat tapylmady'**
  String get homeServiceNotFound;

  /// No description provided for @salgymTitle.
  ///
  /// In tk, this message translates to:
  /// **'Salgym'**
  String get salgymTitle;

  /// No description provided for @salgymEnterLocation.
  ///
  /// In tk, this message translates to:
  /// **'Ýeriňizi giriziň'**
  String get salgymEnterLocation;

  /// No description provided for @biz247Support.
  ///
  /// In tk, this message translates to:
  /// **'7/24 goldaw'**
  String get biz247Support;

  /// No description provided for @bizWorkSchedule.
  ///
  /// In tk, this message translates to:
  /// **'Iş tertibi'**
  String get bizWorkSchedule;

  /// No description provided for @bizWorkGuarantee.
  ///
  /// In tk, this message translates to:
  /// **'Iş kepilligi'**
  String get bizWorkGuarantee;

  /// No description provided for @bizCustomerService.
  ///
  /// In tk, this message translates to:
  /// **'Müşderi hyzmatlary'**
  String get bizCustomerService;

  /// No description provided for @bizPaymentOptions.
  ///
  /// In tk, this message translates to:
  /// **'Töleg mümkinçilikleri'**
  String get bizPaymentOptions;

  /// No description provided for @bizTrusted.
  ///
  /// In tk, this message translates to:
  /// **'Ynamdar'**
  String get bizTrusted;

  /// No description provided for @bronlarTitle.
  ///
  /// In tk, this message translates to:
  /// **'Bronlarym'**
  String get bronlarTitle;

  /// No description provided for @tabAll.
  ///
  /// In tk, this message translates to:
  /// **'Hemmesi'**
  String get tabAll;

  /// No description provided for @tabPending.
  ///
  /// In tk, this message translates to:
  /// **'Garasylyar'**
  String get tabPending;

  /// No description provided for @tabCancelled.
  ///
  /// In tk, this message translates to:
  /// **'Ýatyryldy'**
  String get tabCancelled;

  /// No description provided for @tabCompleted.
  ///
  /// In tk, this message translates to:
  /// **'Tamamlanan'**
  String get tabCompleted;

  /// No description provided for @cancelBookingTitle.
  ///
  /// In tk, this message translates to:
  /// **'Bron ýatyrylsynmy?'**
  String get cancelBookingTitle;

  /// No description provided for @cancelBookingBody.
  ///
  /// In tk, this message translates to:
  /// **'N°{code} bronyny ýatyrmak isleýärsiňizmi?'**
  String cancelBookingBody(String code);

  /// No description provided for @no.
  ///
  /// In tk, this message translates to:
  /// **'Ýok'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In tk, this message translates to:
  /// **'Howa'**
  String get yes;

  /// No description provided for @retry.
  ///
  /// In tk, this message translates to:
  /// **'Gaýtadan synanyşmak'**
  String get retry;

  /// No description provided for @orderQuantity.
  ///
  /// In tk, this message translates to:
  /// **'Sany: {count}'**
  String orderQuantity(int count);

  /// No description provided for @orderTotal.
  ///
  /// In tk, this message translates to:
  /// **'Jemi: '**
  String get orderTotal;

  /// No description provided for @complain.
  ///
  /// In tk, this message translates to:
  /// **'Şikaýat etmek'**
  String get complain;

  /// No description provided for @cancelBooking.
  ///
  /// In tk, this message translates to:
  /// **'Ýatyrmak'**
  String get cancelBooking;

  /// No description provided for @rateService.
  ///
  /// In tk, this message translates to:
  /// **'Baha bermek'**
  String get rateService;

  /// No description provided for @statusPending.
  ///
  /// In tk, this message translates to:
  /// **'Garaşylýar'**
  String get statusPending;

  /// No description provided for @statusUnknown.
  ///
  /// In tk, this message translates to:
  /// **'Näbelli'**
  String get statusUnknown;

  /// No description provided for @complainSheetTitle.
  ///
  /// In tk, this message translates to:
  /// **'Şikaýat etmek!'**
  String get complainSheetTitle;

  /// No description provided for @addressTypeHome.
  ///
  /// In tk, this message translates to:
  /// **'Öý'**
  String get addressTypeHome;

  /// No description provided for @addressTypeWork.
  ///
  /// In tk, this message translates to:
  /// **'Iş'**
  String get addressTypeWork;

  /// No description provided for @addressTypeOther.
  ///
  /// In tk, this message translates to:
  /// **'Başga'**
  String get addressTypeOther;

  /// No description provided for @addressSheetTitle.
  ///
  /// In tk, this message translates to:
  /// **'Salgy ady'**
  String get addressSheetTitle;

  /// No description provided for @noAddresses.
  ///
  /// In tk, this message translates to:
  /// **'Salgy ýok'**
  String get noAddresses;

  /// No description provided for @deleteAddressTitle.
  ///
  /// In tk, this message translates to:
  /// **'Salgyny pozmalymy?'**
  String get deleteAddressTitle;

  /// No description provided for @addNewAddress.
  ///
  /// In tk, this message translates to:
  /// **'Täze salgy goşmak'**
  String get addNewAddress;

  /// No description provided for @editAddressTitle.
  ///
  /// In tk, this message translates to:
  /// **'Salgyny üýtgetmek'**
  String get editAddressTitle;

  /// No description provided for @newAddressTitle.
  ///
  /// In tk, this message translates to:
  /// **'Salgy atiandyr'**
  String get newAddressTitle;

  /// No description provided for @addressHint.
  ///
  /// In tk, this message translates to:
  /// **'Howly jaý'**
  String get addressHint;

  /// No description provided for @addressType.
  ///
  /// In tk, this message translates to:
  /// **'Salgy görnüşi'**
  String get addressType;

  /// No description provided for @edit.
  ///
  /// In tk, this message translates to:
  /// **'Üýtgetmek'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In tk, this message translates to:
  /// **'Goşmak'**
  String get add;

  /// No description provided for @authLoginTitle.
  ///
  /// In tk, this message translates to:
  /// **'Hasaba durmak'**
  String get authLoginTitle;

  /// No description provided for @authRegisterTitle.
  ///
  /// In tk, this message translates to:
  /// **'Agza bolmak'**
  String get authRegisterTitle;

  /// No description provided for @tabPhone.
  ///
  /// In tk, this message translates to:
  /// **'Telefon belgi'**
  String get tabPhone;

  /// No description provided for @tabEmail.
  ///
  /// In tk, this message translates to:
  /// **'Email'**
  String get tabEmail;

  /// No description provided for @phoneLabel.
  ///
  /// In tk, this message translates to:
  /// **'Telefon belgiňiz'**
  String get phoneLabel;

  /// No description provided for @emailHint.
  ///
  /// In tk, this message translates to:
  /// **'Emailyňyzy giriziň'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In tk, this message translates to:
  /// **'Açar sözi'**
  String get passwordLabel;

  /// No description provided for @forgotPasswordLink.
  ///
  /// In tk, this message translates to:
  /// **'Açar sözi ýatdan çykardym'**
  String get forgotPasswordLink;

  /// No description provided for @confirmButton.
  ///
  /// In tk, this message translates to:
  /// **'Tassyklamak'**
  String get confirmButton;

  /// No description provided for @errorPrefix.
  ///
  /// In tk, this message translates to:
  /// **'Ýalňyşlyk: {error}'**
  String errorPrefix(String error);

  /// No description provided for @nameLabel.
  ///
  /// In tk, this message translates to:
  /// **'Ady Familýasy'**
  String get nameLabel;

  /// No description provided for @nameHint.
  ///
  /// In tk, this message translates to:
  /// **'Adyňyzy giriziň'**
  String get nameHint;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In tk, this message translates to:
  /// **'Açar sözüňizi tassyklaň'**
  String get confirmPasswordLabel;

  /// No description provided for @agreeTerms.
  ///
  /// In tk, this message translates to:
  /// **'Düzgünler bilen tanyşdym?'**
  String get agreeTerms;

  /// No description provided for @sendCode.
  ///
  /// In tk, this message translates to:
  /// **'Kod ugratmak'**
  String get sendCode;

  /// No description provided for @confirmedTitle.
  ///
  /// In tk, this message translates to:
  /// **'Tassyklandy!'**
  String get confirmedTitle;

  /// No description provided for @continueButton.
  ///
  /// In tk, this message translates to:
  /// **'Dowam etmek'**
  String get continueButton;

  /// No description provided for @repeatPasswordLabel.
  ///
  /// In tk, this message translates to:
  /// **'Açar sözi gaýtala'**
  String get repeatPasswordLabel;

  /// No description provided for @confirmShort.
  ///
  /// In tk, this message translates to:
  /// **'Tassykla'**
  String get confirmShort;

  /// No description provided for @phoneDigitsError.
  ///
  /// In tk, this message translates to:
  /// **'8 sanly bolmaly'**
  String get phoneDigitsError;

  /// No description provided for @smsEmailNotFound.
  ///
  /// In tk, this message translates to:
  /// **'Email tapylmady'**
  String get smsEmailNotFound;

  /// No description provided for @smsPhoneNotFound.
  ///
  /// In tk, this message translates to:
  /// **'Telefon belgisi tapylmady'**
  String get smsPhoneNotFound;

  /// No description provided for @smsEnterEmailCode.
  ///
  /// In tk, this message translates to:
  /// **'E-poçtaňyza gelen kody giriziň'**
  String get smsEnterEmailCode;

  /// No description provided for @smsEnterPhoneCode.
  ///
  /// In tk, this message translates to:
  /// **'Telefon belgiňize gelen kody giriziň'**
  String get smsEnterPhoneCode;

  /// No description provided for @resendCode.
  ///
  /// In tk, this message translates to:
  /// **'Kody täzeden ugratmak'**
  String get resendCode;

  /// No description provided for @detailCall.
  ///
  /// In tk, this message translates to:
  /// **'Jaň etmek'**
  String get detailCall;

  /// No description provided for @detailMap.
  ///
  /// In tk, this message translates to:
  /// **'Karta'**
  String get detailMap;

  /// No description provided for @detailShare.
  ///
  /// In tk, this message translates to:
  /// **'Paýlaşmak'**
  String get detailShare;

  /// No description provided for @ratingsTitle.
  ///
  /// In tk, this message translates to:
  /// **'Bahalar'**
  String get ratingsTitle;

  /// No description provided for @aboutTitle.
  ///
  /// In tk, this message translates to:
  /// **'Barada'**
  String get aboutTitle;

  /// No description provided for @consultationNote.
  ///
  /// In tk, this message translates to:
  /// **' Maslahat bermek hyzmaty hem elýeterlidir.'**
  String get consultationNote;

  /// No description provided for @priceLabel.
  ///
  /// In tk, this message translates to:
  /// **'Bahasy'**
  String get priceLabel;

  /// No description provided for @servicePriceLabel.
  ///
  /// In tk, this message translates to:
  /// **'Hyzmat bahasy:'**
  String get servicePriceLabel;

  /// No description provided for @discountLabel.
  ///
  /// In tk, this message translates to:
  /// **'Arzanladyş:'**
  String get discountLabel;

  /// No description provided for @consultationPriceLabel.
  ///
  /// In tk, this message translates to:
  /// **'Maslahat bermek:'**
  String get consultationPriceLabel;

  /// No description provided for @badgeTopProvider.
  ///
  /// In tk, this message translates to:
  /// **'Öňde baryjy'**
  String get badgeTopProvider;

  /// No description provided for @onboardTitle1.
  ///
  /// In tk, this message translates to:
  /// **'Siziň üçin iň gowy - Kömekçi hyzmat'**
  String get onboardTitle1;

  /// No description provided for @onboardSubtitle1.
  ///
  /// In tk, this message translates to:
  /// **'Eliňiziň aşagynda dürli görnüş bilen, zerurlyklaryňyza laýyk hyzmaty aňsatlyk bilen tapyň.'**
  String get onboardSubtitle1;

  /// No description provided for @onboardTitle2.
  ///
  /// In tk, this message translates to:
  /// **'Iş tejribesini anyklaň?'**
  String get onboardTitle2;

  /// No description provided for @onboardSubtitle2.
  ///
  /// In tk, this message translates to:
  /// **'Iş çözgütleri aňsatlyk bilen kabul etmek üçin hünärmenlerden tejribe iş başarnyklary bilen tanyş boluň.'**
  String get onboardSubtitle2;

  /// No description provided for @onboardTitle3.
  ///
  /// In tk, this message translates to:
  /// **'Iş ýerine ýetirildi!'**
  String get onboardTitle3;

  /// No description provided for @onboardSubtitle3.
  ///
  /// In tk, this message translates to:
  /// **'Ussat hünärmenler siziň işiňiziň netijeli gowy ýerine ýetirilmegine üpjün ederler.'**
  String get onboardSubtitle3;

  /// No description provided for @onboardGuest.
  ///
  /// In tk, this message translates to:
  /// **'Gezelenç'**
  String get onboardGuest;

  /// No description provided for @next.
  ///
  /// In tk, this message translates to:
  /// **'Indiki'**
  String get next;

  /// No description provided for @pinCreateSubtitle.
  ///
  /// In tk, this message translates to:
  /// **'Täze pin kod giriziň'**
  String get pinCreateSubtitle;

  /// No description provided for @pinConfirmSubtitle.
  ///
  /// In tk, this message translates to:
  /// **'Kody gaýtadan giriziň'**
  String get pinConfirmSubtitle;

  /// No description provided for @pinMismatch.
  ///
  /// In tk, this message translates to:
  /// **'Kodlar gabat gelmedi, gaýtadan synanyň'**
  String get pinMismatch;

  /// No description provided for @pinUnlockSubtitle.
  ///
  /// In tk, this message translates to:
  /// **'Dowam etmek üçin pin kody giriziň'**
  String get pinUnlockSubtitle;

  /// No description provided for @pinWrong.
  ///
  /// In tk, this message translates to:
  /// **'Nädogry pin kod'**
  String get pinWrong;

  /// No description provided for @forgotPinCode.
  ///
  /// In tk, this message translates to:
  /// **'Pin kody ýatdan çykardym'**
  String get forgotPinCode;

  /// No description provided for @notLoggedInTitle.
  ///
  /// In tk, this message translates to:
  /// **'Hasabyňyz ýok'**
  String get notLoggedInTitle;

  /// No description provided for @notLoggedInAddressesSubtitle.
  ///
  /// In tk, this message translates to:
  /// **'Salgylary görmek we goşmak üçin ulgama giriň'**
  String get notLoggedInAddressesSubtitle;

  /// No description provided for @loginButton.
  ///
  /// In tk, this message translates to:
  /// **'Girmek'**
  String get loginButton;

  /// No description provided for @navHome.
  ///
  /// In tk, this message translates to:
  /// **'Esasy'**
  String get navHome;

  /// No description provided for @navSearch.
  ///
  /// In tk, this message translates to:
  /// **'Gözleg'**
  String get navSearch;

  /// No description provided for @enterOrderDataTitle.
  ///
  /// In tk, this message translates to:
  /// **'Maglumatlaryňyzy giriziň'**
  String get enterOrderDataTitle;

  /// No description provided for @orderInfoBanner.
  ///
  /// In tk, this message translates to:
  /// **'Eger siz hyzmat sargyt edip, soň pikirlerňizi üýtgetseňiz ýa-da hyzmatdan ýüz öwürseňiz'**
  String get orderInfoBanner;

  /// No description provided for @fullNameLabel.
  ///
  /// In tk, this message translates to:
  /// **'Doly adyňyz'**
  String get fullNameLabel;

  /// No description provided for @addressLabel.
  ///
  /// In tk, this message translates to:
  /// **'Salgy'**
  String get addressLabel;

  /// No description provided for @addressPlaceholder.
  ///
  /// In tk, this message translates to:
  /// **'Salgyňyzy giriziň'**
  String get addressPlaceholder;

  /// No description provided for @noteLabel.
  ///
  /// In tk, this message translates to:
  /// **'Bellik'**
  String get noteLabel;

  /// No description provided for @noteOptionalHint.
  ///
  /// In tk, this message translates to:
  /// **'Bellik (hökmany däl)'**
  String get noteOptionalHint;

  /// No description provided for @paymentTypeLabel.
  ///
  /// In tk, this message translates to:
  /// **'Töleg şekili'**
  String get paymentTypeLabel;

  /// No description provided for @paymentTypeHint.
  ///
  /// In tk, this message translates to:
  /// **'Töleg görnüşi saýlaň'**
  String get paymentTypeHint;

  /// No description provided for @serviceTimeNotSelected.
  ///
  /// In tk, this message translates to:
  /// **'Hyzmat we wagt saýlanmady'**
  String get serviceTimeNotSelected;

  /// No description provided for @orderCreatedSuccess.
  ///
  /// In tk, this message translates to:
  /// **'Bron üstünlikli döredildi'**
  String get orderCreatedSuccess;

  /// No description provided for @submitOrderButton.
  ///
  /// In tk, this message translates to:
  /// **'Çagyryş'**
  String get submitOrderButton;

  /// No description provided for @incorrectPassword.
  ///
  /// In tk, this message translates to:
  /// **'Nädogry açar sözi'**
  String get incorrectPassword;

  /// No description provided for @fillAllFields.
  ///
  /// In tk, this message translates to:
  /// **'Hemme maglumatlary giriziň'**
  String get fillAllFields;
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
