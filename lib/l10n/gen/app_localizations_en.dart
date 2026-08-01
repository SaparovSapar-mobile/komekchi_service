// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settingsTitle => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get myAddresses => 'My addresses';

  @override
  String get voiceNotifications => 'Sound notifications';

  @override
  String get pinCode => 'PIN code';

  @override
  String get languageTurkmen => 'Turkmen';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageEnglish => 'English';

  @override
  String get systemOption => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get aboutUs => 'About us';

  @override
  String get aboutCompany => 'About the company';

  @override
  String get contactUs => 'Contact us';

  @override
  String get writeLetter => 'Write a letter';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get logoutSection => 'Log out';

  @override
  String get logout => 'Log out';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get appUpdate => 'Update app';

  @override
  String get newVersion => 'New version';

  @override
  String get myPage => 'My page';

  @override
  String get user => 'User';

  @override
  String get homeServices => 'Services';

  @override
  String get home247Services => '24/7 services';

  @override
  String get homeTopProviders => 'Top providers';

  @override
  String get homePromotions => 'Promotions';

  @override
  String get homeWhyUs => 'Why us?';

  @override
  String get homeServiceNotFound => 'No services found';

  @override
  String get salgymTitle => 'My address';

  @override
  String get salgymEnterLocation => 'Enter your address';

  @override
  String get biz247Support => '24/7 support';

  @override
  String get bizWorkSchedule => 'Work schedule';

  @override
  String get bizWorkGuarantee => 'Work guarantee';

  @override
  String get bizCustomerService => 'Customer service';

  @override
  String get bizPaymentOptions => 'Payment options';

  @override
  String get bizTrusted => 'Trusted';

  @override
  String get bronlarTitle => 'My bookings';

  @override
  String get tabAll => 'All';

  @override
  String get tabPending => 'Pending';

  @override
  String get tabCancelled => 'Cancelled';

  @override
  String get tabCompleted => 'Completed';

  @override
  String get cancelBookingTitle => 'Cancel booking?';

  @override
  String cancelBookingBody(String code) {
    return 'Do you want to cancel booking N°$code?';
  }

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get retry => 'Try again';

  @override
  String orderQuantity(int count) {
    return 'Quantity: $count';
  }

  @override
  String get orderTotal => 'Total: ';

  @override
  String get complain => 'Complain';

  @override
  String get cancelBooking => 'Cancel';

  @override
  String get rateService => 'Rate';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get complainSheetTitle => 'Complain!';

  @override
  String get addressTypeHome => 'Home';

  @override
  String get addressTypeWork => 'Work';

  @override
  String get addressTypeOther => 'Other';

  @override
  String get addressSheetTitle => 'Address name';

  @override
  String get noAddresses => 'No addresses';

  @override
  String get deleteAddressTitle => 'Delete address?';

  @override
  String get addNewAddress => 'Add new address';

  @override
  String get editAddressTitle => 'Edit address';

  @override
  String get newAddressTitle => 'New address';

  @override
  String get addressHint => 'Yard, house';

  @override
  String get addressType => 'Address type';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get authLoginTitle => 'Sign in';

  @override
  String get authRegisterTitle => 'Sign up';

  @override
  String get tabPhone => 'Phone number';

  @override
  String get tabEmail => 'Email';

  @override
  String get phoneLabel => 'Your phone number';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get forgotPasswordLink => 'Forgot password';

  @override
  String get confirmButton => 'Confirm';

  @override
  String errorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get nameLabel => 'Full name';

  @override
  String get nameHint => 'Enter your name';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get agreeTerms => 'I agree to the terms';

  @override
  String get sendCode => 'Send code';

  @override
  String get confirmedTitle => 'Confirmed!';

  @override
  String get continueButton => 'Continue';

  @override
  String get repeatPasswordLabel => 'Repeat password';

  @override
  String get confirmShort => 'Confirm';

  @override
  String get phoneDigitsError => 'Must be 8 digits';

  @override
  String get smsEmailNotFound => 'Email not found';

  @override
  String get smsPhoneNotFound => 'Phone number not found';

  @override
  String get smsEnterEmailCode => 'Enter the code sent to your email';

  @override
  String get smsEnterPhoneCode => 'Enter the code sent to your phone';

  @override
  String get resendCode => 'Resend code';

  @override
  String get detailCall => 'Call';

  @override
  String get detailMap => 'Map';

  @override
  String get detailShare => 'Share';

  @override
  String get ratingsTitle => 'Reviews';

  @override
  String get aboutTitle => 'About';

  @override
  String get consultationNote => ' Consultation service is also available.';

  @override
  String get priceLabel => 'Price';

  @override
  String get servicePriceLabel => 'Service price:';

  @override
  String get discountLabel => 'Discount:';

  @override
  String get consultationPriceLabel => 'Consultation:';

  @override
  String get badgeTopProvider => 'Top provider';

  @override
  String get onboardTitle1 => 'The best for you — Kömekçi Hyzmat';

  @override
  String get onboardSubtitle1 =>
      'Find the right service for your needs among a wide variety, right at your fingertips.';

  @override
  String get onboardTitle2 => 'Check specialists\' experience';

  @override
  String get onboardSubtitle2 =>
      'Get familiar with specialists\' experience and skills to make work decisions easily.';

  @override
  String get onboardTitle3 => 'Job done!';

  @override
  String get onboardSubtitle3 =>
      'Skilled specialists will ensure your work is completed efficiently and well.';

  @override
  String get onboardGuest => 'Browse';

  @override
  String get next => 'Next';

  @override
  String get pinCreateSubtitle => 'Enter a new PIN code';

  @override
  String get pinConfirmSubtitle => 'Enter the code again';

  @override
  String get pinMismatch => 'Codes don\'t match, try again';

  @override
  String get pinUnlockSubtitle => 'Enter your PIN to continue';

  @override
  String get pinWrong => 'Incorrect PIN';

  @override
  String get forgotPinCode => 'Forgot PIN code';

  @override
  String get notLoggedInTitle => 'You don\'t have an account';

  @override
  String get notLoggedInAddressesSubtitle => 'Log in to view and add addresses';

  @override
  String get loginButton => 'Log in';

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Search';

  @override
  String get enterOrderDataTitle => 'Enter your details';

  @override
  String get orderInfoBanner =>
      'If you order a service and later change your mind or decide to cancel it';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get addressLabel => 'Address';

  @override
  String get addressPlaceholder => 'Enter your address';

  @override
  String get noteLabel => 'Note';

  @override
  String get noteOptionalHint => 'Note (optional)';

  @override
  String get paymentTypeLabel => 'Payment type';

  @override
  String get paymentTypeHint => 'Select payment type';

  @override
  String get serviceTimeNotSelected => 'Service and time not selected';

  @override
  String get orderCreatedSuccess => 'Booking created successfully';

  @override
  String get submitOrderButton => 'Call';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get fillAllFields => 'Fill in all fields';
}
