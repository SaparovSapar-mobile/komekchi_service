import 'package:get_it/get_it.dart';
import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/repository/repository_impl.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import 'package:komekchi_service/features/domain/usecases/about_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/aksiya_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/banner_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/category_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/complaint_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/contact_us_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/order_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/rating_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/search_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/subcategory_usecase.dart';
import 'package:komekchi_service/features/presentation/bloc/about/about_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/aksiya/aksiya_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/aksiya/aksiya_detail_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/banner/banner_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/category/get_category_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/complaint/complaint_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/complaint/submit_complaint_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/contact_us/contact_us_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/order/create_order_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/order/order_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/order/order_detail_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/rating/rating_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/rating/submit_rating_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/search/search_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/subcategory/subcategory_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/subcategory/subcategory_detail_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/weather/weather_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/data/datasource/get_app_dt.dart';
import 'features/data/datasource/weather_api_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<WeatherApiService>(() => WeatherApiService());

  sl.registerLazySingleton<GetAppDt>(() => GetAppDtImpl(api: sl<ApiService>()));

  sl.registerLazySingleton<GetAppRepository>(
    () => RepositoryImpl(getAppDt: sl()),
  );

  // Usecases
  sl.registerLazySingleton<GetCategoriesUsecase>(
    () => GetCategoriesUsecase(getAppsRepository: sl<GetAppRepository>()),
  );
  sl.registerLazySingleton<GetCategoryByIdUsecase>(
    () => GetCategoryByIdUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  sl.registerLazySingleton<GetSubcategoriesUsecase>(
    () => GetSubcategoriesUsecase(getAppsRepository: sl<GetAppRepository>()),
  );
  sl.registerLazySingleton<GetSubcategoryByIdUsecase>(
    () => GetSubcategoryByIdUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  sl.registerLazySingleton<GetAksiyalarUsecase>(
    () => GetAksiyalarUsecase(getAppsRepository: sl<GetAppRepository>()),
  );
  sl.registerLazySingleton<GetAksiyaByIdUsecase>(
    () => GetAksiyaByIdUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  sl.registerLazySingleton<BannerUsecase>(
    () => BannerUsecase(getAppsRepository: sl<GetAppRepository>()),
  );
  sl.registerLazySingleton<GetBannerByIdUsecase>(
    () => GetBannerByIdUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  sl.registerLazySingleton<AboutUsecase>(
    () => AboutUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  sl.registerLazySingleton<ContactUsUsecase>(
    () => ContactUsUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  sl.registerLazySingleton<SearchUsecase>(
    () => SearchUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  sl.registerLazySingleton<GetOrdersUsecase>(
    () => GetOrdersUsecase(getAppsRepository: sl<GetAppRepository>()),
  );
  sl.registerLazySingleton<GetOrderByIdUsecase>(
    () => GetOrderByIdUsecase(getAppsRepository: sl<GetAppRepository>()),
  );
  sl.registerLazySingleton<CreateOrderUsecase>(
    () => CreateOrderUsecase(getAppsRepository: sl<GetAppRepository>()),
  );
  sl.registerLazySingleton<CancelOrderUsecase>(
    () => CancelOrderUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  sl.registerLazySingleton<GetRatingsUsecase>(
    () => GetRatingsUsecase(getAppsRepository: sl<GetAppRepository>()),
  );
  sl.registerLazySingleton<SubmitRatingUsecase>(
    () => SubmitRatingUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  sl.registerLazySingleton<GetComplaintsUsecase>(
    () => GetComplaintsUsecase(getAppsRepository: sl<GetAppRepository>()),
  );
  sl.registerLazySingleton<SubmitComplaintUsecase>(
    () => SubmitComplaintUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  // Cubits
  sl.registerFactory(
    () => GetCategoryCubit(getCategoriesUsecase: sl<GetCategoriesUsecase>()),
  );

  sl.registerFactory(
    () => SubcategoryCubit(
      getSubcategoriesUsecase: sl<GetSubcategoriesUsecase>(),
    ),
  );

  sl.registerFactory(
    () => AksiyaCubit(getAksiyalarUsecase: sl<GetAksiyalarUsecase>()),
  );

  sl.registerFactory(
    () => SubcategoryDetailCubit(
      getSubcategoryByIdUsecase: sl<GetSubcategoryByIdUsecase>(),
    ),
  );

  sl.registerFactory(
    () => AksiyaDetailCubit(getAksiyaByIdUsecase: sl<GetAksiyaByIdUsecase>()),
  );

  sl.registerFactory(() => BannerCubit(bannerUsecase: sl<BannerUsecase>()));

  sl.registerFactory(() => AboutCubit(aboutUsecase: sl<AboutUsecase>()));

  sl.registerFactory(
    () => WeatherCubit(weatherApiService: sl<WeatherApiService>()),
  );

  sl.registerFactory(
    () => ContactUsCubit(contactUsUsecase: sl<ContactUsUsecase>()),
  );

  sl.registerFactory(() => SearchCubit(searchUsecase: sl<SearchUsecase>()));

  sl.registerFactory(
    () => OrderCubit(getOrdersUsecase: sl<GetOrdersUsecase>()),
  );

  sl.registerFactory(
    () => OrderDetailCubit(
      getOrderByIdUsecase: sl<GetOrderByIdUsecase>(),
      cancelOrderUsecase: sl<CancelOrderUsecase>(),
    ),
  );

  sl.registerFactory(
    () => CreateOrderCubit(createOrderUsecase: sl<CreateOrderUsecase>()),
  );

  sl.registerFactory(
    () => RatingCubit(getRatingsUsecase: sl<GetRatingsUsecase>()),
  );

  sl.registerFactory(
    () => SubmitRatingCubit(submitRatingUsecase: sl<SubmitRatingUsecase>()),
  );

  sl.registerFactory(
    () => ComplaintCubit(getComplaintsUsecase: sl<GetComplaintsUsecase>()),
  );

  sl.registerFactory(
    () => SubmitComplaintCubit(
      submitComplaintUsecase: sl<SubmitComplaintUsecase>(),
    ),
  );
}
