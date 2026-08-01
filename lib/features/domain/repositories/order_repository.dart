import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/domain/entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderItem>>> getOrders({String? status});
  Future<Either<Failure, OrderItem>> getOrderById(String uuid);
  Future<Either<Failure, OrderItem>> createOrder({
    required String subcategoryUuid,
    required String address,
    String? note,
    required String orderDate,
    required String orderTime,
    required int quantity,
  });
  Future<Either<Failure, OrderItem>> cancelOrder(String uuid);
}
