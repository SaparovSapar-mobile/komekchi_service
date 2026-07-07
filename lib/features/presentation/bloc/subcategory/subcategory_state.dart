part of 'subcategory_cubit.dart';

sealed class SubcategoryState extends Equatable {
  const SubcategoryState();

  @override
  List<Object> get props => [];
}

final class SubcategoryInitial extends SubcategoryState {}

final class SubcategoryLoading extends SubcategoryState {}

final class SubcategorySuccess extends SubcategoryState {
  final List<SubcategoryItem> items;

  const SubcategorySuccess({required this.items});

  @override
  List<Object> get props => [items];
}

final class SubcategoryError extends SubcategoryState {
  final String message;

  const SubcategoryError({required this.message});

  @override
  List<Object> get props => [message];
}
