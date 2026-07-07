import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';
import 'package:komekchi_service/core/utils/theme/const.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({super.key});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  late List<DateTime> days;
  late List<String> timeSlots;
  int selectedDayIndex = 0;
  int selectedTimeIndex = -1;

  final List<String> weekDays = [
    'Du',
    'Siş',
    'Çar',
    'Pen',
    'Ann',
    'Şen',
    'Ýek',
  ];

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

  bool _isTimePassed(int timeIndex) {
    final selectedDay = days[selectedDayIndex];
    final now = DateTime.now();
    final isToday =
        selectedDay.year == now.year &&
        selectedDay.month == now.month &&
        selectedDay.day == now.day;
    if (!isToday) return false;
    return timeIndex <= now.hour;
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

  String _weekDayName(DateTime date) {
    return weekDays[date.weekday - 1];
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
    // ✅ Получаем размеры экрана
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor =  AppColor.titleText(context);
    final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;


    // ✅ Адаптивные размеры на основе ширины экрана
    final double dayItemWidth = screenWidth * 0.135; // ~54px на 390px экране
    final double dayItemHeight = screenHeight * 0.067; // ~56px на 844px экране
    final double timeItemWidth = screenWidth * 0.27; // ~107px на 390px экране
    final double timeItemHeight = screenHeight * 0.046; // ~39px на 844px экране
    final double fontSizeSmall = screenWidth * 0.033; // ~13px
    final double fontSizeNormal = screenWidth * 0.04; // ~16px
    final double fontSizeMedium = screenWidth * 0.045; // ~18px
    final double horizontalPadding = screenWidth * 0.04; // ~16px


    

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
        decoration:  BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Header — адаптивный padding и шрифты
            SizedBox(
              height: screenHeight * 0.058, // ~49px
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
                        size: screenWidth * 0.045, // ✅ адаптивный
                      ),
                    ),
                    Text(
                      'Wagtyňyzy giriziň',
                      style: TextStyle(
                        fontSize: fontSizeNormal, // ✅ адаптивный
                        fontWeight: FontWeight.bold,
                        color: AppColor.titleText(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const DividerWidget(),

            Expanded(
              child: Container(
                color: cardBg,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.024, // ✅ ~20px адаптивно
                    horizontal: screenWidth * 0.018, // ✅ ~7px адаптивно
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.036, // ✅ ~14px адаптивно
                    vertical: screenHeight * 0.012, // ✅ ~10px адаптивно
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

                      // ✅ Дни — адаптивная ширина и высота
                      SizedBox(
                        height: dayItemHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: days.length,
                          itemBuilder: (context, index) {
                            final day = days[index];
                            final isSelected = selectedDayIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDayIndex = index;
                                  selectedTimeIndex = -1;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: EdgeInsets.only(
                                  right: screenWidth * 0.025,
                                ),
                                width: dayItemWidth, // ✅ адаптивная ширина
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFFDFE5FF)
                                      : const Color(0xFFF6F8FD),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColor.primary
                                        : const Color(0xFFEEEEEE),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _weekDayName(day),
                                      style: TextStyle(
                                        fontSize:
                                            fontSizeNormal, // ✅ адаптивный
                                        color: const Color(0xFF90979F),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    Text(
                                      '${day.day}',
                                      style: TextStyle(
                                        fontSize:
                                            fontSizeNormal, // ✅ адаптивный
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.059), // ~50px адаптивно
                      // Wagty saýla
                      Text(
                        'Wagty saýla',
                        style: TextStyle(
                          fontSize: fontSizeMedium, // ✅ адаптивный
                          fontWeight: FontWeight.w700,
                          color: AppColor.titleText(context),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.012),

                      // ✅ Время — адаптивная ширина и высота
                      SizedBox(
                        height: timeItemHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _availableTimeSlots.length,
                          itemBuilder: (context, index) {
                            final isSelected = selectedTimeIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTimeIndex = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: timeItemWidth, // ✅ адаптивная ширина
                                margin: EdgeInsets.only(
                                  right: screenWidth * 0.013,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      screenWidth *
                                      0.015, // ✅ адаптивный padding
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFFDFE5FF)
                                      : const Color(0xFFF6F8FD),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColor.primary
                                        : const Color(0xFFEEEEEE),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: FittedBox(
                                    // ✅ текст не вылезет никогда
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      _availableTimeSlots[index],
                                      style: TextStyle(
                                        fontSize:
                                            fontSizeNormal, // ✅ адаптивный
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const Spacer(),

                      // ✅ Кнопка — адаптивная высота
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.066, // ~56px адаптивно
                        child: ElevatedButton(
                          onPressed: () {
                            context.push('/selectedDate');
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
                              fontSize: fontSizeNormal, // ✅ адаптивный
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.019), // ~16px адаптивно
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
