import 'event_entity.dart';

enum PlayerEventType {
  join,
  leave,
}

abstract class PlayerEventModel extends EventEntity {
  const PlayerEventModel({
    required super.userId,
    required this.playerId,
    required this.playerEventType,
  }) : super(eventType: EventType.player_event);

  final String playerId;
  final PlayerEventType playerEventType;

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        'playerId': playerId,
        'playerEventType': playerEventType.toString(),
      });
  }
}

class PlayerJoinEventModel extends PlayerEventModel {
  const PlayerJoinEventModel({
    required super.userId,
    required super.playerId,
    required this.playerName,
  }) : super(playerEventType: PlayerEventType.join);

  factory PlayerJoinEventModel.fromJson(Map<String, dynamic> json) {
    return PlayerJoinEventModel(
      userId: json['userId'],
      playerId: json['playerId'],
      playerName: json['playerName'],
    );
  }

  final String playerName;

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        'playerName': playerName,
      });
  }
}

class PlayerLeaveEventModel extends PlayerEventModel {
  const PlayerLeaveEventModel({
    required String userId,
    required String playerId,
  }) : super(
          userId: userId,
          playerId: playerId,
          playerEventType: PlayerEventType.leave,
        );

  factory PlayerLeaveEventModel.fromJson(Map<String, dynamic> json) {
    return PlayerLeaveEventModel(
      userId: json['userId'],
      playerId: json['playerId'],
    );
  }
}
