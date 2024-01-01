import '../entity/mob/base_mob_entity.dart';

sealed class MobEntityFactory {
  static MobEntity getInstance(Map<String, dynamic> json) {
    final type = json['type'];

    final MobEntityType classType = MobEntityType.values.firstWhere((e) => e.name == type);

    throw UnimplementedError();

    // switch (classType) {
    //   case MobEntityType.entity:
    //     return MobEntity.fromJson(json);
    //   case MobEntityType.player:
    //     return PlayerEntity.fromJson(json);
    // }
  }
}
