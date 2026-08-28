// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get myAddresses => 'Мои адреса';

  @override
  String get voiceNotifications => 'Звуковые уведомления';

  @override
  String get pinCode => 'Пин-код';

  @override
  String get languageTurkmen => 'Туркменский';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get systemOption => 'Системный';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get aboutUs => 'О нас';

  @override
  String get aboutCompany => 'О компании';

  @override
  String get contactUs => 'Связаться с нами';

  @override
  String get writeLetter => 'Написать письмо';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get logoutSection => 'Выход из аккаунта';

  @override
  String get logout => 'Выйти';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get appUpdate => 'Обновить приложение';

  @override
  String get newVersion => 'Новая версия';

  @override
  String get myPage => 'Моя страница';

  @override
  String get user => 'Пользователь';

  @override
  String get homeServices => 'Услуги';

  @override
  String get home247Services => 'Услуги 24/7';

  @override
  String get homeTopProviders => 'Топ исполнители';

  @override
  String get homePromotions => 'Акции';

  @override
  String get homeWhyUs => 'Почему мы?';

  @override
  String get homeServiceNotFound => 'Услуга не найдена';

  @override
  String get salgymTitle => 'Мой адрес';

  @override
  String get salgymEnterLocation => 'Укажите ваш адрес';

  @override
  String get biz247Support => 'Поддержка 24/7';

  @override
  String get bizWorkSchedule => 'График работы';

  @override
  String get bizWorkGuarantee => 'Гарантия на работу';

  @override
  String get bizCustomerService => 'Служба поддержки';

  @override
  String get bizPaymentOptions => 'Способы оплаты';

  @override
  String get bizTrusted => 'Надёжность';

  @override
  String get bronlarTitle => 'Мои брони';

  @override
  String get tabAll => 'Все';

  @override
  String get tabPending => 'В ожидании';

  @override
  String get tabCancelled => 'Отменено';

  @override
  String get tabCompleted => 'Завершено';

  @override
  String get cancelBookingTitle => 'Отменить бронь?';

  @override
  String cancelBookingBody(String code) {
    return 'Вы хотите отменить бронь N°$code?';
  }

  @override
  String get no => 'Нет';

  @override
  String get yes => 'Да';

  @override
  String get retry => 'Попробовать снова';

  @override
  String orderQuantity(int count) {
    return 'Количество: $count';
  }

  @override
  String get orderTotal => 'Итого: ';

  @override
  String get complain => 'Пожаловаться';

  @override
  String get cancelBooking => 'Отменить';

  @override
  String get rateService => 'Оценить';

  @override
  String get statusPending => 'Ожидание';

  @override
  String get statusUnknown => 'Неизвестно';

  @override
  String get complainSheetTitle => 'Пожаловаться!';

  @override
  String get addressTypeHome => 'Дом';

  @override
  String get addressTypeWork => 'Работа';

  @override
  String get addressTypeOther => 'Другое';

  @override
  String get addressSheetTitle => 'Название адреса';

  @override
  String get noAddresses => 'Нет адресов';

  @override
  String get deleteAddressTitle => 'Удалить адрес?';

  @override
  String get addNewAddress => 'Добавить новый адрес';

  @override
  String get editAddressTitle => 'Изменить адрес';

  @override
  String get newAddressTitle => 'Новый адрес';

  @override
  String get addressHint => 'Двор, дом';

  @override
  String get addressType => 'Тип адреса';

  @override
  String get edit => 'Изменить';

  @override
  String get add => 'Добавить';

  @override
  String get authLoginTitle => 'Войти';

  @override
  String get authRegisterTitle => 'Регистрация';

  @override
  String get tabPhone => 'Номер телефона';

  @override
  String get tabEmail => 'Email';

  @override
  String get phoneLabel => 'Ваш номер телефона';

  @override
  String get emailHint => 'Введите email';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get forgotPasswordLink => 'Забыли пароль';

  @override
  String get confirmButton => 'Подтвердить';

  @override
  String errorPrefix(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get nameLabel => 'Имя Фамилия';

  @override
  String get nameHint => 'Введите имя';

  @override
  String get confirmPasswordLabel => 'Подтвердите пароль';

  @override
  String get agreeTerms => 'Я согласен с условиями';

  @override
  String get sendCode => 'Отправить код';

  @override
  String get confirmedTitle => 'Подтверждено!';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get repeatPasswordLabel => 'Повторите пароль';

  @override
  String get confirmShort => 'Подтвердить';

  @override
  String get phoneDigitsError => 'Должно быть 8 цифр';

  @override
  String get smsEmailNotFound => 'Email не найден';

  @override
  String get smsPhoneNotFound => 'Номер телефона не найден';

  @override
  String get smsEnterEmailCode => 'Введите код, отправленный на почту';

  @override
  String get smsEnterPhoneCode => 'Введите код, отправленный на телефон';

  @override
  String get resendCode => 'Отправить код повторно';

  @override
  String get detailCall => 'Позвонить';

  @override
  String get detailMap => 'Карта';

  @override
  String get detailShare => 'Поделиться';

  @override
  String get ratingsTitle => 'Отзывы';

  @override
  String get aboutTitle => 'О услуге';

  @override
  String get consultationNote => ' Также доступна услуга консультации.';

  @override
  String get priceLabel => 'Цена';

  @override
  String get servicePriceLabel => 'Цена услуги:';

  @override
  String get discountLabel => 'Скидка:';

  @override
  String get consultationPriceLabel => 'Консультация:';

  @override
  String get badgeTopProvider => 'Топ исполнитель';

  @override
  String get onboardTitle1 => 'Лучшее для вас — Kömekçi Hyzmat';

  @override
  String get onboardSubtitle1 =>
      'Найдите нужную услугу среди множества вариантов — легко и под рукой.';

  @override
  String get onboardTitle2 => 'Оцените опыт мастеров';

  @override
  String get onboardSubtitle2 =>
      'Ознакомьтесь с опытом и навыками специалистов, чтобы легко принимать решения по работе.';

  @override
  String get onboardTitle3 => 'Работа выполнена!';

  @override
  String get onboardSubtitle3 =>
      'Опытные мастера обеспечат качественное и эффективное выполнение вашей работы.';

  @override
  String get onboardGuest => 'Обзор';

  @override
  String get next => 'Далее';

  @override
  String get pinCreateSubtitle => 'Введите новый пин-код';

  @override
  String get pinConfirmSubtitle => 'Введите код ещё раз';

  @override
  String get pinMismatch => 'Коды не совпадают, попробуйте снова';

  @override
  String get pinUnlockSubtitle => 'Введите пин-код, чтобы продолжить';

  @override
  String get pinWrong => 'Неверный пин-код';

  @override
  String get forgotPinCode => 'Забыли пин-код';

  @override
  String get notLoggedInTitle => 'У вас нет аккаунта';

  @override
  String get notLoggedInAddressesSubtitle =>
      'Войдите в аккаунт, чтобы просматривать и добавлять адреса';

  @override
  String get loginButton => 'Войти';

  @override
  String get navHome => 'Главная';

  @override
  String get navSearch => 'Поиск';

  @override
  String get enterOrderDataTitle => 'Введите данные';

  @override
  String get orderInfoBanner =>
      'Если вы заказали услугу, а потом передумаете или откажетесь от неё';

  @override
  String get fullNameLabel => 'Полное имя';

  @override
  String get addressLabel => 'Адрес';

  @override
  String get addressPlaceholder => 'Введите адрес';

  @override
  String get noteLabel => 'Примечание';

  @override
  String get noteOptionalHint => 'Примечание (необязательно)';

  @override
  String get paymentTypeLabel => 'Способ оплаты';

  @override
  String get paymentTypeHint => 'Выберите способ оплаты';

  @override
  String get serviceTimeNotSelected => 'Услуга и время не выбраны';

  @override
  String get orderCreatedSuccess => 'Бронирование успешно создано';

  @override
  String get submitOrderButton => 'Заказать';

  @override
  String get incorrectPassword => 'Неверный пароль';

  @override
  String get fillAllFields => 'Заполните все поля';
}
