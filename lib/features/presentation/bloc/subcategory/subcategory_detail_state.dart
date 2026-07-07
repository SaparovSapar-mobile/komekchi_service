part of 'subcategory_detail_cubit.dart';

sealed class SubcategoryDetailState extends Equatable {
  const SubcategoryDetailState();

  @override
  List<Object> get props => [];
}

final class SubcategoryDetailInitial extends SubcategoryDetailState {}

final class SubcategoryDetailLoading extends SubcategoryDetailState {}

final class SubcategoryDetailSuccess extends SubcategoryDetailState {
  final SubcategoryItem item;

  const SubcategoryDetailSuccess({required this.item});

  @override
  List<Object> get props => [item];
}

final class SubcategoryDetailError extends SubcategoryDetailState {
  final String message;

  const SubcategoryDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
