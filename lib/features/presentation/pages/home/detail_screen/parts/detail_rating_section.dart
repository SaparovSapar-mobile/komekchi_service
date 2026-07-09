part of '../detail_screen.dart';

extension DetailRatingSection on _DetailScreenState {
  Widget _buildRatingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bahalar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () => showRateServiceSheet(
                  context,
                  subcategoryUuid: widget.uuid,
                  onSubmitted: () =>
                      _ratingCubit.fetchRatings(subcategoryUuid: widget.uuid),
                ),
                child: const Text(
                  'Baha bermek',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<RatingCubit, RatingState>(
          bloc: _ratingCubit,
          builder: (context, state) {
            if (state is RatingLoading || state is RatingInitial) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is RatingError) {
              return SizedBox(
                height: 220,
                child: NetworkErrorView.fromFailure(
                  state.failure,
                  onRetry: () =>
                      _ratingCubit.fetchRatings(subcategoryUuid: widget.uuid),
                ),
              );
            }

            final ratings = (state as RatingSuccess).items;

            if (ratings.isEmpty) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: ratings.map((r) => _RatingCard(item: r)).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _RatingCard extends StatelessWidget {
  final RatingItem item;
  const _RatingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final textColor = AppColor.titleText(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(5, (i) {
              return Icon(
                i < item.stars ? Icons.star_rounded : Icons.star_border_rounded,
                size: 18,
                color: const Color(0xFFFBB725),
              );
            }),
          ),
          if (item.comment.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              item.comment,
              style: TextStyle(fontSize: 13, color: textColor),
            ),
          ],
        ],
      ),
    );
  }
}
