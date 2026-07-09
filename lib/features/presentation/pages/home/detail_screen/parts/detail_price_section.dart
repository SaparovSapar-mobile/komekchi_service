part of '../detail_screen.dart';

extension DetailPriceSection on _DetailScreenState {
  Widget _buildPriceCounterSection(
    BuildContext context,
    SubcategoryItem item,
    Color bg,
  ) {
    final price = item.paymentMethod.price;

    return Container(
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
                style: TextStyle(fontSize: 14, color: AppColor.titleText(context)),
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
                    _refresh(() => quantity--);
                  }
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300, width: 0.5),
                  ),
                  child: const Icon(Icons.remove, size: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
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
                  _refresh(() => quantity++);
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdownSection(
    BuildContext context,
    SubcategoryItem item,
    double screenWidth,
    Color bg,
  ) {
    final price = item.paymentMethod.price;
    final salePercent = item.paymentMethod.sale;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bg,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PriceRow(label: 'Hyzmat bahasy:', value: '$price TMT'),
            const SizedBox(height: 8),
            PriceRow(label: 'Arzanladyş:', value: '$salePercent%'),
            if (item.paymentMethod.consultation) ...[
              const SizedBox(height: 8),
              PriceRow(
                label: 'Maslahat bermek:',
                value: '${item.paymentMethod.forPersonPrice} tmt',
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: screenWidth * 0.32,
                  height: 53,
                  padding: const EdgeInsets.only(left: 14.0, top: 4, bottom: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F8FD),
                    border: Border.all(color: Color(0xFFC6D2FF)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jemi:",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${price * quantity} tmt",
                        style: TextStyle(fontSize: 16, color: Color(0xFFFF5050)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.push(
                        "/date",
                        extra: {
                          'subcategoryUuid': widget.uuid,
                          'quantity': quantity,
                        },
                      );
                    },
                    child: Container(
                      height: 53,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.primary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Tassyklamak",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4.5),
                          Icon(Icons.arrow_forward, size: 23, color: Colors.white),
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
    );
  }
}
