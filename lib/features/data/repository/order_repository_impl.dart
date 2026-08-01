import 'package:dartz/dartz.dart';
import 'package:komekchi_service/core/error/failure.dart';
import 'package:komekchi_service/features/data/datasource/order_data_source.dart';
import 'package:komekchi_service/features/data/repository/repository_error_guard.dart';
import 'package:komekchi_service/features/domain/entities/order.dart';
import 'package:komekchi_service/features/domain/repositories/order_repository.dart';

class OrderRepositoryImpl with RepositoryErrorGuard implements OrderRepository {
  final OrderDataSource dataSource;

  OrderRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<OrderItem>>> getOrders({String? status}) {
    return guard(() => dataSource.getOrders(status: status));
  }

  @override
  Future<Either<Failure, OrderItem>> getOrderById(String uuid) {
    return guard(() => dataSource.getOrderById(uuid));
  }

  @override
  Future<Either<Failure, OrderItem>> createOrder({
    required String subcategoryUuid,
    required String address,
    String? note,
    required String orderDate,
    required String orderTime,
    required int quantity,
  }) {
    return guard(() => dataSource.createOrder(
          subcategoryUuid: subcategoryUuid,
          address: address,
          note: note,
          orderDate: orderDate,
          orderTime: orderTime,
          quantity: quantity,
        ));
  }

  @override
  Future<Either<Failure, OrderItem>> cancelOrder(String uuid) {
    return guard(() => dataSource.cancelOrder(uuid));
  }
}
