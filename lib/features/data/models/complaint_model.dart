import 'package:komekchi_service/features/domain/entities/complaint.dart';

class ComplaintItemModel extends ComplaintItem {
  const ComplaintItemModel({
    required super.uuid,
    required super.clientUuid,
    required super.message,
    required super.createdAt,
  });

  factory ComplaintItemModel.fromJson(Map<String, dynamic> json) {
    return ComplaintItemModel(
      uuid: json['uuid'] ?? '',
      clientUuid: json['client_uuid'] ?? '',
      message: json['message'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
