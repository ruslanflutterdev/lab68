import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/game_model.dart';

class SupabaseService {
  final client = Supabase.instance.client;

  Future<GameModel> createGame(String word, String hint) async {
    try {
      final response = await client
          .from('games')
          .insert({'word': word, 'hint': hint, 'status': 'waiting'})
          .select()
          .single();
      return GameModel.fromMap(response);
    } catch (e) {
      throw Exception('Не удалось создать игру: $e');
    }
  }

  Future<GameModel> joinGame(String gameId) async {
    try {
      final existing = await client
          .from('games')
          .select()
          .eq('id', gameId)
          .single();
      return GameModel.fromMap(existing);
    } catch (e) {
      throw Exception(
        'Не удалось подключиться к игре. Возможно, комната с ID "$gameId" не найдена или возникла другая ошибка: ${e.toString()}',
      );
    }
  }

  Stream<GameModel> listenGameUpdates(String gameId) {
    return client.from('games').stream(primaryKey: ['id']).eq('id', gameId).map(
      (event) {
        if (event.isNotEmpty) {
          return GameModel.fromMap(event.first);
        }
        throw Exception("Game not found");
      },
    );
  }

  Future<bool> checkAnswer(String gameId, String answer) async {
    final data = await client.from('games').select().eq('id', gameId).single();
    final game = GameModel.fromMap(data);

    if (game.word.toLowerCase() == answer.toLowerCase()) {
      await client
          .from('games')
          .update({'status': 'finished'})
          .eq('id', gameId);
      return true;
    }
    return false;
  }
}
