import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../services/supabase_service.dart';

class GameViewModel extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();

  GameModel? game;
  bool isLoading = false;
  String? error;
  Stream<GameModel>? gameStream;

  void subscribeGame(String gameId) {
    gameStream = _service.listenGameUpdates(gameId);
    gameStream!.listen((updatedGame) {
      game = updatedGame;
      notifyListeners();
    });
  }

  Future<bool> checkAnswer(String gameId, String answer) async {
    return await _service.checkAnswer(gameId, answer);
  }
}
