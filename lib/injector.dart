import 'package:get_it/get_it.dart';
import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/repository/repository_impl.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import 'package:komekchi_service/features/domain/usecases/category_usecase.dart';
import 'package:komekchi_service/features/presentation/bloc/cubit/get_category_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/data/datasource/get_app_dt.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<ApiService>(() => ApiService());

  sl.registerLazySingleton<GetAppDt>(() => GetAppDtImpl(api: sl<ApiService>()));

  sl.registerLazySingleton<GetAppRepository>(
    () => RepositoryImpl(getAppDt: sl(), api: sl<ApiService>()),
  );

  sl.registerLazySingleton<GetCategoryUsecase>(
    () => GetCategoryUsecase(getAppsRepository: sl<GetAppRepository>()),
  );

  sl.registerFactory(
    () => GetCategoryCubit(getCategoryUsecase: sl<GetCategoryUsecase>()),
  );
}
