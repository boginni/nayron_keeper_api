import 'package:nayron_keeper_api/app/domain/entity/event/player_event.dart';

import '../entity/event/chat_event.dart';
import '../entity/event/event_entity.dart';
import '../entity/event/mob_event.dart';

sealed class EventEntityFactory {
  static EventEntity getInstance(Map<String, dynamic> json) {
    final type = json['eventType'];

    final EventType classType = EventType.values.firstWhere((e) => e.name == type);

    switch (classType) {
      case EventType.player_event:
        return PlayerEventFactory.getInstance(json);
      case EventType.chat_event:
        return ChatEventFactory.getInstance(json);
      case EventType.mob_event:
        return MobEventFactory.getInstance(json);
    }
  }
}

class MobEventFactory {
  static MobEventModel getInstance(Map<String, dynamic> json) {
    final type = json['type'];

    final MobEventType classType = MobEventType.values.firstWhere((e) => e.name == type);

    return MobEventModel.fromJson(json);
  }
}

class ChatEventFactory {
  static ChatEventModel getInstance(Map<String, dynamic> json) {
    final type = json['type'];

    final ChatEventType classType = ChatEventType.values.firstWhere((e) => e.name == type);

    switch (classType) {
      case ChatEventType.message:
        return MessageChatEventModel.fromJson(json);
      case ChatEventType.typing:
        return TypingChatEventModel.fromJson(json);
      case ChatEventType.log:
        return LogChatEventModel.fromJson(json);
    }
  }
}

sealed class PlayerEventFactory {
  static PlayerEventModel getInstance(Map<String, dynamic> json) {
    final type = json['type'];

    final PlayerEventType classType = PlayerEventType.values.firstWhere((e) => e.name == type);

    switch (classType) {
      case PlayerEventType.join:
        return PlayerJoinEventModel.fromJson(json);
      case PlayerEventType.leave:
        return PlayerLeaveEventModel.fromJson(json);
    }
  }
}
