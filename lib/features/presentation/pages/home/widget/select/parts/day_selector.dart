import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';

/// Horizontal scrolling day picker ("Güni saýla") used by [SelectDate].
class DaySelector extends StatelessWidget {
  static const _weekDays = ['Du', 'Siş', 'Çar', 'Pen', 'Ann', 'Şen', 'Ýek'];

  final List<DateTime> days;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final double itemWidth;
  final double itemHeight;
  final bool isDark;
  final Color borderColor;

  const DaySelector({
    super.key,
    required this.days,
    required this.selectedIndex,
    required this.onSelected,
    required this.itemWidth,
    required this.itemHeight,
    required this.isDark,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: screenWidth * 0.025),
              width: itemWidth,
              decoration: BoxDecoration(
                color: isSelected
                    ? isDark
                          ? AppColor.bgPageDark.withValues(alpha: 0.5)
                          : const Color(0xFFDFE5FF)
                    : isDark
                    ? AppColor.bgPageDark
                    : const Color(0xFFF6F8FD),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? AppColor.primary
                      : isDark
                      ? const Color(0xFFEEEEEE).withValues(alpha: 0.5)
                      : borderColor,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weekDays[day.weekday - 1],
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: AppColor.descriptionText(context),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  Text(
                    '${day.day}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w700,
                      color: AppColor.titleText(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
