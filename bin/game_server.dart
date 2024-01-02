import 'package:nayron_keeper_api/app/domain/repository/authentication_repository.dart';
import 'package:nayron_keeper_api/app/domain/repository/event_repository.dart';
import 'package:nayron_keeper_api/app/domain/repository/user_repository.dart';
import 'package:nayron_keeper_api/app/view/controllers/game_controller.dart';
import 'package:nayron_keeper_api/app/view/server_router.dart';
import 'package:nayron_keeper_api/app/view/services/authentication_service.dart';
import 'package:nayron_keeper_api/app/view/services/connection_service.dart';
import 'package:uuid/uuid.dart';

void main() async {
  final eventRepository = EventRepository();
  final userRepository = UserRepository();

  const generator = Uuid();

  final authenticationRepository = AuthenticationRepository(
    generator: generator,
    jwtSecret: generator.v4(),
  );

  final connectionController = ConnectionService(
    userRepository: userRepository,
    eventRepository: eventRepository,
    authenticationRepository: authenticationRepository,
  );

  final authenticationController = AuthenticationService(
    authRepository: authenticationRepository,
  );

  final gameController = GameController(
    eventRepository: eventRepository,
    userRepository: userRepository,
  );

  //

  final server = ServerRouter(
    connectionController: connectionController,
    authenticationController: authenticationController,
  );

  server.start();

  await Future.delayed(const Duration(seconds: 1), gameController.start);
}
