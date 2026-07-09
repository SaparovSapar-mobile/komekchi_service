part of 'get_category_cubit.dart';

sealed class GetCategoryState extends Equatable {
  const GetCategoryState();

  @override
  List<Object> get props => [];
}

final class GetCategoryInitial extends GetCategoryState {}

final class GetCategoryLoading extends GetCategoryState {}

final class GetCategorySucces extends GetCategoryState {
  final List<CategoryItem> dataCategory;

  GetCategorySucces({required this.dataCategory});
  @override
  List<Object> get props => [dataCategory];
}

final class GetCategoryError extends GetCategoryState {
  final String message;
  final Failure failure;

  GetCategoryError({required this.message, required this.failure});
  @override
  List<Object> get props => [message];
}
