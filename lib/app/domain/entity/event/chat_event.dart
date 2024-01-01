import 'event_entity.dart';

enum ChatEventType {
  message,
  typing,
  log,
}

abstract class ChatEventModel extends EventEntity {
  const ChatEventModel({
    required super.userId,
    required this.chatEventType,
  }) : super(eventType: EventType.chat_event);

  final ChatEventType chatEventType;

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        'chatEventType': chatEventType.toString(),
      });
  }
}

class MessageChatEventModel extends ChatEventModel {
  const MessageChatEventModel({
    required super.userId,
    required this.message,
    required this.senderName,
  }) : super(chatEventType: ChatEventType.message);

  factory MessageChatEventModel.fromJson(Map<String, dynamic> json) {
    return MessageChatEventModel(
      userId: json['userId'],
      message: json['message'],
      senderName: json['senderName'],
    );
  }

  final String message;
  final String senderName;

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        'message': message,
        'senderName': senderName,
      });
  }
}

class LogChatEventModel extends ChatEventModel {
  const LogChatEventModel({
    required super.userId,
    required this.message,
  }) : super(chatEventType: ChatEventType.log);

  factory LogChatEventModel.fromJson(Map<String, dynamic> json) {
    return LogChatEventModel(
      userId: json['userId'],
      message: json['message'],
    );
  }

  final String message;

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        'message': message,
      });
  }
}

class TypingChatEventModel extends ChatEventModel {
  const TypingChatEventModel({
    required super.userId,
    required this.isTyping,
  }) : super(
          chatEventType: ChatEventType.typing,
        );

  factory TypingChatEventModel.fromJson(Map<String, dynamic> json) {
    return TypingChatEventModel(
      userId: json['userId'],
      isTyping: json['isTyping'],
    );
  }

  final bool isTyping;

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        'isTyping': isTyping,
      });
  }
}
