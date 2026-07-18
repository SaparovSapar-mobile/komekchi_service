part of 'address_cubit.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressSuccess extends AddressState {
  final List<AddressItem> items;

  const AddressSuccess({required this.items});

  @override
  List<Object> get props => [items];
}

final class AddressError extends AddressState {
  final String message;

  const AddressError({required this.message});

  @override
  List<Object> get props => [message];
}
