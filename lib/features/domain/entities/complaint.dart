class ComplaintItem {
  final String uuid;
  final String clientUuid;
  final String message;
  final String createdAt;

  const ComplaintItem({
    required this.uuid,
    required this.clientUuid,
    required this.message,
    required this.createdAt,
  });
}
