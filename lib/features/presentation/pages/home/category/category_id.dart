import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/core/utils/localized_field.dart';
import 'package:komekchi_service/features/presentation/bloc/subcategory/subcategory_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class CategoryId extends StatefulWidget {
  final String categoryUuid;
  final String title;
  final String categoryIcon;
  const CategoryId({
    super.key,
    required this.categoryUuid,
    required this.title,
    this.categoryIcon = '',
  });

  @override
  State<CategoryId> createState() => _CategoryIdState();
}

class _CategoryIdState extends State<CategoryId> {
  @override
  void initState() {
    super.initState();
    context.read<SubcategoryCubit>().fetchSubcategories(
      categoryUuid: widget.categoryUuid,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.pageBg(context);
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    final borderColor = AppColor.border(context);

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
          color: bg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Header
            AppBarWidget(textColor, isDark),
            // Back button + title + search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const SizedBox(height: 49),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.titleText(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context.push('/search');
                    },
                    icon: Image.asset(
                      "assets/images/icon/search.png",
                      width: 24,
                      height: 24,
                      color: AppColor.titleText(context),
                    ),
                  ),
                ],
              ),
            ),

            // List
            Expanded(
              child: BlocBuilder<SubcategoryCubit, SubcategoryState>(
                builder: (context, state) {
                  if (state is SubcategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SubcategoryError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (state is SubcategorySuccess) {
                    final items = state.items;

                    if (items.isEmpty) {
                      return const Center(child: Text('Hyzmat tapylmady'));
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 16,
                            left: 22,
                            right: 22,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              context.push("/detail", extra: {"uuid": item.uuid});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: cardBg,
                                border: Border.all(color: borderColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          9.46,
                                        ),
                                        child: Image.network(
                                          ApiConstants.imageUrl(item.img),
                                          width: 352,
                                          height: 160,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                                    width: 332,
                                                    height: 149,
                                                    color:
                                                        Colors.grey.shade200,
                                                    child: const Icon(
                                                      Icons.image,
                                                      color: Colors.grey,
                                                      size: 40,
                                                    ),
                                                  ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 8,  
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: bg,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  ApiConstants.imageUrl(
                                                    widget.categoryIcon,
                                                  ),
                                                  width: 14,
                                                  height: 14,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (_, __, ___) => Icon(
                                                        Icons.build_outlined,
                                                        size: 14,
                                                        color:
                                                            AppColor.primary,
                                                      ),
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                item.categoryName,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: textColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.name(context),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      if (item.ratingCount > 0) ...[
                                        Text(
                                          item.avgRating.toStringAsFixed(1),
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: textColor,
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        const Icon(
                                          Icons.star_rounded,
                                          size: 16,
                                          color: Color(0xFFFBB725),
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                      if (item.paymentMethod.price > 0)
                                        Text(
                                          "${item.paymentMethod.price} tmt",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
