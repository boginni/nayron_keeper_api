import 'dart:io';

import 'package:nayron_keeper_api/app/view/authentication/auth_controller.dart';
import 'package:nayron_keeper_api/app/view/connection_controller.dart';

class ServerRouter {
  ServerRouter({
    required this.connectionController,
    required this.authenticationController,
  });

  final ConnectionController connectionController;
  final AuthenticationController authenticationController;

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
