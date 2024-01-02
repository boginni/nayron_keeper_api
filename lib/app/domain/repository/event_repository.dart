import 'dart:async';

import 'package:nayron_keeper_api/app/domain/entity/event/event_entity.dart';

import '../factory/event_entity_factory.dart';

class EventRepository {
  EventRepository();

  final _inputEventController = StreamController<EventEntity>();

  void receiveMessage(String rawMessage, String userId) {
    final event = EventEntityFactory.parseMessage(rawMessage, userId);
    addEvent(event);
  }

  void addEvent(EventEntity message) {
    _inputEventController.add(message);
  }

  Stream<EventEntity> listenEvents() {
    return _inputEventController.stream;
  }

  void dispose() {
    _inputEventController.close();
  }
}
