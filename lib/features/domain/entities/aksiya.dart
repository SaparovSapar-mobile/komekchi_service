class AksiyaItem {
  final String uuid;
  final String name;
  final String url;
  final String imgTm;
  final String imgRu;
  final String imgEn;
  final String durationStart;
  final String durationEnd;
  final String hourStart;
  final String hourEnd;
  final int orderNumber;
  final String createdAt;
  final String updatedAt;

  const AksiyaItem({
    required this.uuid,
    required this.name,
    required this.url,
    required this.imgTm,
    required this.imgRu,
    required this.imgEn,
    required this.durationStart,
    required this.durationEnd,
    required this.hourStart,
    required this.hourEnd,
    required this.orderNumber,
    required this.createdAt,
    required this.updatedAt,
  });
}
