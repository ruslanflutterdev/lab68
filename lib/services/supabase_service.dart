import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_model.dart';

class SupabaseService {
  Future<GameModel> createGame(String word, String hint) async {
    // Имитация задержки сети
    await Future.delayed(const Duration(seconds: 1));

    // Генерируем случайный ID для комнаты
    final id = (100000 + Random().nextInt(900000)).toString();

    return GameModel(
      id: id,
      word: word,
      hint: hint,
      status: 'waiting',
      players: ['playerA'],
    );
  }

  Future<GameModel> joinGame(String gameId) async {
    // Имитация задержки сети
    await Future.delayed(const Duration(seconds: 1));

    //  модель для демонстрации
    return GameModel(
      id: gameId,
      word: 'загаданное',
      hint: 'подсказка',
      status: 'playing',
      players: ['playerB'],
    );
  }
}

// Создаем "провайдер" для SupabaseService
final supabaseServiceProvider = Provider((ref) => SupabaseService());
