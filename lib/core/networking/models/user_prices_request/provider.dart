class Provider {
  int? id;
  String? name;
  String? email;
  String? countryCode;
  String? phone;
  String? fullPhone;
  String? image;
  String? lang;
  bool? isNotify;
  String? token;

  Provider({
    this.id,
    this.name,
    this.email,
    this.countryCode,
    this.phone,
    this.fullPhone,
    this.image,
    this.lang,
    this.isNotify,
    this.token,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    id: json['id'] as int?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    countryCode: json['country_code'] as String?,
    phone: json['phone'] as String?,
    fullPhone: json['full_phone'] as String?,
    image: json['image'] as String?,
    lang: json['lang'] as String?,
    isNotify: json['is_notify'] as bool?,
    token: json['token'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'country_code': countryCode,
    'phone': phone,
    'full_phone': fullPhone,
    'image': image,
    'lang': lang,
    'is_notify': isNotify,
    'token': token,
  };
}
