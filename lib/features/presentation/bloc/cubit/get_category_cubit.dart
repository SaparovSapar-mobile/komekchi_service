import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/core/usecase/usecase.dart';
import 'package:komekchi_service/features/domain/usecases/category_usecase.dart';

import '../../../domain/entities/category.dart';

part 'get_category_state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  final GetCategoryUsecase getCategoryUsecase;

  GetCategoryCubit({required this.getCategoryUsecase}) : super(GetCategoryInitial());

  Future<void> fetchCategory() async {
    emit(GetCategoryLoading()); 
    final result = await getCategoryUsecase(NoParams());
    result.fold(
      (failure) => emit(GetCategoryError(message: failure.message)),
      (category) => emit(GetCategorySucces(dataCategory: category)),
    );
  }
}
