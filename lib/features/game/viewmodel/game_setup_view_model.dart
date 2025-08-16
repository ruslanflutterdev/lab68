import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/game_model.dart';
import '../../../services/supabase_service.dart';

class GameSetupViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService;

  GameSetupViewModel(this._supabaseService);

  GameModel? _createdGame;
  GameModel? get createdGame => _createdGame;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> createGame(String word, String hint) async {
    _isLoading = true;
    notifyListeners();

    _createdGame = await _supabaseService.createGame(word, hint);

    _isLoading = false;
    notifyListeners();
  }

  Future<GameModel> joinGame(String gameId) async {
    _isLoading = true;
    notifyListeners();

    final game = await _supabaseService.joinGame(gameId);

    _isLoading = false;
    notifyListeners();
    return game;
  }
}

final gameSetupViewModelProvider = ChangeNotifierProvider<GameSetupViewModel>(
  (ref) => GameSetupViewModel(ref.read(supabaseServiceProvider)),
);
