import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:komekchi_service/features/domain/usecases/order_usecase.dart';

import '../../../domain/entities/order.dart';

part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  final GetOrderByIdUsecase getOrderByIdUsecase;
  final CancelOrderUsecase cancelOrderUsecase;

  OrderDetailCubit({
    required this.getOrderByIdUsecase,
    required this.cancelOrderUsecase,
  }) : super(OrderDetailInitial());

  Future<void> fetchOrderById(String uuid) async {
    emit(OrderDetailLoading());
    final result = await getOrderByIdUsecase(uuid);
    result.fold(
      (failure) => emit(OrderDetailError(message: failure.message)),
      (item) => emit(OrderDetailSuccess(item: item)),
    );
  }

  Future<void> cancelOrder(String uuid) async {
    emit(OrderDetailLoading());
    final result = await cancelOrderUsecase(uuid);
    result.fold(
      (failure) => emit(OrderDetailError(message: failure.message)),
      (item) => emit(OrderDetailSuccess(item: item)),
    );
  }
}
