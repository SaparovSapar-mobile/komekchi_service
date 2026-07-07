import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';
import 'package:komekchi_service/features/domain/usecases/search_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUsecase searchUsecase;

  SearchCubit({required this.searchUsecase}) : super(SearchInitial());

  Timer? _debounce;

  void searchDebounced(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () {
      search(query);
    });
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final result = await searchUsecase(SearchParams(query: query.trim()));

    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (paginated) => emit(SearchSuccess(paginated.items)),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
