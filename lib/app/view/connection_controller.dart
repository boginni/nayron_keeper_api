import 'dart:io';

import 'package:nayron_keeper_api/app/domain/repository/authentication_repository.dart';
import 'package:nayron_keeper_api/app/domain/repository/event_repository.dart';
import 'package:nayron_keeper_api/app/domain/repository/user_repository.dart';
import 'package:web_socket_channel/io.dart';

final channels = <String, IOWebSocketChannel>{};

class ConnectionController {
  const ConnectionController({
    required this.userRepository,
    required this.eventRepository,
    required this.authenticationRepository,
  });

  final EventRepository eventRepository;
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  void handleNewConnection(HttpRequest req) async {
    final token = req.uri.queryParameters['token'];

    if (token == null) {
      req.response.statusCode = HttpStatus.unauthorized;
      req.response.write('Unauthorized');
      await req.response.close();
      return;
    }
    try {
      final user = await authenticationRepository.getUserByToken(token);
      // ignore: close_sinks
      final socket = await WebSocketTransformer.upgrade(req);
      final channel = IOWebSocketChannel(socket);
      channels[user.id] = channel;
      channel.stream.listen((message) async {
        eventRepository.addEvent(message);
      });
    } catch (e) {
      req.response.statusCode = HttpStatus.unauthorized;
      req.response.write('Unauthorized');
      await req.response.close();
      return;
    }
  }

  void handleDisconnection(IOWebSocketChannel channel) {
    channels.remove(channel);
  }
}
