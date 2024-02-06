import 'dart:io';

import 'package:watcher/watcher.dart';

void main(List<String> arguments) async {
  const path = './lib'; // Set this to your project's path
  startServer();

  // Watching the entire project directory
  final watcher = DirectoryWatcher(path);
  await for (var event in watcher.events) {
    print('Change detected: ${event.path}');
    restartServer();
  }
}

Process? _process;

void startServer() async {
  _process = await Process.start('dart', ['run', './bin/game_server.dart']);
  _process?.stdout.transform(const SystemEncoding().decoder).listen(print);
  _process?.stderr.transform(const SystemEncoding().decoder).listen((data) {
    print('Error: $data');
  });
}

void restartServer() {
  _process?.kill();
  startServer();
}
