import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/aksiya_usecase.dart';

import '../../../domain/entities/aksiya.dart';

part 'aksiya_state.dart';

class AksiyaCubit extends Cubit<AksiyaState> {
  final GetAksiyalarUsecase getAksiyalarUsecase;

  AksiyaCubit({required this.getAksiyalarUsecase}) : super(AksiyaInitial());

  Future<void> fetchAksiyalar() async {
    emit(AksiyaLoading());
    final result = await getAksiyalarUsecase();
    result.fold(
      (failure) => emit(AksiyaError(message: failure.message)),
      (items) => emit(AksiyaSuccess(items: items)),
    );
  }
}
