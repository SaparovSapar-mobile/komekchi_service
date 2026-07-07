import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BizItem {
  final String image;

  BizItem({required this.image});
}

final List<BizItem> defaultBizItems = [
  BizItem(image: 'assets/images/bizbarada/image1.png'),
  BizItem(image: 'assets/images/bizbarada/image2.png'),
  BizItem(image: 'assets/images/bizbarada/image3.png'),
  BizItem(image: 'assets/images/bizbarada/image4.png'),
  BizItem(image: 'assets/images/bizbarada/image5.png'),
  BizItem(image: 'assets/images/bizbarada/image6.png'),
];

class HomeBizGrid extends StatelessWidget {
  final List<BizItem> biz;
  const HomeBizGrid({super.key, required this.biz});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      itemCount: biz.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 80,
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              item.image,
              width: 110,
              height: 80,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
