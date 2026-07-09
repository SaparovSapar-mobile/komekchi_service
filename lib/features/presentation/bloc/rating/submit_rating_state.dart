part of 'submit_rating_cubit.dart';

abstract class SubmitRatingState {}

class SubmitRatingInitial extends SubmitRatingState {}

class SubmitRatingLoading extends SubmitRatingState {}

class SubmitRatingSuccess extends SubmitRatingState {}

class SubmitRatingError extends SubmitRatingState {
  final String message;
  SubmitRatingError(this.message);
}
