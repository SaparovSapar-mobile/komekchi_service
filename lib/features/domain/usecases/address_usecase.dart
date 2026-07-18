import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/entities/address_type.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import '../../../core/error/faiulre.dart';

class GetAddressTypesUsecase {
  final GetAppRepository getAppsRepository;

  GetAddressTypesUsecase({required this.getAppsRepository});

  Future<Either<Failure, List<AddressTypeItem>>> call() {
    return getAppsRepository.getAddressTypes();
  }
}

class GetAddressesUsecase {
  final GetAppRepository getAppsRepository;

  GetAddressesUsecase({required this.getAppsRepository});

  Future<Either<Failure, List<AddressItem>>> call() {
    return getAppsRepository.getAddresses();
  }
}

class GetAddressByIdUsecase {
  final GetAppRepository getAppsRepository;

  GetAddressByIdUsecase({required this.getAppsRepository});

  Future<Either<Failure, AddressItem>> call(String uuid) {
    return getAppsRepository.getAddressById(uuid);
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
  final GetAppRepository getAppsRepository;

  CreateAddressUsecase({required this.getAppsRepository});

  Future<Either<Failure, AddressItem>> call(CreateAddressParams params) {
    return getAppsRepository.createAddress(
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
  final GetAppRepository getAppsRepository;

  UpdateAddressUsecase({required this.getAppsRepository});

  Future<Either<Failure, AddressItem>> call(UpdateAddressParams params) {
    return getAppsRepository.updateAddress(
      uuid: params.uuid,
      address: params.address,
      addressTypeUuid: params.addressTypeUuid,
    );
  }
}

class DeleteAddressUsecase {
  final GetAppRepository getAppsRepository;

  DeleteAddressUsecase({required this.getAppsRepository});

  Future<Either<Failure, void>> call(String uuid) {
    return getAppsRepository.deleteAddress(uuid);
  }
}
