import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';
import 'package:komekchi_service/features/data/models/address_model.dart';
import 'package:komekchi_service/features/data/models/address_type_model.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/entities/address_type.dart';

abstract class AddressDataSource {
  Future<List<AddressTypeItem>> getAddressTypes();

  Future<List<AddressItem>> getAddresses();
  Future<AddressItem> getAddressById(String uuid);
  Future<AddressItem> createAddress({
    required String address,
    required String addressTypeUuid,
  });
  Future<AddressItem> updateAddress({
    required String uuid,
    required String address,
    required String addressTypeUuid,
  });
  Future<void> deleteAddress(String uuid);
}

class AddressDataSourceImpl extends BaseRemoteDataSource
    implements AddressDataSource {
  AddressDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<List<AddressTypeItem>> getAddressTypes() {
    return handle(
      () => api.dio.get('/address-types'),
      (data) => ((data['data'] as List?) ?? [])
          .map((e) => AddressTypeItemModel.fromJson(e))
          .toList(),
      errorMessage: 'Failed to load address types',
    );
  }

  @override
  Future<List<AddressItem>> getAddresses() {
    return handle(
      () => api.dio.get('/addresses'),
      (data) => ((data['data'] as List?) ?? [])
          .map((e) => AddressItemModel.fromJson(e))
          .toList(),
      errorMessage: 'Failed to load addresses',
    );
  }

  @override
  Future<AddressItem> getAddressById(String uuid) {
    return handle(
      () => api.dio.get('/addresses/$uuid'),
      (data) => AddressItemModel.fromJson(data['data']),
      errorMessage: 'Failed to load address',
    );
  }

  @override
  Future<AddressItem> createAddress({
    required String address,
    required String addressTypeUuid,
  }) {
    return handle(
      () => api.dio.post(
        '/addresses',
        data: {'address': address, 'address_type_uuid': addressTypeUuid},
      ),
      (data) => AddressItemModel.fromJson(data['data']),
      errorMessage: 'Failed to create address',
      successCodes: const {200, 201},
    );
  }

  @override
  Future<AddressItem> updateAddress({
    required String uuid,
    required String address,
    required String addressTypeUuid,
  }) {
    return handle(
      () => api.dio.put(
        '/addresses/$uuid',
        data: {'address': address, 'address_type_uuid': addressTypeUuid},
      ),
      (data) => AddressItemModel.fromJson(data['data']),
      errorMessage: 'Failed to update address',
    );
  }

  @override
  Future<void> deleteAddress(String uuid) {
    return handleVoid(
      () => api.dio.delete('/addresses/$uuid'),
      errorMessage: 'Failed to delete address',
      successCodes: const {200, 204},
    );
  }
}
