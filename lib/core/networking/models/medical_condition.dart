class MedicalCondition {
  MedicalCondition({
    this.id,
    this.reservationId,
    this.description,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  MedicalCondition.fromJson(dynamic json) {
    id = json['id'];
    reservationId = json['reservation_id'];
    description = json['description'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? reservationId;
  String? description;
  num? price;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['reservation_id'] = reservationId;
    map['description'] = description;
    map['price'] = price;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
