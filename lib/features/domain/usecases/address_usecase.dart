import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/entities/address_type.dart';
import 'package:komekchi_service/features/domain/repositories/address_repository.dart';
import '../../../core/error/failure.dart';

class GetAddressTypesUsecase {
  final AddressRepository repository;

  GetAddressTypesUsecase({required this.repository});

  Future<Either<Failure, List<AddressTypeItem>>> call() {
    return repository.getAddressTypes();
  }
}

class GetAddressesUsecase {
  final AddressRepository repository;

  GetAddressesUsecase({required this.repository});

  Future<Either<Failure, List<AddressItem>>> call() {
    return repository.getAddresses();
  }
}

class GetAddressByIdUsecase {
  final AddressRepository repository;

  GetAddressByIdUsecase({required this.repository});

  Future<Either<Failure, AddressItem>> call(String uuid) {
    return repository.getAddressById(uuid);
  }
}

class CreateAddressParams {
  final String address;
  final String addressTypeUuid;

  const CreateAddressParams({
    required this.address,
    required this.addressTypeUuid,
  });
}

class CreateAddressUsecase {
  final AddressRepository repository;

  CreateAddressUsecase({required this.repository});

  Future<Either<Failure, AddressItem>> call(CreateAddressParams params) {
    return repository.createAddress(
      address: params.address,
      addressTypeUuid: params.addressTypeUuid,
    );
  }
}

class UpdateAddressParams {
  final String uuid;
  final String address;
  final String addressTypeUuid;

  const UpdateAddressParams({
    required this.uuid,
    required this.address,
    required this.addressTypeUuid,
  });
}

class UpdateAddressUsecase {
  final AddressRepository repository;

  UpdateAddressUsecase({required this.repository});

  Future<Either<Failure, AddressItem>> call(UpdateAddressParams params) {
    return repository.updateAddress(
      uuid: params.uuid,
      address: params.address,
      addressTypeUuid: params.addressTypeUuid,
    );
  }
}

class DeleteAddressUsecase {
  final AddressRepository repository;

  DeleteAddressUsecase({required this.repository});

  Future<Either<Failure, void>> call(String uuid) {
    return repository.deleteAddress(uuid);
  }
}
