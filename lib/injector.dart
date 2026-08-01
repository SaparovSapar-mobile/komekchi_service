import 'package:get_it/get_it.dart';
import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/about_data_source.dart';
import 'package:komekchi_service/features/data/datasource/address_data_source.dart';
import 'package:komekchi_service/features/data/datasource/aksiya_data_source.dart';
import 'package:komekchi_service/features/data/datasource/banner_data_source.dart';
import 'package:komekchi_service/features/data/datasource/category_data_source.dart';
import 'package:komekchi_service/features/data/datasource/complaint_data_source.dart';
import 'package:komekchi_service/features/data/datasource/contact_us_data_source.dart';
import 'package:komekchi_service/features/data/datasource/notification_data_source.dart';
import 'package:komekchi_service/features/data/datasource/order_data_source.dart';
import 'package:komekchi_service/features/data/datasource/rating_data_source.dart';
import 'package:komekchi_service/features/data/datasource/search_data_source.dart';
import 'package:komekchi_service/features/data/datasource/subcategory_data_source.dart';
import 'package:komekchi_service/features/data/repository/about_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/address_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/aksiya_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/banner_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/category_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/complaint_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/contact_us_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/notification_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/order_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/rating_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/search_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/subcategory_repository_impl.dart';
import 'package:komekchi_service/features/data/repository/weather_repository_impl.dart';
import 'package:komekchi_service/features/domain/repositories/about_repository.dart';
import 'package:komekchi_service/features/domain/repositories/address_repository.dart';
import 'package:komekchi_service/features/domain/repositories/aksiya_repository.dart';
import 'package:komekchi_service/features/domain/repositories/banner_repository.dart';
import 'package:komekchi_service/features/domain/repositories/category_repository.dart';
import 'package:komekchi_service/features/domain/repositories/complaint_repository.dart';
import 'package:komekchi_service/features/domain/repositories/contact_us_repository.dart';
import 'package:komekchi_service/features/domain/repositories/notification_repository.dart';
import 'package:komekchi_service/features/domain/repositories/order_repository.dart';
import 'package:komekchi_service/features/domain/repositories/rating_repository.dart';
import 'package:komekchi_service/features/domain/repositories/search_repository.dart';
import 'package:komekchi_service/features/domain/repositories/subcategory_repository.dart';
import 'package:komekchi_service/features/domain/repositories/weather_repository.dart';
import 'package:komekchi_service/features/domain/usecases/about_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/address_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/aksiya_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/banner_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/category_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/complaint_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/contact_us_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/notification_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/order_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/rating_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/search_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/subcategory_usecase.dart';
import 'package:komekchi_service/features/domain/usecases/weather_usecase.dart';
import 'package:komekchi_service/features/presentation/bloc/about/about_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/address/address_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/address/address_type_cubit.dart';
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

import 'features/data/datasource/weather_api_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<WeatherApiService>(() => WeatherApiService());

  _initCategory(sl);
  _initSubcategory(sl);
  _initAksiya(sl);
  _initBanner(sl);
  _initAbout(sl);
  _initContactUs(sl);
  _initSearch(sl);
  _initOrder(sl);
  _initRating(sl);
  _initComplaint(sl);
  _initAddress(sl);
  _initNotification(sl);
  _initWeather(sl);
}

void _initCategory(GetIt sl) {
  sl.registerLazySingleton<CategoryDataSource>(
    () => CategoryDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(dataSource: sl<CategoryDataSource>()),
  );
  sl.registerLazySingleton<GetCategoriesUsecase>(
    () => GetCategoriesUsecase(repository: sl<CategoryRepository>()),
  );
  sl.registerLazySingleton<GetCategoryByIdUsecase>(
    () => GetCategoryByIdUsecase(repository: sl<CategoryRepository>()),
  );
  sl.registerFactory(
    () => GetCategoryCubit(getCategoriesUsecase: sl<GetCategoriesUsecase>()),
  );
}

