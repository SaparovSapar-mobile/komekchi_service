import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/aksiya_usecase.dart';

import '../../../domain/entities/aksiya.dart';

part 'aksiya_detail_state.dart';

class AksiyaDetailCubit extends Cubit<AksiyaDetailState> {
  final GetAksiyaByIdUsecase getAksiyaByIdUsecase;

  AksiyaDetailCubit({required this.getAksiyaByIdUsecase})
    : super(AksiyaDetailInitial());

  Future<void> fetchAksiyaById(String uuid) async {
    emit(AksiyaDetailLoading());
    final result = await getAksiyaByIdUsecase(uuid);
    result.fold(
      (failure) => emit(AksiyaDetailError(message: failure.message)),
      (item) => emit(AksiyaDetailSuccess(item: item)),
    );
  }
}
