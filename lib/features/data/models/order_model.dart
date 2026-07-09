import 'package:komekchi_service/features/domain/entities/order.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required super.uuid,
    required super.clientUuid,
    required super.subcategoryUuid,
    required super.subcategoryName,
    required super.address,
    required super.note,
    required super.orderDate,
    required super.orderTime,
    required super.quantity,
    required super.price,
    required super.totalPrice,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      uuid: json['uuid'] ?? '',
      clientUuid: json['client_uuid'] ?? '',
      subcategoryUuid: json['subcategory_uuid'] ?? '',
      subcategoryName: json['subcategory_name'] ?? '',
      address: json['address'] ?? '',
      note: json['note'] ?? '',
      orderDate: json['order_date'] ?? '',
      orderTime: json['order_time'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
      totalPrice: json['total_price'] ?? 0,
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