void _initSubcategory(GetIt sl) {
  sl.registerLazySingleton<SubcategoryDataSource>(
    () => SubcategoryDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<SubcategoryRepository>(
    () => SubcategoryRepositoryImpl(dataSource: sl<SubcategoryDataSource>()),
  );
  sl.registerLazySingleton<GetSubcategoriesUsecase>(
    () => GetSubcategoriesUsecase(repository: sl<SubcategoryRepository>()),
  );
  sl.registerLazySingleton<GetSubcategoryByIdUsecase>(
    () => GetSubcategoryByIdUsecase(repository: sl<SubcategoryRepository>()),
  );
  sl.registerFactory(
    () => SubcategoryCubit(
      getSubcategoriesUsecase: sl<GetSubcategoriesUsecase>(),
    ),
  );
  sl.registerFactory(
    () => SubcategoryDetailCubit(
      getSubcategoryByIdUsecase: sl<GetSubcategoryByIdUsecase>(),
    ),
  );
}

void _initAksiya(GetIt sl) {
  sl.registerLazySingleton<AksiyaDataSource>(
    () => AksiyaDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<AksiyaRepository>(
    () => AksiyaRepositoryImpl(dataSource: sl<AksiyaDataSource>()),
  );
  sl.registerLazySingleton<GetAksiyalarUsecase>(
    () => GetAksiyalarUsecase(repository: sl<AksiyaRepository>()),
  );
  sl.registerLazySingleton<GetAksiyaByIdUsecase>(
    () => GetAksiyaByIdUsecase(repository: sl<AksiyaRepository>()),
  );
  sl.registerFactory(
    () => AksiyaCubit(getAksiyalarUsecase: sl<GetAksiyalarUsecase>()),
  );
  sl.registerFactory(
    () => AksiyaDetailCubit(getAksiyaByIdUsecase: sl<GetAksiyaByIdUsecase>()),
  );
}

void _initBanner(GetIt sl) {
  sl.registerLazySingleton<BannerDataSource>(
    () => BannerDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(dataSource: sl<BannerDataSource>()),
  );
  sl.registerLazySingleton<BannerUsecase>(
    () => BannerUsecase(repository: sl<BannerRepository>()),
  );
  sl.registerLazySingleton<GetBannerByIdUsecase>(
    () => GetBannerByIdUsecase(repository: sl<BannerRepository>()),
  );
  sl.registerFactory(() => BannerCubit(bannerUsecase: sl<BannerUsecase>()));
}

void _initAbout(GetIt sl) {
  sl.registerLazySingleton<AboutDataSource>(
    () => AboutDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<AboutRepository>(
    () => AboutRepositoryImpl(dataSource: sl<AboutDataSource>()),
  );
  sl.registerLazySingleton<AboutUsecase>(
    () => AboutUsecase(repository: sl<AboutRepository>()),
  );
  sl.registerFactory(() => AboutCubit(aboutUsecase: sl<AboutUsecase>()));
}

void _initContactUs(GetIt sl) {
  sl.registerLazySingleton<ContactUsDataSource>(
    () => ContactUsDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<ContactUsRepository>(
    () => ContactUsRepositoryImpl(dataSource: sl<ContactUsDataSource>()),
  );
  sl.registerLazySingleton<ContactUsUsecase>(
    () => ContactUsUsecase(repository: sl<ContactUsRepository>()),
  );
  sl.registerFactory(
    () => ContactUsCubit(contactUsUsecase: sl<ContactUsUsecase>()),
  );
}

void _initSearch(GetIt sl) {
  sl.registerLazySingleton<SearchDataSource>(
    () => SearchDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(dataSource: sl<SearchDataSource>()),
  );
  sl.registerLazySingleton<SearchUsecase>(
    () => SearchUsecase(repository: sl<SearchRepository>()),
  );
  sl.registerFactory(() => SearchCubit(searchUsecase: sl<SearchUsecase>()));
}

void _initOrder(GetIt sl) {
  sl.registerLazySingleton<OrderDataSource>(
    () => OrderDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(dataSource: sl<OrderDataSource>()),
  );
  sl.registerLazySingleton<GetOrdersUsecase>(
    () => GetOrdersUsecase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<GetOrderByIdUsecase>(
    () => GetOrderByIdUsecase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<CreateOrderUsecase>(
    () => CreateOrderUsecase(repository: sl<OrderRepository>()),
  );
  sl.registerLazySingleton<CancelOrderUsecase>(
    () => CancelOrderUsecase(repository: sl<OrderRepository>()),
  );
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
}

void _initRating(GetIt sl) {
  sl.registerLazySingleton<RatingDataSource>(
    () => RatingDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<RatingRepository>(
    () => RatingRepositoryImpl(dataSource: sl<RatingDataSource>()),
  );
  sl.registerLazySingleton<GetRatingsUsecase>(
    () => GetRatingsUsecase(repository: sl<RatingRepository>()),
  );
  sl.registerLazySingleton<SubmitRatingUsecase>(
    () => SubmitRatingUsecase(repository: sl<RatingRepository>()),
  );
  sl.registerFactory(
    () => RatingCubit(getRatingsUsecase: sl<GetRatingsUsecase>()),
  );
  sl.registerFactory(
    () => SubmitRatingCubit(submitRatingUsecase: sl<SubmitRatingUsecase>()),
  );
}

void _initComplaint(GetIt sl) {
  sl.registerLazySingleton<ComplaintDataSource>(
    () => ComplaintDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<ComplaintRepository>(
    () => ComplaintRepositoryImpl(dataSource: sl<ComplaintDataSource>()),
  );
  sl.registerLazySingleton<GetComplaintsUsecase>(
    () => GetComplaintsUsecase(repository: sl<ComplaintRepository>()),
  );
  sl.registerLazySingleton<SubmitComplaintUsecase>(
    () => SubmitComplaintUsecase(repository: sl<ComplaintRepository>()),
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

void _initAddress(GetIt sl) {
  sl.registerLazySingleton<AddressDataSource>(
    () => AddressDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(dataSource: sl<AddressDataSource>()),
  );
  sl.registerLazySingleton<GetAddressTypesUsecase>(
    () => GetAddressTypesUsecase(repository: sl<AddressRepository>()),
  );
  sl.registerLazySingleton<GetAddressesUsecase>(
    () => GetAddressesUsecase(repository: sl<AddressRepository>()),
  );
  sl.registerLazySingleton<GetAddressByIdUsecase>(
    () => GetAddressByIdUsecase(repository: sl<AddressRepository>()),
  );
  sl.registerLazySingleton<CreateAddressUsecase>(
    () => CreateAddressUsecase(repository: sl<AddressRepository>()),
  );
  sl.registerLazySingleton<UpdateAddressUsecase>(
    () => UpdateAddressUsecase(repository: sl<AddressRepository>()),
  );
  sl.registerLazySingleton<DeleteAddressUsecase>(
    () => DeleteAddressUsecase(repository: sl<AddressRepository>()),
  );
  sl.registerFactory(
    () => AddressTypeCubit(
      getAddressTypesUsecase: sl<GetAddressTypesUsecase>(),
    ),
  );
  sl.registerFactory(
    () => AddressCubit(getAddressesUsecase: sl<GetAddressesUsecase>()),
  );
}

void _initNotification(GetIt sl) {
  sl.registerLazySingleton<NotificationDataSource>(
    () => NotificationDataSourceImpl(api: sl<ApiService>()),
  );
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(dataSource: sl<NotificationDataSource>()),
  );
  sl.registerLazySingleton<UpdateNotificationPreferenceUsecase>(
    () => UpdateNotificationPreferenceUsecase(
      repository: sl<NotificationRepository>(),
    ),
  );
}

void _initWeather(GetIt sl) {
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherApiService: sl<WeatherApiService>()),
  );
  sl.registerLazySingleton<GetWeatherUsecase>(
    () => GetWeatherUsecase(repository: sl<WeatherRepository>()),
  );
  sl.registerFactory(
    () => WeatherCubit(getWeatherUsecase: sl<GetWeatherUsecase>()),
  );
}
