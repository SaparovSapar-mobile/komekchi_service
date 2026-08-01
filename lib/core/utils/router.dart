import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/features/presentation/bloc/about/about_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/aksiya/aksiya_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/aksiya/aksiya_detail_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/order/create_order_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/search/search_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/subcategory/subcategory_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/subcategory/subcategory_detail_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/auth/auth_screen.dart.dart';
import 'package:komekchi_service/features/presentation/pages/auth/forgot_pass.dart';
import 'package:komekchi_service/features/presentation/pages/home/aksiya/aksiya_detail_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/category/all_category.dart';
import 'package:komekchi_service/features/presentation/pages/home/category/category_id.dart';
import 'package:komekchi_service/features/presentation/pages/home/detail_screen/detail_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/detail_screen/complaint/complaint.dart';
import 'package:komekchi_service/features/presentation/pages/home/detail_screen/sms.dart';
import 'package:komekchi_service/features/presentation/pages/home/search/search_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/cards/card_model.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/cards/kart_goshmak_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/cards/kart_pozmak_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/cards/kartlarym_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/address/salgylarym_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/contact_us/contact_us_page.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/contact_us/hat_yazmak_page.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/pin/pin_code_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/privacy/privacy_policy_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/bell.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/about_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/hyzmat.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/ish_kepilligi.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/ish_tertibi.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/toleg.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/name_uchin_biz/ynamdar.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/select/select_date.dart';
import 'package:komekchi_service/features/presentation/pages/main_screen.dart/main_screen.dart';
import 'package:komekchi_service/injector.dart';

import '../../features/presentation/pages/auth/check_screen.dart';
import '../../features/presentation/pages/auth/sms_screen.dart';
import '../../features/presentation/pages/home/aksiya/aksiyalar_screen.dart';
import '../../features/presentation/pages/home/widget/select/selected_date.dart';
// import '../../features/presentation/pages/splash/lock_screen.dart'; // TODO: gaýtadan işe girizmeli bolanda aç
import '../../features/presentation/pages/splash/onboarding_screen.dart';
import '../../features/presentation/pages/splash/pin_unlock_screen.dart';

late final GoRouter appRouter;

/// Built once in main() after checking whether a stored auth token exists,
/// so an already-registered user lands on '/main' instead of the
/// onboarding/login flow on every cold start.
GoRouter buildAppRouter({required String initialLocation}) {
  return GoRouter(
  initialLocation: initialLocation,
  routes: [
    // Telefon gulpy arkaly girişi wagtlaýyn öçürildi — heniz gerek däl.
    // GoRoute(path: '/lock', builder: (_, __) => const LockScreen()),
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
    GoRoute(path: '/smsscreen', builder: (_, __) => const SmsScreen()),
    GoRoute(path: '/check', builder: (_, __) => const CheckScreen()),
    GoRoute(
      path: '/main',
      pageBuilder: (context, state) => CupertinoPage(child: const MainScreen()),
    ),
    GoRoute(path: '/forgot', builder: (_, __) => const ForgotPass()),
    GoRoute(
      path: '/aksiya',
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AksiyaCubit>(),
        child: const AksiyalarScreen(),
      ),
    ),
    GoRoute(
      path: '/aksiyaDetail',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final uuid = data['uuid'] as String;
        return BlocProvider(
          create: (_) => sl<AksiyaDetailCubit>()..fetchAksiyaById(uuid),
          child: const AksiyaDetailScreen(),
        );
      },
    ),
    GoRoute(
      path: '/date',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>?;
        return SelectDate(
          subcategoryUuid: data?['subcategoryUuid'] as String?,
          quantity: data?['quantity'] as int? ?? 1,
        );
      },
    ),
    GoRoute(
      path: '/24goldaw',
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AboutCubit>(),
        child: const AboutScreen(),
      ),
    ),
    GoRoute(path: '/kepilligi', builder: (_, __) => const IshKepilligi()),
    GoRoute(path: '/istertibi', builder: (_, __) => const IshTertibi()),
    GoRoute(path: '/toleg', builder: (_, __) => const Toleg()),
    GoRoute(path: '/ynamdar', builder: (_, __) => const Ynamdar()),
    GoRoute(path: '/hyzmatlar', builder: (_, __) => const Hyzmat()),
    GoRoute(path: '/nagilelik', builder: (_, __) => const NagilelikScreen()),
    GoRoute(path: '/sms', builder: (_, __) => const Sms()),
    GoRoute(
      path: '/search',
      builder: (_, __) => BlocProvider(
        create: (_) => sl<SearchCubit>(),
        child: const SearchScreen(),
      ),
    ),
    GoRoute(path: '/bells', builder: (_, __) => const BildirislerScreen()),
    GoRoute(path: '/contactUs', builder: (_, __) => const ContactUsPage()),
    GoRoute(path: '/hatYazmak', builder: (_, __) => const HatYazmakPage()),
    GoRoute(path: '/kartlarym', builder: (_, __) => const KartlarymScreen()),
    GoRoute(
      path: '/salgylarym',
      builder: (_, __) => const SalgylarymScreen(),
    ),
    // GoRoute(
    //   path: '/kartGoshmak',
    //   builder: (_, __) => const KartGoshmakScreen(),
    // ),
    GoRoute(
      path: '/kartPozmak',
      builder: (context, state) {
        final card = state.extra as SavedCard;
        return KartPozmakScreen(card: card);
      },
    ),
    GoRoute(path: '/pinCode', builder: (_, __) => const PinCodeScreen()),
    GoRoute(
      path: '/privacyPolicy',
      builder: (_, __) => const PrivacyPolicyScreen(),
    ),
    GoRoute(path: '/pinUnlock', builder: (_, __) => const PinUnlockScreen()),

    GoRoute(
      path: '/selectedDate',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>?;
        return BlocProvider(
          create: (_) => sl<CreateOrderCubit>(),
          child: SelectedDate(
            subcategoryUuid: data?['subcategoryUuid'] as String?,
            quantity: data?['quantity'] as int? ?? 1,
            orderDate: data?['orderDate'] as String?,
            orderTime: data?['orderTime'] as String?,
          ),
        );
      },
    ),
    GoRoute(
      path: '/allCategory',
      builder: (_, __) => const AllCategoryScreen(),
    ),
    GoRoute(
      path: '/categoryId',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return BlocProvider(
          create: (_) => sl<SubcategoryCubit>(),
          child: CategoryId(
            categoryUuid: data['uuid'] as String,
            title: data['title'] as String,
            categoryIcon: data['icon'] as String? ?? '',
          ),
        );
      },
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final uuid = data['uuid'] as String;
        return BlocProvider(
          create: (_) =>
              sl<SubcategoryDetailCubit>()..fetchSubcategoryById(uuid),
          child: DetailScreen(uuid: uuid),
        );
      },
    ),
  ],
  );
}
