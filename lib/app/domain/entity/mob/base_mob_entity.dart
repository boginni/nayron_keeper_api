enum MobEntityType {
  player,
  entity,
}

abstract class MobEntity {
  const MobEntity({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.scale,
  });

  final String id;
  final MobEntityType type;
  final num x, y;
  final num scale;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'x': x,
      'y': y,
      'scale': scale,
    };
  }
}
