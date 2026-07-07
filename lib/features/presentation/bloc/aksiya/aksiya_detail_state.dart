part of 'aksiya_detail_cubit.dart';

sealed class AksiyaDetailState extends Equatable {
  const AksiyaDetailState();

  @override
  List<Object> get props => [];
}

final class AksiyaDetailInitial extends AksiyaDetailState {}

final class AksiyaDetailLoading extends AksiyaDetailState {}

final class AksiyaDetailSuccess extends AksiyaDetailState {
  final AksiyaItem item;

  const AksiyaDetailSuccess({required this.item});

  @override
  List<Object> get props => [item];
}

final class AksiyaDetailError extends AksiyaDetailState {
  final String message;

  const AksiyaDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
