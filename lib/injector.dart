import 'package:get_it/get_it.dart';
import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/repository/repository_impl.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import 'package:komekchi_service/features/domain/usecases/aksiya_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/banner_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/category_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/contact_us_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/search_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/subcategory_usecase.dart';
import 'package:komekchi_service/features/presentation/bloc/aksiya/aksiya_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/aksiya/aksiya_detail_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/banner/banner_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/category/get_category_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/contact_us/contact_us_cubit.dart';
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

  sl.registerLazySingleton<ContactUsUsecase>(
    () => ContactUsUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  sl.registerLazySingleton<SearchUsecase>(
    () => SearchUsecase(getAppsRepository: sl<GetAppRepository>()),
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

  sl.registerFactory(
    () => WeatherCubit(weatherApiService: sl<WeatherApiService>()),
  );

  sl.registerFactory(
    () => ContactUsCubit(contactUsUsecase: sl<ContactUsUsecase>()),
  );

  sl.registerFactory(() => SearchCubit(searchUsecase: sl<SearchUsecase>()));
}
