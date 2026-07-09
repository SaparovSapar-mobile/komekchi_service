import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/category_usecase.dart';

import '../../../../core/error/faiulre.dart';
import '../../../domain/entities/category.dart';

part 'get_category_state.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {
  final GetCategoriesUsecase getCategoriesUsecase;

  GetCategoryCubit({required this.getCategoriesUsecase})
    : super(GetCategoryInitial());

  Future<void> fetchCategory() async {
    emit(GetCategoryLoading());
    final result = await getCategoriesUsecase(const GetCategoriesParams());
    result.fold(
      (failure) =>
          emit(GetCategoryError(message: failure.message, failure: failure)),
      (page) => emit(GetCategorySucces(dataCategory: page.items)),
    );
  }
}
