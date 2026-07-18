import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/core/utils/theme/const.dart';
import 'package:komekchi_service/features/domain/entities/rating.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';
import 'package:komekchi_service/features/presentation/bloc/rating/rating_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/subcategory/subcategory_detail_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/detail_screen/complaint/complaint_bottomsheet.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/rate_service_sheet.dart';
import 'package:komekchi_service/injector.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../core/widgets/network_error_view.dart';
import 'map.dart';
import 'parts/detail_badge.dart';
import 'price_item.dart';

part 'parts/detail_top_bar.dart';
part 'parts/detail_media_section.dart';
part 'parts/detail_price_section.dart';
part 'parts/detail_description_section.dart';
part 'parts/detail_rating_section.dart';
part 'parts/detail_actions_section.dart';

class DetailScreen extends StatefulWidget {
  final String uuid;
  const DetailScreen({super.key, required this.uuid});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  bool isFavorite = false;
  bool isExpanded = false;
  late final RatingCubit _ratingCubit = sl<RatingCubit>();

  @override
  void initState() {
    super.initState();
    _ratingCubit.fetchRatings(subcategoryUuid: widget.uuid);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSalgyBottomSheet(context);
    });
  }

  @override
  void dispose() {
    _ratingCubit.close();
    super.dispose();
  }

  void _shareItem(SubcategoryItem item) {
    final link = WebConstants.detailShareUrl(item.uuid);
    SharePlus.instance.share(ShareParams(text: '${item.nameTm}\n$link'));
  }

  Future<void> _callSupport() async {
    final uri = Uri(scheme: 'tel', path: '+99363509004');
    await launchUrl(uri);
  }

  // setState — protected member, поэтому недоступен напрямую из extension
  // методов в parts/*.dart.
  void _refresh(VoidCallback fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubcategoryDetailCubit, SubcategoryDetailState>(
      builder: (context, state) {
        if (state is SubcategoryDetailLoading ||
            state is SubcategoryDetailInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is SubcategoryDetailError) {
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final item = (state as SubcategoryDetailSuccess).item;
        return _buildContent(context, item);
      },
    );
  }

  Widget _buildContent(BuildContext context, SubcategoryItem item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor = AppColor.titleText(context);
    final TextStyle textStyle = AppTextStyle.semiBold12;
    final warningText = item.warningDesc.descTm;

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
          color: cardBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Header
            AppBarWidget(textColor, isDark),
            DividerWidget(),

            _buildTopBar(context, item),
            DividerWidget(),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMediaSection(
                      context,
                      item,
                      isDark,
                      textStyle,
                      bg,
                      warningText,
                    ),
                    _buildPriceCounterSection(context, item, bg),
                    const SizedBox(height: 24),
                    _buildDescriptionSection(context, item),
                    const SizedBox(height: 24),
                    // _buildRatingsSection(context),
                    // const SizedBox(height: 24),
                    _buildActionButtonsSection(context, item),
                    _buildPriceBreakdownSection(context, item, screenWidth, bg),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
