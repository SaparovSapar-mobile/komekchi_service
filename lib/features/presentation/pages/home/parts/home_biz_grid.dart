import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../l10n/gen/app_localizations.dart';

class BizItem {
  final Icon icon;
  final String title;

  BizItem({required this.icon, required this.title});
}

List<BizItem> defaultBizItems(AppLocalizations t) => [
  BizItem(
    icon: Icon(Icons.engineering, color: AppColor.primary, size: 34),
    title: t.biz247Support,
  ),
  BizItem(
    icon: Icon(Icons.date_range, color: AppColor.primary, size: 34),
    title: t.bizWorkSchedule,
  ),
  BizItem(
    icon: Icon(Icons.check_circle, color: AppColor.primary, size: 34),
    title: t.bizWorkGuarantee,
  ),
  BizItem(
    icon: Icon(Icons.perm_phone_msg, color: AppColor.primary, size: 34),
    title: t.bizCustomerService,
  ),
  BizItem(
    icon: Icon(Icons.account_balance_wallet, color: AppColor.primary, size: 34),
    title: t.bizPaymentOptions,
  ),
  BizItem(
    icon: Icon(Icons.stars, color: AppColor.primary, size: 34),
    title: t.bizTrusted,
  ),
];

class HomeBizGrid extends StatelessWidget {
  final List<BizItem> biz;
  const HomeBizGrid({super.key, required this.biz});

  @override
  Widget build(BuildContext context) {
    final bg = AppColor.pageBg(context);
    final textColor = AppColor.titleText(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      itemCount: biz.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 104,
      ),
      itemBuilder: (context, index) {
        final item = biz[index];
        return GestureDetector(
          onTap: () {
            index == 0
                ? context.push("/24goldaw")
                : index == 1
                ? context.push("/istertibi")
                : index == 2
                ? context.push("/kepilligi")
                : index == 3
                ? context.push("/hyzmatlar")
                : index == 4
                ? context.push("/toleg")
                : context.push("/ynamdar");
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF90979F), width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item.icon,
                const SizedBox(height: 6),
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8, 
                    fontWeight: FontWeight.w500,
                    color: textColor,
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
