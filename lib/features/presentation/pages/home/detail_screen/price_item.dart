import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';

class PriceRow extends StatelessWidget {
  final String label;
  final String value;

  const PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: AppColor.titleText(context)),
        ),
        Text(
          value,
          style:  TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.titleText(context),
          ),
        ),
      ],
    );
  }
}
