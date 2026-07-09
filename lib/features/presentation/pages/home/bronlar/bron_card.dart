import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/features/domain/entities/order.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import 'bottom_sheet_shikayat.dart';
import 'bronlar_screen.dart';
import 'status_badge.dart';

class BronCard extends StatelessWidget {
  final OrderItem order;
  final VoidCallback? onCancel;

  const BronCard({super.key, required this.order, this.onCancel});

  void _showBottomSheetShikayat(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => BottomSheetShikayat(
        onSelected: (confirmed) {
          if (confirmed) {
            // пользователь нажал "Howa"
          } else {
            // пользователь нажал "Yok"
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final TextStyle textStyle = AppTextStyle.medium14;
    final TextStyle textStyle1 = AppTextStyle.medium12;
    final TextStyle textStyle2 = AppTextStyle.regular12;
    final TextStyle textStyle4 = AppTextStyle.bold14;
    final status = bronStatusFromApi(order.status);
    final shortNumber = order.uuid.length >= 6
        ? order.uuid.substring(0, 6).toUpperCase()
        : order.uuid.toUpperCase();

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.borderColor, width: 1),
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
                        border: Border.all(color: Color(0xFFC6D2FF)),
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
                    border: Border.all(color: Color(0xFFC6D2FF)),
                  ),
                  child: Image.asset(
                    'assets/images/category/image2.png',
                    width: 32,
                    height: 32,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.category, color: AppColor.primary, size: 28),
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
                        'Sany: ${order.quantity}',
                        style: TextStyle(fontSize: 10, color: Color(0xFF90979F)),
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
                      border: Border.all(
                        color: Color(0xFFC6D2FF).withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColor.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            order.address,
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
                      border: Border.all(
                        color: Color(0xFFC6D2FF).withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Jemi: ',
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
                      side: BorderSide(color: Colors.red.shade200),
                      backgroundColor: Colors.red.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(
                      'Şikaýat etmek',
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
                        'Ýatyrmak',
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
                      onPressed: () {},
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
                            'Baha bermek',
                            style: textStyle.copyWith(
                              color: AppColor.titleDark,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
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
