import 'dart:async';

import 'package:nayron_keeper_api/app/domain/entity/event/mob_event.dart';
import 'package:nayron_keeper_api/app/domain/repository/user_repository.dart';
import '../../domain/entity/user_entity.dart';

class WorldController {

  WorldController({
    required this.userRepository,
  });

  final UserRepository userRepository;

  final users = List<UserEntity>;

  final mobs = [];

  final events = <MobEventModel>[];

  void tick() {
    /// do mobs logic
  }

  void broadcastEvents() {
    events.forEach(userRepository.broadcastEvent);
  }
}
