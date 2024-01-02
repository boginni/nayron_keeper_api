import 'dart:async';

import 'package:nayron_keeper_api/app/domain/entity/event/event_entity.dart';
import 'package:nayron_keeper_api/app/view/controllers/world_controller.dart';

import '../../domain/repository/event_repository.dart';
import '../../domain/repository/user_repository.dart';

final worlds = <String, WorldController>{};

class GameController {
  const GameController({
    required this.eventRepository,
    required this.userRepository,
  });

  final EventRepository eventRepository;
  final UserRepository userRepository;

  void start() {
    print('Game Server Starting');

    final WorldController worldController = WorldController(
      userRepository: userRepository,
    );

    const tps = 20;
    const msPerTick = 1000 ~/ tps;

    Timer.periodic(const Duration(milliseconds: msPerTick), (timer) {
      tick();
    });

    eventRepository.listenEvents().listen(onEvent);
  }

  void tick() {
    worlds.forEach((key, value) {
      value.tick();
      value.broadcastEvents();
    });
  }

  void onEvent(EventEntity event) {
    print('onEvent: $event');
  }
}
