import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../injector.dart';
import '../../../bloc/rating/submit_rating_cubit.dart';

/// Открывает bottom sheet для оценки услуги (категории или подкатегории).
/// Ровно один из [categoryUuid]/[subcategoryUuid] должен быть передан —
/// как того требует бэкенд.
Future<void> showRateServiceSheet(
  BuildContext context, {
  String? categoryUuid,
  String? subcategoryUuid,
  VoidCallback? onSubmitted,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => BlocProvider(
      create: (_) => sl<SubmitRatingCubit>(),
      child: _RateServiceSheet(
        categoryUuid: categoryUuid,
        subcategoryUuid: subcategoryUuid,
        onSubmitted: onSubmitted,
      ),
    ),
  );
}

class _RateServiceSheet extends StatefulWidget {
  final String? categoryUuid;
  final String? subcategoryUuid;
  final VoidCallback? onSubmitted;

  const _RateServiceSheet({
    this.categoryUuid,
    this.subcategoryUuid,
    this.onSubmitted,
  });

  @override
  State<_RateServiceSheet> createState() => _RateServiceSheetState();
}

class _RateServiceSheetState extends State<_RateServiceSheet> {
  int _stars = 0;

  @override
  Widget build(BuildContext context) {
    final bg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);

    return BlocConsumer<SubmitRatingCubit, SubmitRatingState>(
      listener: (context, state) {
        if (state is SubmitRatingSuccess) {
          widget.onSubmitted?.call();
          Navigator.of(context).pop();
        }
        if (state is SubmitRatingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ýalňyşlyk: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is SubmitRatingLoading;

        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'Baha bermek',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (i) {
                      final starIndex = i + 1;
                      return IconButton(
                        onPressed: () => setState(() => _stars = starIndex),
                        icon: Icon(
                          starIndex <= _stars
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          size: 32,
                          color: const Color(0xFFFBB725),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _stars > 0 && !isLoading
                        ? () => context.read<SubmitRatingCubit>().submit(
                            categoryUuid: widget.categoryUuid,
                            subcategoryUuid: widget.subcategoryUuid,
                            stars: _stars,
                          )
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Ugratmak',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
