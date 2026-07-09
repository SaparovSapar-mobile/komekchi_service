import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/complaint_usecase.dart';

import '../../../../core/error/faiulre.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../domain/entities/complaint.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  final GetComplaintsUsecase getComplaintsUsecase;

  ComplaintCubit({required this.getComplaintsUsecase})
    : super(ComplaintInitial());

  Future<void> fetchComplaints() async {
    emit(ComplaintLoading());
    final result = await getComplaintsUsecase(const NoParams());
    result.fold(
      (failure) =>
          emit(ComplaintError(message: failure.message, failure: failure)),
      (items) => emit(ComplaintSuccess(items: items)),
    );
  }
}
