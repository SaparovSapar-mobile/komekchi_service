part of '../detail_screen.dart';

extension DetailTopBar on _DetailScreenState {
  Widget _buildTopBar(BuildContext context, SubcategoryItem item) {
    return Padding(
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
              item.name(context),
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.semiBold16.copyWith(
                color: AppColor.titleText(context),
              ),
            ),
          ),
          IconButton(
            onPressed: () => showComplaintBottomSheet(context),
            icon: Icon(Icons.more_vert, color: AppColor.titleText(context)),
          ),
        ],
      ),
    );
  }
}
