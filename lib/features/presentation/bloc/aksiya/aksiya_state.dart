part of 'aksiya_cubit.dart';

sealed class AksiyaState extends Equatable {
  const AksiyaState();

  @override
  List<Object> get props => [];
}

final class AksiyaInitial extends AksiyaState {}

final class AksiyaLoading extends AksiyaState {}

final class AksiyaSuccess extends AksiyaState {
  final List<AksiyaItem> items;

  const AksiyaSuccess({required this.items});

  @override
  List<Object> get props => [items];
}

final class AksiyaError extends AksiyaState {
  final String message;

  const AksiyaError({required this.message});

  @override
  List<Object> get props => [message];
}
