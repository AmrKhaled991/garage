class Title {
  String? ar;
  dynamic en;

  Title({this.ar, this.en});

  factory Title.fromJson(Map<String, dynamic> json) =>
      Title(ar: json['ar'] as String?, en: json['en'] as dynamic);

  Map<String, dynamic> toJson() => {'ar': ar, 'en': en};
}
