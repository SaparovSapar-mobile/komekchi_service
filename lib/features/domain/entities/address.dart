class AddressItem {
  final String uuid;
  final String address;
  final String addressTypeUuid;
  final String addressTypeName;
  final String clientUuid;
  final String createdAt;
  final String updatedAt;

  const AddressItem({
    required this.uuid,
    required this.address,
    required this.addressTypeUuid,
    required this.addressTypeName,
    required this.clientUuid,
    required this.createdAt,
    required this.updatedAt,
  });
}
