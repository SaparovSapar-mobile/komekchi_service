import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/const.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/select/parts/day_selector.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/select/parts/time_slot_selector.dart';

import '../../../../../../core/utils/theme/app_colors.dart';

class SelectDate extends StatefulWidget {
  final String? subcategoryUuid;
  final int quantity;

  const SelectDate({super.key, this.subcategoryUuid, this.quantity = 1});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  late List<DateTime> days;
  late List<String> timeSlots;
  int selectedDayIndex = 0;
  int selectedTimeIndex = -1;

  @override
  void initState() {
    super.initState();
    _generateDays();
    _generateTimeSlots();
  }

  void _generateDays() {
    final today = DateTime.now();
    days = List.generate(30, (i) => today.add(Duration(days: i)));
  }

  void _generateTimeSlots() {
    timeSlots = [];
    for (int h = 0; h < 24; h++) {
      final start = '${h.toString().padLeft(2, '0')}:00';
      final end = '${(h + 1).toString().padLeft(2, '0')}:00';
      timeSlots.add('$start-$end');
    }
  }

  List<String> get _availableTimeSlots {
    final selectedDay = days[selectedDayIndex];
    final now = DateTime.now();
    final isToday =
        selectedDay.year == now.year &&
        selectedDay.month == now.month &&
        selectedDay.day == now.day;
    final startHour = isToday ? now.hour + 1 : 0;
    return List.generate(24 - startHour, (i) {
      final h = startHour + i;
      final start = '${h.toString().padLeft(2, '0')}:00';
      final end = '${(h + 1).toString().padLeft(2, '0')}:00';
      return '$start-$end';
    });
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

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.pageBg(context);
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    final borderColor = AppColor.border(context);

    
    final double dayItemWidth = screenWidth * 0.135;
    final double dayItemHeight = screenHeight * 0.067; 
    final double timeItemWidth = screenWidth * 0.27;
    final double timeItemHeight = screenHeight * 0.046;
    final double fontSizeNormal = screenWidth * 0.04;
    final double fontSizeMedium = screenWidth * 0.045;

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
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.058,
              child: AppBarWidget(textColor, isDark),
            ),
            const DividerWidget(),

            // ✅ Back + Title
            SizedBox(
              height: screenHeight * 0.058,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.005,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: screenWidth * 0.045, 
                      ),
                    ),
                    Text(
                      'Wagtyňyzy giriziň',
                      style: TextStyle(
                        fontSize: fontSizeNormal,
                        fontWeight: FontWeight.bold,
                        color: AppColor.titleText(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Container(
                color: cardBg,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.024, 
                    horizontal: screenWidth * 0.018,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.036, 
                    vertical: screenHeight * 0.012, 
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bg,
                    // border: Border.all(color: Color(0xFFC6D2FF))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Güni saýla
                      Text(
                        'Güni saýla',
                        style: TextStyle(
                          fontSize: fontSizeMedium, // ✅ адаптивный
                          fontWeight: FontWeight.w700,
                          color: AppColor.titleText(context),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.012),

                      DaySelector(
                        days: days,
                        selectedIndex: selectedDayIndex,
                        itemWidth: dayItemWidth,
                        itemHeight: dayItemHeight,
                        isDark: isDark,
                        borderColor: borderColor,
                        onSelected: (index) {
                          setState(() {
                            selectedDayIndex = index;
                            selectedTimeIndex = -1;
                          });
                        },
                      ),

                      SizedBox(height: screenHeight * 0.059),
                      // Wagty saýla
                      Text(
                        'Wagty saýla',
                        style: TextStyle(
                          fontSize: fontSizeMedium,
                          fontWeight: FontWeight.w700,
                          color: AppColor.titleText(context),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.012),

                      TimeSlotSelector(
                        timeSlots: _availableTimeSlots,
                        selectedIndex: selectedTimeIndex,
                        itemWidth: timeItemWidth,
                        itemHeight: timeItemHeight,
                        isDark: isDark,
                        borderColor: borderColor,
                        onSelected: (index) {
                          setState(() => selectedTimeIndex = index);
                        },
                      ),

                      const Spacer(),

                      SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.066,
                        child: ElevatedButton(
                          onPressed: selectedTimeIndex == -1
                              ? null
                              : () {
                                  final day = days[selectedDayIndex];
                                  final orderDate =
                                      '${day.year.toString().padLeft(4, '0')}-'
                                      '${day.month.toString().padLeft(2, '0')}-'
                                      '${day.day.toString().padLeft(2, '0')}';
                                  final orderTime =
                                      _availableTimeSlots[selectedTimeIndex]
                                          .split('-')
                                          .first;
                                  context.push(
                                    '/selectedDate',
                                    extra: {
                                      'subcategoryUuid': widget.subcategoryUuid,
                                      'quantity': widget.quantity,
                                      'orderDate': orderDate,
                                      'orderTime': orderTime,
                                    },
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            disabledBackgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Çagyryş',
                            style: TextStyle(
                              fontSize: fontSizeNormal, 
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.019)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
