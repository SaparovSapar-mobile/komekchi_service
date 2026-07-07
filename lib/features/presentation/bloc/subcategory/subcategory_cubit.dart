import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/subcategory_usecase.dart';

import '../../../domain/entities/subcategory.dart';

part 'subcategory_state.dart';

class SubcategoryCubit extends Cubit<SubcategoryState> {
  final GetSubcategoriesUsecase getSubcategoriesUsecase;

  SubcategoryCubit({required this.getSubcategoriesUsecase})
    : super(SubcategoryInitial());

  Future<void> fetchSubcategories({
    String? categoryUuid,
    bool? is24_7,
    bool? isFeatured,
  }) async {
    emit(SubcategoryLoading());
    final result = await getSubcategoriesUsecase(
      GetSubcategoriesParams(
        categoryUuid: categoryUuid,
        is24_7: is24_7,
        isFeatured: isFeatured,
      ),
    );
    result.fold(
      (failure) => emit(SubcategoryError(message: failure.message)),
      (page) => emit(SubcategorySuccess(items: page.items)),
    );
  }
}
