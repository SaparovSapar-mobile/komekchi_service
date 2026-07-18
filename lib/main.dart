import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

// null means "follow device locale" (AppLanguage.system). Persisted under
// the 'app_locale' key in SharedPreferences by the Settings screen.
ValueNotifier<Locale?> localeNotifier = ValueNotifier(null);

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await DeepLinkService.init();

  final prefs = await SharedPreferences.getInstance();
  final savedLocale = prefs.getString('app_locale');
  if (savedLocale != null) {
    localeNotifier.value = Locale(savedLocale);
  }

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
                localizationsDelegates: AppLocalizations.localizationsDelegates,
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
