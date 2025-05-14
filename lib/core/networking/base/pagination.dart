class Pagination {
  Pagination({
      this.totalItems, 
      this.countItems, 
      this.perPage, 
      this.totalPages, 
      this.currentPage,});

  Pagination.fromJson(dynamic json) {
    totalItems = json['total_items'];
    countItems = json['count_items'];
    perPage = json['per_page'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
  }
  num? totalItems;
  num? countItems;
  num? perPage;
  num? totalPages;
  num? currentPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_items'] = totalItems;
    map['count_items'] = countItems;
    map['per_page'] = perPage;
    map['total_pages'] = totalPages;
    map['current_page'] = currentPage;
    return map;
  }

}