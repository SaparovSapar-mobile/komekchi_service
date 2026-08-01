import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/order.dart';
import 'package:komekchi_service/features/domain/repositories/order_repository.dart';
import '../../../core/error/failure.dart';

class GetOrdersUsecase {
  final OrderRepository repository;

  GetOrdersUsecase({required this.repository});

  Future<Either<Failure, List<OrderItem>>> call({String? status}) {
    return repository.getOrders(status: status);
  }
}

class GetOrderByIdUsecase {
  final OrderRepository repository;

  GetOrderByIdUsecase({required this.repository});

  Future<Either<Failure, OrderItem>> call(String uuid) {
    return repository.getOrderById(uuid);
  }
}

class CreateOrderParams {
  final String subcategoryUuid;
  final String address;
  final String? note;
  final String orderDate;
  final String orderTime;
  final int quantity;

  const CreateOrderParams({
    required this.subcategoryUuid,
    required this.address,
    this.note,
    required this.orderDate,
    required this.orderTime,
    required this.quantity,
  });
}

class CreateOrderUsecase {
  final OrderRepository repository;

  CreateOrderUsecase({required this.repository});

  Future<Either<Failure, OrderItem>> call(CreateOrderParams params) {
    return repository.createOrder(
      subcategoryUuid: params.subcategoryUuid,
      address: params.address,
      note: params.note,
      orderDate: params.orderDate,
      orderTime: params.orderTime,
      quantity: params.quantity,
    );
  }
}

class CancelOrderUsecase {
  final OrderRepository repository;

  CancelOrderUsecase({required this.repository});

  Future<Either<Failure, OrderItem>> call(String uuid) {
    return repository.cancelOrder(uuid);
  }
}
