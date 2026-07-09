import 'package:dartz/dartz.dart';
import 'package:komekchi_service/features/domain/entities/order.dart';
import 'package:komekchi_service/features/domain/repositories/repository_app.dart';
import '../../../core/error/faiulre.dart';

class GetOrdersUsecase {
  final GetAppRepository getAppsRepository;

  GetOrdersUsecase({required this.getAppsRepository});

  Future<Either<Failure, List<OrderItem>>> call({String? status}) {
    return getAppsRepository.getOrders(status: status);
  }
}

class GetOrderByIdUsecase {
  final GetAppRepository getAppsRepository;

  GetOrderByIdUsecase({required this.getAppsRepository});

  Future<Either<Failure, OrderItem>> call(String uuid) {
    return getAppsRepository.getOrderById(uuid);
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
  final GetAppRepository getAppsRepository;

  CreateOrderUsecase({required this.getAppsRepository});

  Future<Either<Failure, OrderItem>> call(CreateOrderParams params) {
    return getAppsRepository.createOrder(
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
  final GetAppRepository getAppsRepository;

  CancelOrderUsecase({required this.getAppsRepository});

  Future<Either<Failure, OrderItem>> call(String uuid) {
    return getAppsRepository.cancelOrder(uuid);
  }
}
