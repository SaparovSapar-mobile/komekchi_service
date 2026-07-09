part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final SearchResult result;
  SearchSuccess(this.result);
}

class SearchError extends SearchState {
  final String message;
  final Failure failure;
  SearchError(this.message, this.failure);
}
