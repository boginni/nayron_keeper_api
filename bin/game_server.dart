import 'package:nayron_keeper_api/app/view/ws.dart';

void main() async {
  final server = GameSocket();

  server.start();
}
