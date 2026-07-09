import 'package:komekchi_service/features/domain/entities/rating.dart';

class RatingItemModel extends RatingItem {
  const RatingItemModel({
    required super.uuid,
    required super.categoryUuid,
    required super.subcategoryUuid,
    required super.clientUuid,
    required super.comment,
    required super.stars,
    required super.createdAt,
  });

  factory RatingItemModel.fromJson(Map<String, dynamic> json) {
    return RatingItemModel(
      uuid: json['uuid'] ?? '',
      categoryUuid: json['category_uuid'] ?? '',
      subcategoryUuid: json['subcategory_uuid'] ?? '',
      clientUuid: json['client_uuid'] ?? '',
      comment: json['comment'] ?? '',
      stars: json['stars'] ?? 0,
      createdAt: json['created_at'] ?? '',
    );
  }
}
