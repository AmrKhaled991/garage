class File {
  int? id;
  String? name;
  String? fileName;
  String? mimeType;
  int? size;
  String? humanReadableSize;
  String? url;
  String? createdAt;

  File({
    this.id,
    this.name,
    this.fileName,
    this.mimeType,
    this.size,
    this.humanReadableSize,
    this.url,
    this.createdAt,
  });

  factory File.fromJson(Map<String, dynamic> json) => File(
    id: json['id'] as int?,
    name: json['name'] as String?,
    fileName: json['file_name'] as String?,
    mimeType: json['mime_type'] as String?,
    size: json['size'] as int?,
    humanReadableSize: json['human_readable_size'] as String?,
    url: json['url'] as String?,
    createdAt: json['created_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'file_name': fileName,
    'mime_type': mimeType,
    'size': size,
    'human_readable_size': humanReadableSize,
    'url': url,
    'created_at': createdAt,
  };
}
