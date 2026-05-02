import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/features/presentation/pages/auth/auth_screen.dart.dart';
import 'package:komekchi_service/features/presentation/pages/auth/forgot_pass.dart';
import 'package:komekchi_service/features/presentation/pages/home/all_category.dart';
import 'package:komekchi_service/features/presentation/pages/home/category_id.dart';
import 'package:komekchi_service/features/presentation/pages/home/detail_screen/detail_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/detail_screen/nagilelik.dart';
import 'package:komekchi_service/features/presentation/pages/home/detail_screen/sms.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/bell.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/about_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/hyzmat.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/ish_kepilligi.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/ish_tertibi.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/toleg.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/ynamdar.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/select_date.dart';
import 'package:komekchi_service/features/presentation/pages/main_screen.dart/main_screen.dart';

import '../../features/presentation/pages/auth/check_screen.dart';
import '../../features/presentation/pages/auth/smsscreen.dart';
import '../../features/presentation/pages/home/aksiyalar_screen.dart';
import '../../features/presentation/pages/home/widget/selected_date.dart';
import '../../features/presentation/pages/splash/onboarding_screen.dart';
import '../../features/presentation/pages/splash/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const WalkthroughScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const AuthScreen(showLogin: true),
    ),
    GoRoute(
      path: '/register',
      builder: (_, __) => const AuthScreen(showLogin: false),
    ),
    GoRoute(path: '/sms', builder: (_, __) => const SmsScreen()),
    GoRoute(path: '/check', builder: (_, __) => const CheckScreen()),
    GoRoute(path: '/main', pageBuilder: (context, state) =>  CupertinoPage(child:const MainScreen())),
    GoRoute(path: '/forgot', builder: (_, __) => const ForgotPass()),
    GoRoute(path: '/aksiya', builder: (_, __) => const AksiyalarScreen()),
    GoRoute(path: '/date', builder: (_, __) => const SelectDate()),
    GoRoute(path: '/24goldaw', builder: (_, __) => const AboutScreen()),
    GoRoute(path: '/kepilligi', builder: (_, __) => const IshKepilligi()),
    GoRoute(path: '/istertibi', builder: (_, __) => const IshTertibi()),
    GoRoute(path: '/toleg', builder: (_, __) => const Toleg()),
    GoRoute(path: '/ynamdar', builder: (_, __) => const Ynamdar()),
    GoRoute(path: '/hyzmatlar', builder: (_, __) => const Hyzmat()),
    GoRoute(path: '/nagilelik', builder: (_, __) => const NagilelikScreen()),
    GoRoute(path: '/sms', builder: (_, __) => const Sms()),
    GoRoute(path: '/bells', builder: (_, __) => const BildirislerScreen()),

    GoRoute(path: '/selectedDate', builder: (_, __) => const SelectedDate()),
    GoRoute(
      path: '/allCategory',
      builder: (_, __) => const AllCategoryScreen(),
    ),
    GoRoute(
      path: '/categoryId',
      builder: (context, state) {
        final title = state.extra as String;
        return CategoryId(title: title);
      },
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return DetailScreen(
          title: data["title"],
          image: data["image"],
          titleImage: data["titleImage"],
        );
      },
    ),
  ],
);
