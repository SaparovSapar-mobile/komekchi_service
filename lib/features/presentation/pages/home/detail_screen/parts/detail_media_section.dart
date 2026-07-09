part of '../detail_screen.dart';

extension DetailMediaSection on _DetailScreenState {
  Widget _buildMediaSection(
    BuildContext context,
    SubcategoryItem item,
    bool isDark,
    TextStyle textStyle,
    Color bg,
    String warningText,
  ) {
    return Column(
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
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                ),
              ),
            ),
          ),
        ),

        // Category breadcrumb
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppColor.bgPageDark : Color(0xFFF5F5F5),
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
              Icon(Icons.chevron_right, size: 16, color: Colors.grey.shade400),
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
                  style: AppTextStyle.semiBold12.copyWith(
                    color: isDark ? AppColor.titleDark : AppColor.primary,
                  ),
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
            style: AppTextStyle.semiBold20.copyWith(
              color: AppColor.titleText(context),
            ),
          ),
        ),
        const SizedBox(height: 8),

        if (item.is24_7 || item.isFeatured)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                if (item.is24_7) DetailBadge(text: "7/24"),
                if (item.is24_7 && item.isFeatured) const SizedBox(width: 6),
                if (item.isFeatured) DetailBadge(text: "Öňde baryjy"),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                      style: TextStyle(fontSize: 12, color: Color(0xFFFF6600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 24),
      ],
    );
  }
}
