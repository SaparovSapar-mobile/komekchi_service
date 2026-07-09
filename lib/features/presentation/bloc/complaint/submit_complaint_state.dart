part of 'submit_complaint_cubit.dart';

abstract class SubmitComplaintState {}

class SubmitComplaintInitial extends SubmitComplaintState {}

class SubmitComplaintLoading extends SubmitComplaintState {}

class SubmitComplaintSuccess extends SubmitComplaintState {}

class SubmitComplaintError extends SubmitComplaintState {
  final String message;
  SubmitComplaintError(this.message);
}
