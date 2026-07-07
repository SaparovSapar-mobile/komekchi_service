import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/subcategory_usecase.dart';

import '../../../domain/entities/subcategory.dart';

part 'subcategory_detail_state.dart';

class SubcategoryDetailCubit extends Cubit<SubcategoryDetailState> {
  final GetSubcategoryByIdUsecase getSubcategoryByIdUsecase;

  SubcategoryDetailCubit({required this.getSubcategoryByIdUsecase})
    : super(SubcategoryDetailInitial());

  Future<void> fetchSubcategoryById(String uuid) async {
    emit(SubcategoryDetailLoading());
    final result = await getSubcategoryByIdUsecase(uuid);
    result.fold(
      (failure) => emit(SubcategoryDetailError(message: failure.message)),
      (item) => emit(SubcategoryDetailSuccess(item: item)),
    );
  }
}
