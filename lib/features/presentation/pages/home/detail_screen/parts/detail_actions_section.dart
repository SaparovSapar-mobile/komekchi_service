part of '../detail_screen.dart';

extension DetailActionsSection on _DetailScreenState {
  Widget _buildActionButtonsSection(BuildContext context, SubcategoryItem item) {
    final t = AppLocalizations.of(context)!;
    final bg = AppColor.pageBg(context);
    // final cardBg = AppColor.cardBg(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: _callSupport,
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.call, size: 24,),
                ),
                const SizedBox(height: 4),
                Text(
                  t.detailCall,
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
              Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.email, size: 24,),
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
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.room, size: 24,),
                ),
                const SizedBox(height: 4),
                Text(
                  t.detailMap,
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
            onTap: () => _shareItem(context, item),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.share, size: 24,),
                ),
                const SizedBox(height: 4),
                Text(
                  t.detailShare,
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
