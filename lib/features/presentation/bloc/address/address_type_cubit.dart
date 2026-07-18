import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/address_usecase.dart';

import '../../../domain/entities/address_type.dart';

part 'address_type_state.dart';

class AddressTypeCubit extends Cubit<AddressTypeState> {
  final GetAddressTypesUsecase getAddressTypesUsecase;

  AddressTypeCubit({required this.getAddressTypesUsecase})
    : super(AddressTypeInitial());

  Future<void> fetchAddressTypes() async {
    emit(AddressTypeLoading());
    final result = await getAddressTypesUsecase();
    result.fold(
      (failure) => emit(AddressTypeError(message: failure.message)),
      (items) => emit(AddressTypeSuccess(items: items)),
    );
  }
}
