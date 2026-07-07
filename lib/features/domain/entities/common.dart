class PaymentMethod {
  final bool consultation;
  final num price;
  final num forPersonPrice;
  final num sale;

  const PaymentMethod({
    required this.consultation,
    required this.price,
    required this.forPersonPrice,
    required this.sale,
  });
}

class WarningDesc {
  final String descTm;
  final String descRu;
  final String descEn;

  const WarningDesc({
    required this.descTm,
    required this.descRu,
    required this.descEn,
  });
}

class PaginationInfo {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const PaginationInfo({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });
}

class PaginatedResult<T> {
  final List<T> items;
  final PaginationInfo pagination;

  const PaginatedResult({required this.items, required this.pagination});
}
