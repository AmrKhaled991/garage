class Body {
  String? ar;
  dynamic en;

  Body({this.ar, this.en});

  factory Body.fromJson(Map<String, dynamic> json) =>
      Body(ar: json['ar'] as String?, en: json['en'] as dynamic);

  Map<String, dynamic> toJson() => {'ar': ar, 'en': en};
}
