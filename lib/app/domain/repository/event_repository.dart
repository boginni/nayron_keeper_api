import 'dart:async';
import 'dart:convert';

import 'package:nayron_keeper_api/app/domain/entity/event/event_entity.dart';

import '../factory/event_entity_factory.dart';

class EventRepository {
  final _messageController = StreamController<EventEntity>();

  void receiveMessage(String rawMessage, String userId) {
    final event = _parseMessage(rawMessage, userId);
    _messageController.add(event);
  }

  Stream<EventEntity> getMessages() {
    return _messageController.stream;
  }

  EventEntity _parseMessage(String rawMessage, String userId) {
    final Map<String, dynamic> json = jsonDecode(rawMessage);
    json['userId'] = userId;
    return EventEntityFactory.getInstance(json);
  }

  void dispose() {
    _messageController.close();
  }
}
