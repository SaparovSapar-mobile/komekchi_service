import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';
import 'package:komekchi_service/features/presentation/bloc/cubit/get_category_cubit.dart';
import 'core/utils/router.dart';
import 'injector.dart';

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode mode, _) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (_) => sl<GetCategoryCubit>())],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: mode,
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
  }
}
