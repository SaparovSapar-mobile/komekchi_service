import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/utils/theme/app_colors.dart';

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
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 31.0,
                vertical: 10.31,
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo/mini_logo.png",
                    width: 37.14,
                    height: 38.42,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Kömekçi\nHyzmat",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    getCurrentDate(),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(width: 2),
                  const Text("|"),
                  const SizedBox(width: 2),
                  const Icon(Icons.cloud, size: 16, color: Colors.black45),
                  const Text(
                    " 32° Aşgabat",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Text(
                'Meniň Bronlarym',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),

            // Tabs
            SizedBox(
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return _BronCard(item: _filtered[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BronCard extends StatelessWidget {
  final BronItem item;
  const _BronCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
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
                      padding: const EdgeInsets.only(left: 4),
                      width: 65,
                      height: 22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Color(0xFFF6F8FD),
                        border: Border.all(color: Color(0xFFC6D2FF)),
                      ),
                      child: Text(
                        'N°${item.number}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.date,
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),

                const Spacer(),
                if (item.rating != null) ...[
                  const SizedBox(width: 6),
                  Container(
                    width: 50,
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xFFF6F8FD),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.rating.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(Icons.star, size: 15, color: Colors.amber),
                      ],
                    ),
                  ),
                ],
                const SizedBox(width: 9),
                _StatusBadge(status: item.status),
              ],
            ),
          ),

          // Category + service
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
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.category,
                      color: AppColor.primary,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.category,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      item.service,
                      style: TextStyle(fontSize: 10, color: Color(0xFF90979F)),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.chevron_right, color: Colors.black),
              ],
            ),
          ),

          // Address + price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 196,
                  height: 33,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F8FD),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xFFC6D2FF)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColor.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(item.address, style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(left: 6.5),
                  width: 136,
                  height: 33,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F8FD),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xFFC6D2FF)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Jemi: ',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Text(
                        item.price,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF047857),
                        ),
                      ),
                    ],
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
                // Refresh icon
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F8FD),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.refresh, size: 20, color: Colors.black),
                ),
                const SizedBox(width: 12),

                // Sikayat etmek
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
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

                // Baha bermek (only tamamlanan)
                if (item.status == BronStatus.tamamlanan) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Baha bermek',
                            style: TextStyle(fontSize: 13, color: Colors.white),
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

class _StatusBadge extends StatelessWidget {
  final BronStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case BronStatus.garasylyar:
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange;
        label = 'Garaşylýar';
        break;
      case BronStatus.tamamlanan:
        bgColor = Colors.green.shade50;
        textColor = Colors.green;
        label = 'Tamamlanan';
        break;
      case BronStatus.yatyryldy:
        bgColor = Colors.red.shade50;
        textColor = Colors.red;
        label = 'Ýatyryldy';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: textColor, shape: BoxShape.circle),
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
