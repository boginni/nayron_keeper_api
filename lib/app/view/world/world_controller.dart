import '../game/game_controller.dart';

class WorldController {
  WorldController(this.gameController);

  final GameController gameController;

  void handleGameEvent(String message) {
    gameController.broadcastMessage(message);
  }

}
