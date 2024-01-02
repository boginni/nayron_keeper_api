import 'package:nayron_keeper_api/app/domain/repository/authentication_repository.dart';
import 'package:nayron_keeper_api/app/domain/repository/event_repository.dart';
import 'package:nayron_keeper_api/app/domain/repository/user_repository.dart';
import 'package:nayron_keeper_api/app/view/connection_controller.dart';
import 'package:nayron_keeper_api/app/view/game/game_controller.dart';
import 'package:nayron_keeper_api/app/view/ws.dart';
import 'package:uuid/uuid.dart';

import '../test/harness/app.dart';

void main() async {
  final eventRepository = EventRepository();
  final userRepository = UserRepository();

  const generator = Uuid();

  final authenticationRepository = AuthenticationRepository(
    generator: generator,
    jwtSecret: generator.v4(),
  );

  final connectionController = ConnectionController()

  final authenticationController = AuthController(
    authenticationRepository: authenticationRepository,
    userRepository: userRepository,
  );

  final gameController = GameController(
    eventRepository: eventRepository,
    userRepository: userRepository,
  );

  //

  final server = ServerRouter(
    connectionController: connectionController,
  );
  gameController.start();
  server.start();
}
