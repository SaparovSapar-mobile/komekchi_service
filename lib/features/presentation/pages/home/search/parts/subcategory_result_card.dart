import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/core/utils/localized_field.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';

import '../../../../../../core/utils/theme/app_colors.dart';

/// Matches the subcategory card style used on [CategoryId] — big image,
/// title and price below.
class SubcategoryResultCard extends StatelessWidget {
  final SubcategoryItem item;
  final VoidCallback onTap;

  const SubcategoryResultCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = AppColor.cardBg(context);
    final borderColor = AppColor.border(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cardBg,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9.46),
              child: Image.network(
                ApiConstants.imageUrl(item.img),
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 160,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image, color: Colors.grey, size: 40),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.name(context),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColor.titleText(context),
                    ),
                  ),
                ),
                if (item.paymentMethod.price > 0)
                  Text(
                    "${item.paymentMethod.price} tmt",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primary,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
