part of 'rating_cubit.dart';

sealed class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

final class RatingInitial extends RatingState {}

final class RatingLoading extends RatingState {}

final class RatingSuccess extends RatingState {
  final List<RatingItem> items;

  const RatingSuccess({required this.items});

  @override
  List<Object> get props => [items];
}

final class RatingError extends RatingState {
  final String message;
  final Failure failure;

  const RatingError({required this.message, required this.failure});

  @override
  List<Object> get props => [message];
}
