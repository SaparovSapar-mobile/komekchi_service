import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/features/domain/entities/banners.dart';
import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../core/widgets/branded_shimmer.dart';
import '../../../bloc/banner/banner_cubit.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  List<BannerItem> _banners = [];

  @override
  void initState() {
    super.initState();
    context.read<BannerCubit>().fetchBanners();
  }

  void _startAutoScroll(int length) {
    _timer?.cancel();
    if (length <= 1) return;
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;
      final next = (_currentPage + 1) % length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannerCubit, BannerState>(
      listener: (context, state) {
        if (state is BannerSuccess) {
          _banners = state.banner;
          _startAutoScroll(_banners.length);
        }
      },
      builder: (context, state) {
        if (state is BannerLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: BrandedShimmer(
              child: BrandedShimmerCard(
                width: double.infinity,
                height: 125,
                borderRadius: 16,
              ),
            ),
          );
        }

        if (state is BannerError) {
          return SizedBox(
            height: 142,
            child: Center(child: Text(state.message)),
          );
        }

        if (state is BannerSuccess) {
          final banners = state.banner;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              height: 125,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // PageView занимает весь Stack
                    PageView.builder(
                      controller: _pageController,
                      itemCount: banners.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (context, index) {
                        return _buildBannerItem(banners[index]);
                      },
                    ),

                    // Левая стрелка
                    // Positioned(
                    //   left: 8,
                    //   top: 0,
                    //   bottom: 0,
                    //   child: Center(
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         _pageController.previousPage(
                    //           duration: const Duration(milliseconds: 400),
                    //           curve: Curves.easeInOut,
                    //         );
                    //       },
                    //       child: Container(
                    //         width: 28,
                    //         height: 28,
                    //         decoration: BoxDecoration(
                    //           color: Colors.white.withOpacity(0.5),
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: const Icon(
                    //           Icons.chevron_left,
                    //           size: 20,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // Правая стрелка
                    // Positioned(
                    //   right: 8,
                    //   top: 0,
                    //   bottom: 0,
                    //   child: Center(
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         _pageController.nextPage(
                    //           duration: const Duration(milliseconds: 400),
                    //           curve: Curves.easeInOut,
                    //         );
                    //       },
                    //       child: Container(
                    //         width: 28,
                    //         height: 28,
                    //         decoration: BoxDecoration(
                    //           color: Colors.white.withOpacity(0.5),
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: const Icon(
                    //           Icons.chevron_right,
                    //           size: 20,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // Индикаторы
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(banners.length, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: _currentPage == index ? 20 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? AppColor.primary
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBannerItem(BannerItem item) {
    final url = ApiConstants.imageUrl(item.imgTm);
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/images/banner.png', fit: BoxFit.cover);
          },
        ),
        // Тёмный градиент
        // Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [Colors.black.withOpacity(0.4), Colors.transparent],
        //       begin: Alignment.centerLeft,
        //       end: Alignment.centerRight,
        //     ),
        //   ),
        // ),
        // Текст
        // Positioned(
        //   left: 40,
        //   right: 60,
        //   top: 0,
        //   bottom: 0,
        //   child: Center(
        //     child: Text(
        //       item.name,
        //       style: const TextStyle(
        //         color: Colors.white,
        //         fontSize: 21.97,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
