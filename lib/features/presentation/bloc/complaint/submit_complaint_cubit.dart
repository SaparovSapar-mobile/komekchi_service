import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/features/domain/usecases/complaint_usecase.dart';

part 'submit_complaint_state.dart';

class SubmitComplaintCubit extends Cubit<SubmitComplaintState> {
  final SubmitComplaintUsecase submitComplaintUsecase;

  SubmitComplaintCubit({required this.submitComplaintUsecase})
    : super(SubmitComplaintInitial());

  Future<void> submit(String message) async {
    emit(SubmitComplaintLoading());

    final result = await submitComplaintUsecase(message);

    result.fold(
      (failure) => emit(SubmitComplaintError(failure.message)),
      (_) => emit(SubmitComplaintSuccess()),
    );
  }
}
