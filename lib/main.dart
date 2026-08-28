import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:komekchi_service/core/utils/pin_storage.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';
import 'package:komekchi_service/features/presentation/bloc/banner/banner_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/category/get_category_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/weather/weather_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/utils/deep_link_service.dart';
import 'core/utils/router.dart';
import 'injector.dart';
import 'l10n/gen/app_localizations.dart';

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

// Flutter's built-in Material/Cupertino translations don't ship Turkmen —
// only our own AppLocalizations does. Without this, picking "tk" crashes
// every Material widget with "No MaterialLocalizations found". These two
// delegates claim tk support and quietly serve the English strings
// underneath (affects only built-in chrome like default button labels —
// our own AppLocalizations.of(context) strings stay in Turkmen).
class _TkMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _TkMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tk';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(_TkMaterialLocalizationsDelegate old) => false;
}

class _TkCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _TkCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tk';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(_TkCupertinoLocalizationsDelegate old) => false;
}

// null means "follow device locale" (AppLanguage.system). Persisted under
// the 'app_locale' key in SharedPreferences by the Settings screen.
ValueNotifier<Locale?> localeNotifier = ValueNotifier(null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await init();

  final prefs = await SharedPreferences.getInstance();
  final savedLocale = prefs.getString('app_locale');
  if (savedLocale != null) {
    localeNotifier.value = Locale(savedLocale);
  }

  // 'system' (or nothing saved) leaves themeNotifier at its default
  // ThemeMode.system — only an explicit light/dark choice overrides it.
  final savedTheme = prefs.getString('app_theme');
  if (savedTheme == 'light') {
    themeNotifier.value = ThemeMode.light;
  } else if (savedTheme == 'dark') {
    themeNotifier.value = ThemeMode.dark;
  }

  // Skip onboarding/login on cold start if the user already has a saved
  // session — ApiService clears 'auth_token' on logout, so its absence
  // reliably means "not logged in". A logged-in user with PIN lock
  // enabled must unlock with their PIN before reaching '/main'.
  final isLoggedIn = prefs.getString('auth_token') != null;
  final pinLockActive =
      (prefs.getBool(pinEnabledStorageKey) ?? false) &&
      prefs.getString(pinCodeStorageKey) != null;
  // Onboarding marks itself seen (onboarding_screen.dart) as soon as it's
  // shown once — after that, a logged-out user goes straight to '/login'
  // instead of sitting through onboarding again.
  final onboardingSeen = prefs.getBool('onboarding_seen') ?? false;

  final String initialLocation;
  if (!isLoggedIn) {
    initialLocation = onboardingSeen ? '/login' : '/onboarding';
  } else if (pinLockActive) {
    initialLocation = '/pinUnlock';
  } else {
    initialLocation = '/main';
  }

  appRouter = buildAppRouter(initialLocation: initialLocation);

  await DeepLinkService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode mode, _) {
        return ValueListenableBuilder(
          valueListenable: localeNotifier,
          builder: (context, Locale? locale, _) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<GetCategoryCubit>()),
                BlocProvider(create: (_) => sl<BannerCubit>()),
                BlocProvider(create: (_) => sl<WeatherCubit>()..fetchWeather()),
              ],
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                themeMode: mode,
                locale: locale,
                localizationsDelegates: [
                  const _TkMaterialLocalizationsDelegate(),
                  const _TkCupertinoLocalizationsDelegate(),
                  ...AppLocalizations.localizationsDelegates,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                theme: AppTheme.lightTheme.copyWith(
                  pageTransitionsTheme: const PageTransitionsTheme(
                    builders: {
                      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                      TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    },
                  ),
                ),
                darkTheme: AppTheme.darkTheme.copyWith(
                  pageTransitionsTheme: const PageTransitionsTheme(
                    builders: {
                      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                      TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    },
                  ),
                ),
                routerConfig: appRouter,
              ),
            );
          },
        );
      },
    );
  }
}
