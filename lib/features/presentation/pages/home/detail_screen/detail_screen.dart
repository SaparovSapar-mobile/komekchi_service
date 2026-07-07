import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/app_constants.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/core/utils/theme/const.dart';
import 'package:komekchi_service/features/domain/entities/subcategory.dart';
import 'package:komekchi_service/features/presentation/bloc/subcategory/subcategory_detail_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/detail_screen/issue/nagilelik_bottomsheet.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import 'map.dart';
import 'price_item.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSalgyBottomSheet(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubcategoryDetailCubit, SubcategoryDetailState>(
      builder: (context, state) {
        if (state is SubcategoryDetailLoading || state is SubcategoryDetailInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is SubcategoryDetailError) {
          return Scaffold(
            body: Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red)),
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
    final price = item.paymentMethod.price;
    final salePercent = item.paymentMethod.sale;
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const SizedBox(height: 49),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 15),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.nameTm,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.semiBold16.copyWith(
                        color: AppColor.titleText(context),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => showNagilelikBottomSheet(context),
                    icon: Icon(
                      Icons.more_vert,
                      color: AppColor.titleText(context),
                    ),
                  ),
                ],
              ),
            ),
            DividerWidget(),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kartinka
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            ApiConstants.imageUrl(item.img),
                            width: 350,
                            height: 184,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 350,
                              height: 184,
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Category breadcrumb
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColor.bgPageDark
                                  : Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: Text(
                                item.categoryName,
                                style: textStyle.copyWith(
                                  color: AppColor.descriptionText(context),
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 16,
                            color: Colors.grey.shade400,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isDark ? AppColor.bgPageDark : Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.nameTm,
                              style: AppTextStyle.semiBold12.copyWith(color: isDark ? AppColor.titleDark : AppColor.primary),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        item.nameTm,
                        style: AppTextStyle.semiBold20.copyWith(color: AppColor.titleText(context)),
                      ),
                    ),
                    const SizedBox(height: 8),

                    if (item.is24_7 || item.isFeatured)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            if (item.is24_7)
                              _Badge(text: "7/24"),
                            if (item.is24_7 && item.isFeatured)
                              const SizedBox(width: 6),
                            if (item.isFeatured)
                              _Badge(text: "Öňde baryjy"),
                          ],
                        ),
                      ),
                    const SizedBox(height: 10),

                    // Warning / info banner
                    if (warningText.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/icon/image1.png",
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  warningText,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFFF6600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),

                    // Bahasy + counter
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: bg,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bahasy',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.titleText(context),
                                ),
                              ),
                              Text(
                                '$price tmt',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.primary,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Counter
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (quantity > 1) {
                                    setState(() => quantity--);
                                  }
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: bg,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: const Icon(Icons.remove, size: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                ),
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() => quantity++);
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColor.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Barada (description)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 6,
                      ),
                      child: Text(
                        'Barada',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColor.titleText(context),
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(text: item.descTm),
                            if (item.paymentMethod.consultation)
                              TextSpan(
                                text: isExpanded
                                    ? ' Maslahat bermek hyzmaty hem elýeterlidir.'
                                    : '',
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action buttons: Call, Chat, Map, Share
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/details/image1.png",
                                height: 60,
                                width: 60,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Jaň etmek",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.titleText(context),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/details/image2.png",
                                height: 60,
                                width: 60,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "SMS",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.titleText(context),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/details/image3.png",
                                height: 60,
                                width: 60,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Karta",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.titleText(context),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/details/image4.png",
                                height: 60,
                                width: 60,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Paýlaşmak",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.titleText(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Price breakdown
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: bg,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PriceRow(
                              label: 'Hyzmat bahasy:',
                              value: '$price TMT',
                            ),
                            const SizedBox(height: 8),
                            PriceRow(
                              label: 'Arzanladyş:',
                              value: '$salePercent%',
                            ),
                            if (item.paymentMethod.consultation) ...[
                              const SizedBox(height: 8),
                              PriceRow(
                                label: 'Maslahat bermek:',
                                value: '${item.paymentMethod.forPersonPrice} man',
                              ),
                            ],
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.32,
                                  height: 53,
                                  padding: const EdgeInsets.only(
                                    left: 14.0,
                                    top: 4,
                                    bottom: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F8FD),
                                    border: Border.all(color: Color(0xFFC6D2FF)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Jemi:",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "${price * quantity} tmt",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFFF5050),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.push("/date");
                                    },
                                    child: Container(
                                      height: 53,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.primary,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "Tassyklamak",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(width: 4.5),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: 23,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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

class _Badge extends StatelessWidget {
  final String text;
  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColor.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColor.primary,
        ),
      ),
    );
  }
}
