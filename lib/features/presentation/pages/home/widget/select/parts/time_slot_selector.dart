import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';

/// Horizontal scrolling time-slot picker ("Wagty saýla") used by
/// [SelectDate].
class TimeSlotSelector extends StatelessWidget {
  final List<String> timeSlots;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final double itemWidth;
  final double itemHeight;
  final bool isDark;
  final Color borderColor;

  const TimeSlotSelector({
    super.key,
    required this.timeSlots,
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
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: itemWidth,
              margin: EdgeInsets.only(right: screenWidth * 0.013),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
              decoration: BoxDecoration(
                color: isSelected
                    ? isDark
                          ? AppColor.bgPageDark.withValues(alpha: 0.5)
                          : const Color(0xFFDFE5FF)
                    : isDark
                    ? AppColor.bgPageDark
                    : const Color(0xFFF6F8FD),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? AppColor.primary : borderColor,
                  width: 1,
                ),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    timeSlots[index],
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                      color: AppColor.titleText(context),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
