import 'package:komekchi_service/features/domain/entities/address.dart';

class AddressItemModel extends AddressItem {
  const AddressItemModel({
    required super.uuid,
    required super.address,
    required super.addressTypeUuid,
    required super.addressTypeName,
    required super.clientUuid,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AddressItemModel.fromJson(Map<String, dynamic> json) {
    return AddressItemModel(
      uuid: json['uuid'] ?? '',
      address: json['address'] ?? '',
      addressTypeUuid: json['address_type_uuid'] ?? '',
      addressTypeName: json['address_type_name'] ?? '',
      clientUuid: json['client_uuid'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
