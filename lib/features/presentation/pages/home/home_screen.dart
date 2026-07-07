import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/features/presentation/bloc/aksiya/aksiya_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/banner/banner_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/category/get_category_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/weather/weather_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/banner_slider.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/horizontal_service_list.dart';
import 'package:komekchi_service/injector.dart';

import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/theme/const.dart';
import 'parts/home_aksiya_section.dart';
import 'parts/home_app_bar.dart';
import 'parts/home_biz_grid.dart';
import 'parts/home_category_grid.dart';
import 'parts/home_salgym_bar.dart';
import 'parts/subtitle.dart';

export 'parts/home_app_bar.dart' show AppBarWidget, getCurrentDate;
export 'parts/home_biz_grid.dart' show BizItem;
export 'parts/subtitle.dart' show Subtitle;

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  const HomeScreen({super.key, required this.scrollController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AksiyaCubit _aksiyaCubit = sl<AksiyaCubit>();

  @override
  void initState() {
    super.initState();
    context.read<GetCategoryCubit>().fetchCategory();
    _aksiyaCubit.fetchAksiyalar();
  }

  @override
  void dispose() {
    _aksiyaCubit.close();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Future.wait([
      context.read<GetCategoryCubit>().fetchCategory(),
      context.read<BannerCubit>().fetchBanners(),
      context.read<WeatherCubit>().fetchWeather(),
      _aksiyaCubit.fetchAksiyalar(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor = AppColor.titleText(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBarWidget(textColor, isDark),
          SalgymBar(isDark: isDark, textColor: textColor),
          const SizedBox(height: 5),
          Expanded(
            child: RefreshIndicator(
              color: AppColor.primary,
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                controller: widget.scrollController,
                child: Column(
                  children: [
                    const DividerWidget(),
                    GestureDetector(
                      onTap: () => context.push("/allCategory"),
                      child: const Subtitle(text: "Hyzmatlar"),
                    ),
                    HomeCategoryGrid(textColor: textColor),
                    const DividerWidget(),
                    BannerSlider(),
                    const DividerWidget(),
                    HorizontalServiceList(is24_7: true, text: "7/24 hyzmatlar"),
                    const DividerWidget(),
                    HorizontalServiceList(
                      isFeatured: true,
                      text: "Öňde baryjylar",
                    ),
                    const DividerWidget(),
                    GestureDetector(
                      onTap: () => context.push("/aksiya"),
                      child: const Subtitle(text: "Aksiýalar"),
                    ),
                    HomeAksiyaSection(aksiyaCubit: _aksiyaCubit),
                    const DividerWidget(),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 15.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Näme üçin biz?",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    HomeBizGrid(biz: defaultBizItems),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
