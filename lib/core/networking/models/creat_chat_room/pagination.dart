class Pagination {
  int? totalItems;
  int? countItems;
  int? perPage;
  int? totalPages;
  int? currentPage;
  String? nextPageUrl;
  String? pervPageUrl;

  Pagination({
    this.totalItems,
    this.countItems,
    this.perPage,
    this.totalPages,
    this.currentPage,
    this.nextPageUrl,
    this.pervPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalItems: json['total_items'] as int?,
    countItems: json['count_items'] as int?,
    perPage: json['per_page'] as int?,
    totalPages: json['total_pages'] as int?,
    currentPage: json['current_page'] as int?,
    nextPageUrl: json['next_page_url'] as String?,
    pervPageUrl: json['perv_page_url'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'total_items': totalItems,
    'count_items': countItems,
    'per_page': perPage,
    'total_pages': totalPages,
    'current_page': currentPage,
    'next_page_url': nextPageUrl,
    'perv_page_url': pervPageUrl,
  };
}
