import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/order_usecase.dart';

import '../../../domain/entities/order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final GetOrdersUsecase getOrdersUsecase;

  OrderCubit({required this.getOrdersUsecase}) : super(OrderInitial());

  Future<void> fetchOrders({String? status}) async {
    emit(OrderLoading());
    final result = await getOrdersUsecase(status: status);
    result.fold(
      (failure) => emit(OrderError(message: failure.message)),
      (items) => emit(OrderSuccess(items: items)),
    );
  }
}
