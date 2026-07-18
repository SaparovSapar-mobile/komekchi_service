part of 'address_type_cubit.dart';

sealed class AddressTypeState extends Equatable {
  const AddressTypeState();

  @override
  List<Object> get props => [];
}

final class AddressTypeInitial extends AddressTypeState {}

final class AddressTypeLoading extends AddressTypeState {}

final class AddressTypeSuccess extends AddressTypeState {
  final List<AddressTypeItem> items;

  const AddressTypeSuccess({required this.items});

  @override
  List<Object> get props => [items];
}

final class AddressTypeError extends AddressTypeState {
  final String message;

  const AddressTypeError({required this.message});

  @override
  List<Object> get props => [message];
}
