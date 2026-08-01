import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/features/domain/entities/search_result.dart';
import 'package:komekchi_service/features/domain/usecases/search_usecase.dart';

import '../../../../core/error/failure.dart';

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
      (failure) => emit(SearchError(failure.message, failure)),
      (searchResult) => emit(SearchSuccess(searchResult)),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
