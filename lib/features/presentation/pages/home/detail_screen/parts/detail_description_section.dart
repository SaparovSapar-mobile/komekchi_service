part of '../detail_screen.dart';

extension DetailDescriptionSection on _DetailScreenState {
  Widget _buildDescriptionSection(BuildContext context, SubcategoryItem item) {
    final t = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          child: Text(
            t.aboutTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                TextSpan(text: item.desc(context)),
                if (item.paymentMethod.consultation)
                  TextSpan(
                    text: isExpanded ? t.consultationNote : '',
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
