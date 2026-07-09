class OrderItem {
  final String uuid;
  final String clientUuid;
  final String subcategoryUuid;
  final String subcategoryName;
  final String address;
  final String note;
  final String orderDate;
  final String orderTime;
  final int quantity;
  final num price;
  final num totalPrice;
  final String status;
  final String createdAt;
  final String updatedAt;

  const OrderItem({
    required this.uuid,
    required this.clientUuid,
    required this.subcategoryUuid,
    required this.subcategoryName,
    required this.address,
    required this.note,
    required this.orderDate,
    required this.orderTime,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
