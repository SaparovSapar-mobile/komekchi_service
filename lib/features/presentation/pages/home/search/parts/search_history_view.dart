import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';

import '../../../../../../core/utils/theme/app_colors.dart';

/// Recent searches (klaviatura açyk wagty, sorag ýazylmadyk bolsa)
class SearchHistoryView extends StatelessWidget {
  final List<String> history;
  final ValueChanged<String> onTap;
  final ValueChanged<String> onRemove;
  final VoidCallback onClear;

  const SearchHistoryView({
    super.key,
    required this.history,
    required this.onTap,
    required this.onRemove,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final TextStyle textStyle1 = AppTextStyle.semiBold14;

    if (history.isEmpty) {
      return Center(
        child: Text(
          'Gözleg taryhy ýok',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gözleg taryhy:',
              style: textStyle1.copyWith(
                color: AppColor.descriptionText(context),
              ),
            ),
            GestureDetector(
              onTap: onClear,
              child: Text(
                'All clear',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? AppColor.bgBlogLight : AppColor.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(history.length, (index) {
          final item = history[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.history, color: Colors.grey.shade400, size: 20),
            title: Text(item, style: const TextStyle(fontSize: 14)),
            trailing: IconButton(
              icon: Icon(Icons.close, size: 16, color: Colors.grey.shade400),
              onPressed: () => onRemove(item),
            ),
            onTap: () => onTap(item),
          );
        }),
      ],
    );
  }
}
