import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/presentation/bloc/cubit/get_category_cubit.dart';

import '../../../../core/utils/theme/app_colors.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ загружаем данные при открытии экрана
    context.read<GetCategoryCubit>().fetchCategory();
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
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo/mini_logo.png",
                    width: screenWidth * 0.095,
                    height: screenWidth * 0.098,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Kömekçi\nHyzmat",
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      getCurrentDate(),
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Text("|"),
                  const SizedBox(width: 2),
                  const Icon(Icons.cloud, size: 16, color: Colors.black45),
                  const Text(
                    " 32° Aşgabat",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            Divider(height: 2, color: Colors.grey[100]),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  const Text(
                    'Ähli kategoriýalar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF5F7FF)),

            // ✅ BlocBuilder — слушаем состояние
            Expanded(
              child: Container(
                color: const Color(0xFFF5F7FF),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BlocBuilder<GetCategoryCubit, GetCategoryState>(
                    builder: (context, state) {
                      // ─── Загрузка ───
                      if (state is GetCategoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // ─── Ошибка ───
                      if (state is GetCategoryError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<GetCategoryCubit>()
                                      .fetchCategory();
                                },
                                child: const Text('Täzeden synanyşmak'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is GetCategorySucces) {
                        final items = state.dataCategory.data;

                        if (items.isEmpty) {
                          return const Center(
                            child: Text('Kategoriýa tapylmady'),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return _CategoryTile(item: item);
                          },
                        );
                      }

                      return const SizedBox();
                    },
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

class _CategoryTile extends StatelessWidget {
  final CategoryItem item; // ✅ CategoryItem (не Category)
  const _CategoryTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/categoryId', extra: item.name);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 46,
        child: Row(
          children: [
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8FD),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.network(
                item.img_tm,
                width: 28,
                height: 28,
                errorBuilder: (_, __, ___) => Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F3FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.category,
                    color: AppColor.primary,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black, size: 22),
          ],
        ),
      ),
    );
  }
}
