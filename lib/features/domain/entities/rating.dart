class RatingItem {
  final String uuid;
  final String categoryUuid;
  final String subcategoryUuid;
  final String clientUuid;
  final String comment;
  final int stars;
  final String createdAt;

  const RatingItem({
    required this.uuid,
    required this.categoryUuid,
    required this.subcategoryUuid,
    required this.clientUuid,
    required this.comment,
    required this.stars,
    required this.createdAt,
  });
}
