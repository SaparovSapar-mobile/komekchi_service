import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import 'bron_card.dart';

class BronlarScreen extends StatefulWidget {
  const BronlarScreen({super.key});

  @override
  State<BronlarScreen> createState() => _BronlarScreenState();
}

class _BronlarScreenState extends State<BronlarScreen> {
  int _selectedTab = 0;

  final List<String> tabs = [
    'Hemmesi',
    'Garasylyar',
    'Ýatyryldy',
    'Tamamlanan',
  ];

  final List<BronItem> brons = [
    BronItem(
      number: '65493',
      date: '11.11.2026  19:00',
      category: 'Arassaçylyk',
      service: 'Ayna yuwmak',
      address: 'Iş ýerim',
      price: '546.00 man',
      status: BronStatus.garasylyar,
      rating: null,
    ),
    BronItem(
      number: '65493',
      date: '11.11.2026  19:00',
      category: 'Arassaçylyk',
      service: 'Ayna yuwmak',
      address: 'Iş ýerim',
      price: '546.00 man',
      status: BronStatus.tamamlanan,
      rating: 4.7,
    ),
    BronItem(
      number: '65493',
      date: '11.11.2026  19:00',
      category: 'Arassaçylyk',
      service: 'Ayna yuwmak',
      address: 'Iş ýerim',
      price: '546.00 man',
      status: BronStatus.yatyryldy,
      rating: null,
    ),
  ];

  List<BronItem> get _filtered {
    if (_selectedTab == 0) return brons;

    switch (_selectedTab) {
      case 1:
        return brons.where((b) => b.status == BronStatus.garasylyar).toList();
      case 2:
        return brons.where((b) => b.status == BronStatus.yatyryldy).toList();
      case 3:
        return brons.where((b) => b.status == BronStatus.tamamlanan).toList();
      default:
        return brons;
    }
  }

  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    // final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor = AppColor.titleText(context);
    final TextStyle textStyle = AppTextStyle.semiBold16;
    // final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;

    return Container(
      // padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
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
          // Header
          AppBarWidget(textColor, isDark),
          // Title
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Text(
              'Bronlarym',
              style: textStyle.copyWith(color: AppColor.titleText(context)),
            ),
          ),

          // Tabs
          Container(
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedTab == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTab = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColor.primary : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? AppColor.primary
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Bron cards
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Text(
                      'Bron ýok',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 15,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 12,
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),

                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return BronCard(item: _filtered[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

enum BronStatus { garasylyar, tamamlanan, yatyryldy }

class BronItem {
  final String number;
  final String date;
  final String category;
  final String service;
  final String address;
  final String price;
  final BronStatus status;
  final double? rating;

  BronItem({
    required this.number,
    required this.date,
    required this.category,
    required this.service,
    required this.address,
    required this.price,
    required this.status,
    this.rating,
  });
}
