part of 'create_order_cubit.dart';

sealed class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

final class CreateOrderInitial extends CreateOrderState {}

final class CreateOrderLoading extends CreateOrderState {}

final class CreateOrderSuccess extends CreateOrderState {
  final OrderItem item;

  const CreateOrderSuccess({required this.item});

  @override
  List<Object> get props => [item];
}

final class CreateOrderError extends CreateOrderState {
  final String message;

  const CreateOrderError({required this.message});

  @override
  List<Object> get props => [message];
}
