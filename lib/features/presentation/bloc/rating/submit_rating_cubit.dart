import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/features/domain/usecases/rating_usecase.dart';

part 'submit_rating_state.dart';

class SubmitRatingCubit extends Cubit<SubmitRatingState> {
  final SubmitRatingUsecase submitRatingUsecase;

  SubmitRatingCubit({required this.submitRatingUsecase})
    : super(SubmitRatingInitial());

  Future<void> submit({
    String? categoryUuid,
    String? subcategoryUuid,
    required int stars,
    String? comment,
  }) async {
    emit(SubmitRatingLoading());

    final result = await submitRatingUsecase(
      SubmitRatingParams(
        categoryUuid: categoryUuid,
        subcategoryUuid: subcategoryUuid,
        stars: stars,
        comment: comment,
      ),
    );

    result.fold(
      (failure) => emit(SubmitRatingError(failure.message)),
      (_) => emit(SubmitRatingSuccess()),
    );
  }
}
