part of 'order_detail_cubit.dart';

sealed class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object> get props => [];
}

final class OrderDetailInitial extends OrderDetailState {}

final class OrderDetailLoading extends OrderDetailState {}

final class OrderDetailSuccess extends OrderDetailState {
  final OrderItem item;

  const OrderDetailSuccess({required this.item});

  @override
  List<Object> get props => [item];
}

final class OrderDetailError extends OrderDetailState {
  final String message;

  const OrderDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
