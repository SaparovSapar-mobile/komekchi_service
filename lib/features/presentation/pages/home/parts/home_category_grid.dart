import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/localized_field.dart';
import '../../../../../core/utils/theme/app_colors.dart';
import '../../../bloc/category/get_category_cubit.dart';

class HomeCategoryGrid extends StatelessWidget {
  final Color textColor;
  const HomeCategoryGrid({super.key, required this.textColor});

  @override
  Widget build(BuildContext context) {
     final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.pageBg(context);
    return BlocBuilder<GetCategoryCubit, GetCategoryState>(
      builder: (context, state) {
        if (state is GetCategoryLoading) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is GetCategoryError) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (state is GetCategorySucces) {
          final categories = state.dataCategory;
          // "Hemmesi" tile always appended at the end.
          final itemCount = categories.length + 1;
          final catgBg = bg;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: itemCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 7,
              mainAxisSpacing: 1,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final isLast = index == itemCount - 1;
              final cellWidth =
                  (MediaQuery.of(context).size.width - 28 - 8 * 4) / 5;

              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isLast) {
                        context.push("/allCategory");
                      } else {
                        final category = categories[index];
                        context.push(
                          "/categoryId",
                          extra: {
                            'uuid': category.uuid,
                            'title': category.name(context),
                            'icon': category.iconImg,
                          },
                        );
                      }
                    },
                    child: Container(
                      width: cellWidth,
                      height: cellWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: catgBg,
                        border: Border.all(color:isDark ? const Color(0xFFC6D2FF).withOpacity(0.5) :  const Color(0xFFC6D2FF)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: isLast
                            ? Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.asset(
                                  'assets/images/newcategory/image10.png',
                                  fit: BoxFit.contain,
                                ),
                            )
                            : Image.network(
                                ApiConstants.imageUrl(
                                  categories[index].iconImg,
                                ),
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.category,
                                  color: AppColor.primary,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: cellWidth,
                    child: Text(
                      isLast ? 'Hemmesi' : categories[index].name(context),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.028,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
