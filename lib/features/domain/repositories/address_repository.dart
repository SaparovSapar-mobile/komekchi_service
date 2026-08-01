import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/entities/address_type.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressTypeItem>>> getAddressTypes();

  Future<Either<Failure, List<AddressItem>>> getAddresses();
  Future<Either<Failure, AddressItem>> getAddressById(String uuid);
  Future<Either<Failure, AddressItem>> createAddress({
    required String address,
    required String addressTypeUuid,
  });
  Future<Either<Failure, AddressItem>> updateAddress({
    required String uuid,
    required String address,
    required String addressTypeUuid,
  });
  Future<Either<Failure, void>> deleteAddress(String uuid);
}
