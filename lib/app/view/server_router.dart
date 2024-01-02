import 'dart:io';

import 'package:nayron_keeper_api/app/view/services/authentication_service.dart';
import 'package:nayron_keeper_api/app/view/services/connection_service.dart';

class ServerRouter {
  const ServerRouter({
    required this.connectionController,
    required this.authenticationController,
  });

  final ConnectionService connectionController;
  final AuthenticationService authenticationController;

  void start() async {
    final server = await HttpServer.bind('127.0.0.1', 4040);

    print('Listening on localhost:${server.port}');

    await for (HttpRequest req in server) {
      switch (req.uri.path) {
        case '/ws':
          connectionController.handleNewConnection(req);
          break;
        case '/sign-in':
          await authenticationController.signIn(req);
          break;
        case '/sign-up':
          await authenticationController.signUp(req);
          break;
        case '/sign-out':
          await authenticationController.signOut(req);
          break;
        default:
          req.response.statusCode = HttpStatus.notFound;
          req.response.write('Not found');
          await req.response.close();
      }
    }
  }
}
