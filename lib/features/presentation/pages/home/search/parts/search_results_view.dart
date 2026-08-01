import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/core/utils/localized_field.dart';
import 'package:komekchi_service/features/presentation/bloc/search/search_cubit.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import '../../../../../../core/widgets/network_error_view.dart';
import 'subcategory_result_card.dart';

/// API search results (sorag ýazylan wagty)
class SearchResultsView extends StatelessWidget {
  final String query;
  final ValueChanged<String> onAddToHistory;

  const SearchResultsView({
    super.key,
    required this.query,
    required this.onAddToHistory,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SearchError) {
          return NetworkErrorView.fromFailure(
            state.failure,
            onRetry: () => context.read<SearchCubit>().search(query),
          );
        }

        if (state is SearchSuccess) {
          final result = state.result;

          if (result.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search_off, size: 48, color: Colors.grey.shade300),
                  const SizedBox(height: 12),
                  Text(
                    'Netije tapylmady',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              if (result.categories.isNotEmpty) ...[
                _SearchSectionTitle('Kategoriýalar'),
                ...result.categories.map(
                  (category) => Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            ApiConstants.imageUrl(category.iconImg),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.category,
                              color: AppColor.primary,
                              size: 28,
                            ),
                          ),
                        ),
                        title: Text(
                          category.name(context),
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColor.titleText(context),
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () {
                          onAddToHistory(query);
                          context.push(
                            "/categoryId",
                            extra: {
                              'uuid': category.uuid,
                              'title': category.name(context),
                            },
                          );
                        },
                      ),
                      Divider(height: 1, color: Colors.grey.shade100),
                    ],
                  ),
                ),
              ],
              if (result.subcategories.isNotEmpty) ...[
                _SearchSectionTitle('Subkategoriýalar'),
                ...result.subcategories.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SubcategoryResultCard(
                      item: item,
                      onTap: () {
                        onAddToHistory(query);
                        context.push("/detail", extra: {"uuid": item.uuid});
                      },
                    ),
                  ),
                ),
              ],
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _SearchSectionTitle extends StatelessWidget {
  final String title;

  const _SearchSectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColor.descriptionText(context),
        ),
      ),
    );
  }
}
