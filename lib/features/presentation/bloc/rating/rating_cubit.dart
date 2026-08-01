import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/rating_usecase.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/entities/rating.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  final GetRatingsUsecase getRatingsUsecase;

  RatingCubit({required this.getRatingsUsecase}) : super(RatingInitial());

  Future<void> fetchRatings({
    String? categoryUuid,
    String? subcategoryUuid,
  }) async {
    emit(RatingLoading());
    final result = await getRatingsUsecase(
      categoryUuid: categoryUuid,
      subcategoryUuid: subcategoryUuid,
    );
    result.fold(
      (failure) =>
          emit(RatingError(message: failure.message, failure: failure)),
      (items) => emit(RatingSuccess(items: items)),
    );
  }
}
