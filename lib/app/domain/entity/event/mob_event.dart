import 'package:nayron_keeper_api/app/domain/entity/mob/base_mob_entity.dart';

import '../../factory/mob_entity_factory.dart';
import 'event_entity.dart';

enum MobEventType {
  create,
  update,
  get,
}

class MobEventModel extends EventEntity {
  const MobEventModel({
    required super.userId,
    required this.entityEventType,
    required this.mob,
  }) : super(eventType: EventType.mob_event);

  factory MobEventModel.fromJson(Map<String, dynamic> json) {
    return MobEventModel(
      userId: json['userId'],
      entityEventType: json['entityEventType'],
      mob: MobEntityFactory.getInstance(json['mob']),
    );
  }

  final MobEventType entityEventType;
  final MobEntity mob;

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll({
        'entityEventType': entityEventType.name,
        'mob': mob.toJson(),
      });
  }
}
