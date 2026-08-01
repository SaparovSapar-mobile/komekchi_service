import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/core/utils/localized_field.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';
import 'package:komekchi_service/features/presentation/bloc/subcategory/subcategory_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/injector.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../core/widgets/branded_shimmer.dart';
import '../../../../../l10n/gen/app_localizations.dart';

class HorizontalServiceList extends StatefulWidget {
  final bool is24_7;
  final bool isFeatured;
  final String text;

  const HorizontalServiceList({
    super.key,
    this.is24_7 = false,
    this.isFeatured = false,
    required this.text,
  });

  @override
  State<HorizontalServiceList> createState() => _HorizontalServiceListState();
}

class _HorizontalServiceListState extends State<HorizontalServiceList> {
  late final SubcategoryCubit _cubit = sl<SubcategoryCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.fetchSubcategories(
      is24_7: widget.is24_7 ? true : null,
      isFeatured: widget.isFeatured ? true : null,
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.push("/allCategory");
          },
          child: Subtitle(text: widget.text),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 164,
          child: BlocBuilder<SubcategoryCubit, SubcategoryState>(
            bloc: _cubit,
            builder: (context, state) {
              if (state is SubcategoryLoading || state is SubcategoryInitial) {
                return BrandedShimmer(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20),
                    itemCount: 4,
                    itemBuilder: (context, index) => Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BrandedShimmerCard(
                            width: 160,
                            height: 110,
                            borderRadius: 9.46,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 100,
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDF1FB),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              if (state is SubcategoryError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final items = (state as SubcategorySuccess).items;

              if (items.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.homeServiceNotFound),
                );
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _ServiceCard(item: items[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final SubcategoryItem item;

  const _ServiceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final textColor = AppColor.titleText(context);

    return GestureDetector(
      onTap: () {
        context.push("/detail", extra: {"uuid": item.uuid});
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9.46),
              child: Image.network(
                ApiConstants.imageUrl(item.img),
                width: 160,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 160,
                    height: 110,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.name(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
                if (item.ratingCount > 0) ...[
                  const SizedBox(width: 4),
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
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
