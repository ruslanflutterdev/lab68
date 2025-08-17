import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/game_model.dart';

class SupabaseService {
  final client = Supabase.instance.client;

  Future<GameModel?> createGame(String word, String hint) async {
    final response = await client.from('games').insert({
      'word': word,
      'hint': hint,
      'status': 'waiting',
      'players': [],
    }).select().single();

    return GameModel.fromMap(response);
  }

  Future<GameModel?> joinGame(String gameId, String playerName) async {
    final existing = await client.from('games').select().eq('id', gameId).single();

    final List<dynamic> currentPlayers = existing['players'] ?? [];
    if (!currentPlayers.contains(playerName)) {
      currentPlayers.add(playerName);
    }

    final response = await client
        .from('games')
        .update({'players': currentPlayers})
        .eq('id', gameId)
        .select()
        .single();

    return GameModel.fromMap(response);
  }

  Stream<GameModel> listenGameUpdates(String gameId) {
    return client
        .from('games')
        .stream(primaryKey: ['id'])
        .eq('id', gameId)
        .map((event) {
      if (event.isNotEmpty) {
        return GameModel.fromMap(event.first);
      }
      throw Exception("Game not found");
    });
  }

  Future<bool> checkAnswer(String gameId, String answer) async {
    final data = await client.from('games').select().eq('id', gameId).single();
    final game = GameModel.fromMap(data);

    if (game.word.toLowerCase() == answer.toLowerCase()) {
      await client.from('games').update({'status': 'finished'}).eq('id', gameId);
      return true;
    }
    return false;
  }
}
