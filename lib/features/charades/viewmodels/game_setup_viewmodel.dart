import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../services/supabase_service.dart';

class GameSetupViewModel extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();

  GameModel? game;
  bool isLoading = false;

  Future<void> createGame(String word, String hint) async {
    isLoading = true;
    notifyListeners();

    try {
      game = await _service.createGame(word, hint);
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> joinGame(String gameId) async {
    isLoading = true;
    notifyListeners();

    try {
      game = await _service.joinGame(gameId);
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
