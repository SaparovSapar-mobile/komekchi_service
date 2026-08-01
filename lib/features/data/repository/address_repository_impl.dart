import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/address_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/entities/address_type.dart';
import 'package:komekchi_service/features/domain/repositories/address_repository.dart';

class AddressRepositoryImpl
    with RepositoryErrorGuard
    implements AddressRepository {
  final AddressDataSource dataSource;

  AddressRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<AddressTypeItem>>> getAddressTypes() {
    return guard(() => dataSource.getAddressTypes());
  }

  @override
  Future<Either<Failure, List<AddressItem>>> getAddresses() {
    return guard(() => dataSource.getAddresses());
  }

  @override
  Future<Either<Failure, AddressItem>> getAddressById(String uuid) {
    return guard(() => dataSource.getAddressById(uuid));
  }

  @override
  Future<Either<Failure, AddressItem>> createAddress({
    required String address,
    required String addressTypeUuid,
  }) {
    return guard(() => dataSource.createAddress(
          address: address,
          addressTypeUuid: addressTypeUuid,
        ));
  }

  @override
  Future<Either<Failure, AddressItem>> updateAddress({
    required String uuid,
    required String address,
    required String addressTypeUuid,
  }) {
    return guard(() => dataSource.updateAddress(
          uuid: uuid,
          address: address,
          addressTypeUuid: addressTypeUuid,
        ));
  }

  @override
  Future<Either<Failure, void>> deleteAddress(String uuid) {
    return guardVoid(() => dataSource.deleteAddress(uuid));
  }
}
