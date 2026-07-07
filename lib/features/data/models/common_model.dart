import '../../domain/entities/common.dart';

class PaymentMethodModel extends PaymentMethod {
  const PaymentMethodModel({
    required super.consultation,
    required super.price,
    required super.forPersonPrice,
    required super.sale,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const PaymentMethodModel(
        consultation: false,
        price: 0,
        forPersonPrice: 0,
        sale: 0,
      );
    }
    return PaymentMethodModel(
      consultation: json['consultation'] ?? false,
      price: json['price'] ?? 0,
      forPersonPrice: json['for_person_price'] ?? 0,
      sale: json['sale'] ?? 0,
    );
  }
}

class WarningDescModel extends WarningDesc {
  const WarningDescModel({
    required super.descTm,
    required super.descRu,
    required super.descEn,
  });

  factory WarningDescModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const WarningDescModel(descTm: '', descRu: '', descEn: '');
    }
    return WarningDescModel(
      descTm: json['desc_tm'] ?? '',
      descRu: json['desc_ru'] ?? '',
      descEn: json['desc_en'] ?? '',
    );
  }
}

class PaginationInfoModel extends PaginationInfo {
  const PaginationInfoModel({
    required super.page,
    required super.limit,
    required super.total,
    required super.totalPages,
  });

  factory PaginationInfoModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const PaginationInfoModel(
        page: 1,
        limit: 0,
        total: 0,
        totalPages: 0,
      );
    }
    return PaginationInfoModel(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
    );
  }
}
