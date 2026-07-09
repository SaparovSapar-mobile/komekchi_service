part of '../detail_screen.dart';

extension DetailActionsSection on _DetailScreenState {
  Widget _buildActionButtonsSection(BuildContext context, SubcategoryItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: _callSupport,
            child: Column(
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
          GestureDetector(
            onTap: () {
              showSalgyBottomSheet(context);
            },
            child: Column(
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
          ),
          GestureDetector(
            onTap: () => _shareItem(item),
            child: Column(
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
          ),
        ],
      ),
    );
  }
}
