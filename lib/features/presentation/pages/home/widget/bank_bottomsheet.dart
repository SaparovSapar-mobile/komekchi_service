import 'package:flutter/material.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../core/utils/theme/app_theme.dart';

class BankBottomSheet extends StatefulWidget {
  final String? selected;
  final ValueChanged<String> onSelected;

  const BankBottomSheet({required this.selected, required this.onSelected});

  @override
  State<BankBottomSheet> createState() => _BankBottomSheetState();
}

class _BankBottomSheetState extends State<BankBottomSheet> {
  late String? _current;

  final List<BankItem> items = const [
    BankItem(title: 'Rysgal bank', subtitle: "assets/images/icon/rysgal.png"),
    BankItem(
      title: 'Halk bank',
      subtitle: "assets/images/icon/halkbank.png",
    ),
    BankItem(title: 'Sebagat bank', subtitle: "assets/images/icon/senagat.png"),
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
            'Bank saýlaň',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(item.subtitle, width: 67, height: 45,),
                          const SizedBox(width: 8),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
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
                          color: isSelected
                              ? AppColor.primary
                              : Colors.grey.shade300,
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

class BankItem {
  final String title;
  final String subtitle;
  const BankItem({required this.title, required this.subtitle});
}
