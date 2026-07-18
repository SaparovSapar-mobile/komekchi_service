import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/features/domain/entities/aksiya.dart';
import 'package:komekchi_service/features/presentation/bloc/aksiya/aksiya_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class AksiyalarScreen extends StatefulWidget {
  const AksiyalarScreen({super.key});

  @override
  State<AksiyalarScreen> createState() => _AksiyalarScreenState();
}

class _AksiyalarScreenState extends State<AksiyalarScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AksiyaCubit>().fetchAksiyalar();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColor.titleText(context);

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
          children: [
            // Header
            AppBarWidget(textColor, isDark),
            const Divider(height: 1, color: Color(0xFFF5F7FF)),

            // Back + Title + Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  const Text(
                    'Aksiyalar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/images/icon/search.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF5F7FF)),

            // Grid
            Expanded(
              child: Container(
                color: const Color(0xFFF5F7FF),
                child: BlocBuilder<AksiyaCubit, AksiyaState>(
                  builder: (context, state) {
                    if (state is AksiyaLoading || state is AksiyaInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is AksiyaError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final items = (state as AksiyaSuccess).items;

                    if (items.isEmpty) {
                      return const Center(child: Text('Aksiýa tapylmady'));
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 1,
                            childAspectRatio: 1.4,
                          ),
                      itemBuilder: (context, index) {
                        return _AksiyaCard(item: items[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AksiyaCard extends StatelessWidget {
  final AksiyaItem item;
  const _AksiyaCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/aksiyaDetail", extra: {"uuid": item.uuid});
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.network(
          ApiConstants.imageUrl(item.imgTm),
          width: 171.55,
          height: 104.51,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.grey.shade200,
            child: const Icon(Icons.image, size: 40, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
