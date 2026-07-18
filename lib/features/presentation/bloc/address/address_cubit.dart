import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/address_usecase.dart';

import '../../../domain/entities/address.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final GetAddressesUsecase getAddressesUsecase;

  AddressCubit({required this.getAddressesUsecase}) : super(AddressInitial());

  Future<void> fetchAddresses() async {
    emit(AddressLoading());
    final result = await getAddressesUsecase();
    result.fold(
      (failure) => emit(AddressError(message: failure.message)),
      (items) => emit(AddressSuccess(items: items)),
    );
  }
}
