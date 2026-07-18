import 'package:flutter/material.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../core/utils/theme/app_theme.dart';

class TolegBottomSheet extends StatefulWidget {
  final String? selected;
  final ValueChanged<String> onSelected;

  const TolegBottomSheet({required this.selected, required this.onSelected});

  @override
  State<TolegBottomSheet> createState() => _TolegBottomSheetState();
}

class _TolegBottomSheetState extends State<TolegBottomSheet> {
  late String? _current;

  final List<TolegItem> items = const [
    TolegItem(title: 'Nagt töleg', subtitle: 'Sargyt gelende nagt töleg.'),
    // TolegItem(title: 'Terminal töleg', subtitle: 'Sargydy bank kart arkaly töleg.'),
    // TolegItem(title: 'Onlaýn töleg', subtitle: 'Sargydy bank kart arkaly töleg.'),
  ];

  @override
  void initState() {
    super.initState();
    _current = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 306,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 58,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 44),

          // Title
          const Text(
            'Tölegiň görnüşi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          const SizedBox(height: 8),

          // Items
          ...items.map((item) {
            final isSelected = _current == item.title;
            return GestureDetector(
              onTap: () {
                setState(() => _current = item.title);
                Future.delayed(const Duration(milliseconds: 150), () {
                  widget.onSelected(item.title);
                });
              },
              child: Container(
                height: 59,
                width: 351,
                color: Colors.transparent,
                // padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 13,),
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            item.subtitle,
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                    // Radio button
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppColor.primary : Colors.grey.shade300,
                          width: isSelected ? 6 : 1.5,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class TolegItem {
  final String title;
  final String subtitle;
  const TolegItem({required this.title, required this.subtitle});
}