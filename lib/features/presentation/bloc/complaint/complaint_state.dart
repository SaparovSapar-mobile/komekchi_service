part of 'complaint_cubit.dart';

sealed class ComplaintState extends Equatable {
  const ComplaintState();

  @override
  List<Object> get props => [];
}

final class ComplaintInitial extends ComplaintState {}

final class ComplaintLoading extends ComplaintState {}

final class ComplaintSuccess extends ComplaintState {
  final List<ComplaintItem> items;

  const ComplaintSuccess({required this.items});

  @override
  List<Object> get props => [items];
}

final class ComplaintError extends ComplaintState {
  final String message;
  final Failure failure;

  const ComplaintError({required this.message, required this.failure});

  @override
  List<Object> get props => [message];
}
