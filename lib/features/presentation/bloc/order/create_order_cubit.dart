import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/order_usecase.dart';

import '../../../domain/entities/order.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  final CreateOrderUsecase createOrderUsecase;

  CreateOrderCubit({required this.createOrderUsecase})
    : super(CreateOrderInitial());

  Future<void> createOrder({
    required String subcategoryUuid,
    required String address,
    String? note,
    required String orderDate,
    required String orderTime,
    required int quantity,
  }) async {
    emit(CreateOrderLoading());

    final result = await createOrderUsecase(
      CreateOrderParams(
        subcategoryUuid: subcategoryUuid,
        address: address,
        note: note,
        orderDate: orderDate,
        orderTime: orderTime,
        quantity: quantity,
      ),
    );

    result.fold(
      (failure) => emit(CreateOrderError(message: failure.message)),
      (item) => emit(CreateOrderSuccess(item: item)),
    );
  }
}
