import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/core/widgets/empty_state_view.dart';
import 'package:komekchi_service/features/domain/entities/order.dart';
import 'package:komekchi_service/features/domain/usecases/order_usecase.dart';
import 'package:komekchi_service/features/presentation/bloc/order/order_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import 'bron_card.dart';

/// Backend order.status values assumed as: pending, cancelled, completed.
/// Adjust `_statusFilters` below if the API uses different values.
enum BronStatus { pending, cancelled, completed, unknown }

BronStatus bronStatusFromApi(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return BronStatus.pending;
    case 'cancelled':
    case 'canceled':
      return BronStatus.cancelled;
    case 'completed':
      return BronStatus.completed;
    default:
      return BronStatus.unknown;
  }
}

class BronlarScreen extends StatefulWidget {
  final VoidCallback? onBook;

  const BronlarScreen({super.key, this.onBook});

  @override
  State<BronlarScreen> createState() => _BronlarScreenState();
}

class _BronlarScreenState extends State<BronlarScreen> {
  int _selectedTab = 0;

  /// null while checking, then true/false once resolved.
  bool? _isLoggedIn;

  List<String> _tabs(AppLocalizations t) => [
    t.tabAll,
    t.tabPending,
    t.tabCancelled,
    t.tabCompleted,
  ];

  static const List<String?> _statusFilters = [
    null,
    'pending',
    'cancelled',
    'completed',
  ];

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final loggedIn = token != null && token.isNotEmpty;
    if (!mounted) return;
    setState(() => _isLoggedIn = loggedIn);
    if (loggedIn) {
      context.read<OrderCubit>().fetchOrders();
    }
  }

  void _selectTab(int index) {
    setState(() => _selectedTab = index);
    context.read<OrderCubit>().fetchOrders(status: _statusFilters[index]);
  }

  Future<void> _cancelOrder(OrderItem order) async {
    final t = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.cancelBookingTitle),
        content: Text(t.cancelBookingBody(order.uuid.substring(0, 6))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.no),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.yes),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final result = await sl<CancelOrderUsecase>().call(order.uuid);
    if (!mounted) return;
    result.fold(
      (failure) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failure.message))),
      (_) => context.read<OrderCubit>().fetchOrders(
        status: _statusFilters[_selectedTab],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    final TextStyle textStyle = AppTextStyle.semiBold16;
    final t = AppLocalizations.of(context)!;
    final tabs = _tabs(t);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(textColor, isDark),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Text(
              t.bronlarTitle,
              style: textStyle.copyWith(color: AppColor.titleText(context)),
            ),
          ),

          // Tabs (only relevant once we know the user is logged in)
          if (_isLoggedIn == true) ...[
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedTab == index;
                  return GestureDetector(
                    onTap: () => _selectTab(index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColor.primary : isDark ? AppColor.bgPageDark : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        // border: Border.all(
                        //   color: isSelected
                        //       ? AppColor.primary
                        //       : Colors.grey.shade300,
                        //   width: 1,
                        // ),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : isDark ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ],

          Expanded(
            child: _isLoggedIn != true
                ? EmptyStateView.noBookings(
                    onBook: _isLoggedIn == null
                        ? () {}
                        : () => context.push('/login'),
                  )
                : BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      if (state is OrderLoading || state is OrderInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is OrderError) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.message,
                                style: const TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () => _selectTab(_selectedTab),
                                child: Text(t.retry),
                              ),
                            ],
                          ),
                        );
                      }

                      final items = (state as OrderSuccess).items;

                      if (items.isEmpty) {
                        return EmptyStateView.noBookings(
                          onBook: widget.onBook ?? () {},
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 12,
                          bottom: MediaQuery.of(context).padding.bottom,
                        ),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order = items[index];
                          return BronCard(
                            order: order,
                            onCancel: bronStatusFromApi(order.status) ==
                                    BronStatus.pending
                                ? () => _cancelOrder(order)
                                : null,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
