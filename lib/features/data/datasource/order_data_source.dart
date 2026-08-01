import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/features/data/datasource/base_remote_data_source.dart';
import 'package:komekchi_service/features/data/models/order_model.dart';
import 'package:komekchi_service/features/domain/entities/order.dart';

abstract class OrderDataSource {
  Future<List<OrderItem>> getOrders({String? status});
  Future<OrderItem> getOrderById(String uuid);
  Future<OrderItem> createOrder({
    required String subcategoryUuid,
    required String address,
    String? note,
    required String orderDate,
    required String orderTime,
    required int quantity,
  });
  Future<OrderItem> cancelOrder(String uuid);
}

class OrderDataSourceImpl extends BaseRemoteDataSource
    implements OrderDataSource {
  OrderDataSourceImpl({required ApiService api}) : super(api: api);

  @override
  Future<List<OrderItem>> getOrders({String? status}) {
    return handle(
      () => api.dio.get(
        '/orders',
        queryParameters: {if (status != null) 'status': status},
      ),
      (data) => ((data['data'] as List?) ?? [])
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
      errorMessage: 'Failed to load orders',
    );
  }

  @override
  Future<OrderItem> getOrderById(String uuid) {
    return handle(
      () => api.dio.get('/orders/$uuid'),
      (data) => OrderItemModel.fromJson(data['data']),
      errorMessage: 'Failed to load order',
    );
  }

  @override
  Future<OrderItem> createOrder({
    required String subcategoryUuid,
    required String address,
    String? note,
    required String orderDate,
    required String orderTime,
    required int quantity,
  }) {
    return handle(
      () => api.dio.post(
        '/orders',
        data: {
          'subcategory_uuid': subcategoryUuid,
          'address': address,
          if (note != null) 'note': note,
          'order_date': orderDate,
          'order_time': orderTime,
          'quantity': quantity,
        },
      ),
      (data) => OrderItemModel.fromJson(data['data']),
      errorMessage: 'Failed to create order',
      successCodes: const {200, 201},
    );
  }

  @override
  Future<OrderItem> cancelOrder(String uuid) {
    return handle(
      () => api.dio.put('/orders/$uuid/cancel'),
      (data) => OrderItemModel.fromJson(data['data']),
      errorMessage: 'Failed to cancel order',
    );
  }
}
