import 'dart:io';

import 'package:nayron_keeper_api/app/view/services/authentication_service.dart';
import 'package:nayron_keeper_api/app/view/services/connection_service.dart';

class Router {
  Router({
    required this.connectionController,
    required this.authenticationController,
  });

  final ConnectionService connectionController;
  final AuthenticationService authenticationController;

  Future<void> handleNewConnection(HttpRequest req) async {
    switch (req.uri.path) {
      case '/ws':
        await connectionController.handleNewConnection(req);
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
      case '/current-user':
        await authenticationController.getCurrentUser(req);
        break;
      default:
        req.response.statusCode = HttpStatus.notFound;
        req.response.write('Not found');
        await req.response.close();
    }
  }
}
