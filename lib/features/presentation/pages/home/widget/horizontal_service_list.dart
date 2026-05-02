import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';

class HorizontalServiceList extends StatelessWidget {
  final bool inAksiya;
  final String text;

  const HorizontalServiceList({
    super.key,
    required this.inAksiya,
    required this.text,
  });

  final List<ServiceCardItem> items = const [
    ServiceCardItem(
      title: 'Elektrikçi',
      rating: 4.7,
      image: 'assets/images/service/image_1.png',
    ),
    ServiceCardItem(
      title: 'Arassaçylyk',
      rating: 4.7,
      image: 'assets/images/service/image_2.png',
    ),
    ServiceCardItem(
      title: 'Agaç ussa',
      rating: 4.8,
      image: 'assets/images/service/image_3.png',
    ),
    ServiceCardItem(
      title: 'Elektrikçi',
      rating: 4.7,
      image: 'assets/images/service/image_1.png',
    ),
    ServiceCardItem(
      title: 'Arassaçylyk',
      rating: 4.7,
      image: 'assets/images/service/image_2.png',
    ),
    ServiceCardItem(
      title: 'Agaç ussa',
      rating: 4.8,
      image: 'assets/images/service/image_3.png',
    ),
    ServiceCardItem(
      title: 'Agaç ussa',
      rating: 4.8,
      image: 'assets/images/service/image_4.png',
    ),
    ServiceCardItem(
      title: 'Elektrikçi',
      rating: 4.7,
      image: 'assets/images/service/image_5.png',
    ),
    ServiceCardItem(
      title: 'Arassaçylyk',
      rating: 4.7,
      image: 'assets/images/service/image_4.png',
    ),
    ServiceCardItem(
      title: 'Agaç ussa',
      rating: 4.8,
      image: 'assets/images/service/image_5.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            text == "Aksiýalar"
                ? context.push("/aksiya")
                : context.push("/categoryId", extra: text);
          },
          child: Subtitle(text: text),
        ),
        SizedBox(height: 5),
        if (!inAksiya)
          SizedBox(
            height: 164,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemCount: 6,
              itemBuilder: (context, index) {
                return _ServiceCard(
                  item: items[index],
                  inAksiya: inAksiya,
                  text: text,
                );
              },
            ),
          ),
        if (inAksiya)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemCount: items.length - 6,
              itemBuilder: (context, index) {
                return _ServiceCard(
                  item: items[index + 6],
                  inAksiya: inAksiya,
                  text: text,
                );
              },
            ),
          ),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ServiceCardItem item;
  final String text;
  final bool inAksiya;

  const _ServiceCard({
    required this.item,
    required this.inAksiya,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          "/detail",
          extra: {"title": text, "image": item.image, "titleImage": item.title},
        );
      },
      child: Container(
        width: inAksiya ? 174 : 160,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartinka
            ClipRRect(
              borderRadius: BorderRadius.circular(9.46),
              child: Image.asset(
                item.image,
                width: inAksiya ? 174 : 160,
                height: inAksiya ? 106 : 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: inAksiya ? 174 : 160,
                    height: inAksiya ? 106 : 110,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),
            if (!inAksiya) const SizedBox(height: 8),

            // Nazvanie + reiting
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!inAksiya)
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                Row(
                  children: [
                    if (!inAksiya)
                      Text(
                        item.rating.toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    const SizedBox(width: 3),
                    if (!inAksiya)
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCardItem {
  final String title;
  final double rating;
  final String image;

  const ServiceCardItem({
    required this.title,
    required this.rating,
    required this.image,
  });
}
