import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/core/utils/localized_field.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/features/domain/entities/category.dart';
import 'package:komekchi_service/features/presentation/bloc/category/get_category_cubit.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import '../../../../../../core/widgets/network_error_view.dart';

/// Category browse (klaviatura ýapyk, sorag ýok wagty)
class SearchCategoryBrowse extends StatelessWidget {
  const SearchCategoryBrowse({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = AppTextStyle.medium12;
    final bg = AppColor.pageBg(context);

    return BlocBuilder<GetCategoryCubit, GetCategoryState>(
      builder: (context, state) {
        if (state is GetCategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetCategoryError) {
          return NetworkErrorView.fromFailure(
            state.failure,
            onRetry: () => context.read<GetCategoryCubit>().fetchCategory(),
          );
        }

        final List<CategoryItem> items = state is GetCategorySucces
            ? state.dataCategory
            : const [];

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(
                  context,
                ).padding.bottom.clamp(0.0, double.infinity),
              ),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Ähli kategoriýalar',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(items.length, (index) {
                    final item = items[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Image.network(
                          ApiConstants.imageUrl(item.iconImg),
                          width: 28,
                          height: 28,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.category,
                            color: AppColor.primary,
                            size: 28,
                          ),
                        ),
                      ),
                      title: Text(
                        item.name(context),
                        style: textStyle.copyWith(
                          color: AppColor.titleText(context),
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey.shade400,
                      ),
                      onTap: () {
                        context.push(
                          "/categoryId",
                          extra: {'uuid': item.uuid, 'title': item.name(context)},
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
