class MessageModel {
  final String content;
  final MessageType type;
  final bool isUser;

  MessageModel({required this.content, required this.type, this.isUser = true});
}

enum MessageType { text, image }
