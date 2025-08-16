import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/game_model.dart';

class GameViewModel extends StateNotifier<GameModel> {
  GameViewModel(super.state);

  void checkAnswer(String guess) {
    final secret = state.word;
    final win = guess.toLowerCase() == secret.toLowerCase();

    if (win) {
      print('Вы выиграли!');
    } else {
      print('Вы проиграли!');
    }
  }
}

final gameViewModelProvider =
    StateNotifierProvider.family<GameViewModel, GameModel, GameModel>(
      (ref, game) => GameViewModel(game),
    );
