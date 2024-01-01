enum EventType {
  player_event,
  mob_event,
  chat_event,
}

abstract class EventEntity {
  const EventEntity({
    required this.eventType,
    required String userId,
  }) : _userId = userId;

  final EventType eventType;
  final String? _userId;

  bool get isUserEvent => _userId != null;

  String get userId => _userId!;

  Map<String, dynamic> toJson() {
    return {
      'eventType': eventType.toString(),
      'userId': userId,
    };
  }
}
