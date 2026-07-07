import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/core/usecase/usecase.dart';
import 'package:komekchi_service/features/domain/entities/banners.dart';
import 'package:komekchi_service/features/domain/usecases/banner_usecase.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final BannerUsecase bannerUsecase;
  BannerCubit({required this.bannerUsecase}) : super(BannerInitial());

  Future<void> fetchBanners() async {
    emit(BannerLoading());

    final result = await bannerUsecase(NoParams());
    result.fold(
      (failure) => emit(BannerError(message: failure.message)),
      (banner) => emit(BannerSuccess(banner: banner)),
    );
  }
}
