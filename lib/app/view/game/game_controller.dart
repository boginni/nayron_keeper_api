import 'dart:async';

import 'package:nayron_keeper_api/app/domain/entity/event/event_entity.dart';
import 'package:nayron_keeper_api/app/view/world/world_controller.dart';

import '../../domain/repository/event_repository.dart';
import '../../domain/repository/user_repository.dart';

class GameController {
  GameController({
    required this.eventRepository,
    required this.userRepository,
  });

  final EventRepository eventRepository;
  final UserRepository userRepository;

  void start() {
    print('starting');

    final WorldController worldController = WorldController(
      userRepository: userRepository,
    );

    const tps = 20;
    const msPerTick = 1000 ~/ tps;

    final tick =
        Timer.periodic(const Duration(milliseconds: msPerTick), (timer) {
      worldController.tick();
      worldController.broadcastEvents();
    });

    eventRepository.listenEvents().listen(onEvent);
  }

  void onEvent(EventEntity event) {
    print('onEvent: $event');
  }
}
