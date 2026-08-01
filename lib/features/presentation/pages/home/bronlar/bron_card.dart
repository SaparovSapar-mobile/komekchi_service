import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/entities/order.dart';
import 'package:komekchi_service/features/domain/usecases/address_usecase.dart';
import 'package:komekchi_service/features/presentation/bloc/subcategory/subcategory_detail_cubit.dart';
import 'package:komekchi_service/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../widget/address_type_display.dart';
import '../widget/rate_service_sheet.dart';
import 'bottom_sheet_shikayat.dart';
import 'bronlar_screen.dart';
import 'status_badge.dart';

class BronCard extends StatefulWidget {
  final OrderItem order;
  final VoidCallback? onCancel;

  const BronCard({super.key, required this.order, this.onCancel});

  @override
  State<BronCard> createState() => _BronCardState();
}

class _BronCardState extends State<BronCard> {
  late final SubcategoryDetailCubit _subcategoryDetailCubit =
      sl<SubcategoryDetailCubit>();

  // The order only stores the raw address text (often raw coordinates) it
  // was submitted with. To show "Öý/Iş/Başga" instead, we match it against
  // the user's currently saved addresses by content.
  List<AddressItem> _savedAddresses = [];

  OrderItem get order => widget.order;
  VoidCallback? get onCancel => widget.onCancel;

  @override
  void initState() {
    super.initState();
    _subcategoryDetailCubit.fetchSubcategoryById(order.subcategoryUuid);
    _loadSavedAddresses();
  }

  Future<void> _loadSavedAddresses() async {
    final result = await sl<GetAddressesUsecase>().call();
    if (!mounted) return;
    result.fold((_) {}, (items) => setState(() => _savedAddresses = items));
  }

  String _displayAddress(AppLocalizations t) {
    final match = _savedAddresses.where((a) => a.address == order.address);
    return match.isEmpty
        ? order.address
        : addressTypeLabel(t, match.first.addressTypeName);
  }

  @override
  void dispose() {
    _subcategoryDetailCubit.close();
    super.dispose();
  }

  void _showBottomSheetShikayat(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => BottomSheetShikayat(
        onSelected: (confirmed) async {
          if (!confirmed) return;

          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');
          if (!context.mounted) return;

          if (token == null || token.isEmpty) {
            context.push('/login');
          } else {
            context.push('/nagilelik');
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.cardBg(context);
    final cardBg = AppColor.pageBg(context);
    final TextStyle textStyle = AppTextStyle.medium14;
    final TextStyle textStyle1 = AppTextStyle.medium12;
    final TextStyle textStyle2 = AppTextStyle.regular12;
    final TextStyle textStyle4 = AppTextStyle.bold14;
    final status = bronStatusFromApi(order.status);
    final shortNumber = order.uuid.length >= 6
        ? order.uuid.substring(0, 6).toUpperCase()
        : order.uuid.toUpperCase();
    final t = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: number + date + status
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 65,
                      height: 22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: bg,
                      ),
                      child: Center(
                        child: Text(
                          'N°$shortNumber',
                          style: textStyle1.copyWith(
                            color: AppColor.titleText(context),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${order.orderDate} ${order.orderTime}',
                      style: textStyle2.copyWith(
                        color: AppColor.titleText(context),
                      ),
                    ),
                  ],
                ),

                const Spacer(),
                StatusBadge(status: status),
              ],
            ),
          ),

          // Service
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 39,
                  height: 39,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Color(0xFFF6F8FD),
                    // border: Border.all(color: Color(0xFFC6D2FF)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: BlocBuilder<SubcategoryDetailCubit,
                        SubcategoryDetailState>(
                      bloc: _subcategoryDetailCubit,
                      builder: (context, state) {
                        if (state is SubcategoryDetailSuccess &&
                            state.item.img.isNotEmpty) {
                          return Image.network(
                            ApiConstants.imageUrl(state.item.img),
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.category,
                              color: AppColor.primary,
                              size: 28,
                            ),
                          );
                        }
                        return Icon(
                          Icons.category,
                          color: AppColor.primary,
                          size: 28,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.subcategoryName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        t.orderQuantity(order.quantity),
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF90979F),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Address + price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 33,
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(5),
                      // border: Border.all(
                      //   color: Color(0xFFC6D2FF).withOpacity(0.2),
                      // ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 3,),
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColor.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            _displayAddress(t),
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.only(left: 6.5),
                    height: 33,
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(5),
                      // border: Border.all(
                      //   color: Color(0xFFC6D2FF).withOpacity(0.2),
                      // ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          t.orderTotal,
                          style: textStyle4.copyWith(
                            color: AppColor.titleText(context),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${order.totalPrice} tmt',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF047857),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                // Sikayat etmek
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showBottomSheetShikayat(context),
                    style: OutlinedButton.styleFrom(
                      side:BorderSide(color:isDark ? Colors.transparent : Colors.red.shade200),
                      backgroundColor:isDark ?  Color(0x1AFF5050) : Colors.red.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(
                      t.complain,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // Ýatyrmak (only pending orders)
                if (status == BronStatus.pending && onCancel != null) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColor.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: Text(
                        t.cancelBooking,
                        style: textStyle.copyWith(color: AppColor.primary),
                      ),
                    ),
                  ),
                ],

                // Baha bermek (only tamamlanan)
                if (status == BronStatus.completed) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => showRateServiceSheet(
                        context,
                        subcategoryUuid: order.subcategoryUuid,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.rateService,
                            style: textStyle.copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
