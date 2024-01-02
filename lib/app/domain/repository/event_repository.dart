import 'dart:async';
import 'dart:convert';

import 'package:nayron_keeper_api/app/domain/entity/event/event_entity.dart';
import 'package:nayron_keeper_api/app/domain/entity/user_entity.dart';

import '../factory/event_entity_factory.dart';

class EventRepository {
  final inputEventController = StreamController<EventEntity>();

  void receiveMessage(String rawMessage, String userId) {
    final event = EventEntityFactory.parseMessage(rawMessage, userId);
    addEvent(event);
  }

  void addEvent(EventEntity message) {
    inputEventController.add(message);
  }

  Stream<EventEntity> listenEvents() {
    return inputEventController.stream;
  }

  void dispose() {
    inputEventController.close();
  }
}

class OutputRepository {
  final outputEventController = StreamController<EventEntity>();

  void addMessage(EventEntity message) {
    outputEventController.add(message);
  }

  Stream<EventEntity> getOutputEvents() {
    return outputEventController.stream;
  }

  void dispose() {
    outputEventController.close();
  }
}
