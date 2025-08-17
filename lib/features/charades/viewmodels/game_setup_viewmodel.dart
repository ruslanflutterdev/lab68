import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../services/supabase_service.dart';

class GameSetupViewModel extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();

  GameModel? game;
  bool isLoading = false;
  String? error;

  Future<void> createGame(String word, String hint) async {
    isLoading = true;
    notifyListeners();

    try {
      game = await _service.createGame(word, hint);
      error = null;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> joinGame(String gameId, String playerName) async {
    isLoading = true;
    notifyListeners();

    try {
      game = await _service.joinGame(gameId, playerName);
      error = null;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
