import 'package:komekchi_service/features/domain/entities/address_type.dart';

class AddressTypeItemModel extends AddressTypeItem {
  const AddressTypeItemModel({required super.uuid, required super.name});

  factory AddressTypeItemModel.fromJson(Map<String, dynamic> json) {
    return AddressTypeItemModel(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
