class GameModel {
  final String id;
  final String word;
  final String hint;
  final String status; // есть 3 состояния waiting-ожидание, in_progress-в процессе, finished-окончено
  final List<String> players;

  GameModel({
    required this.id,
    required this.word,
    required this.hint,
    required this.status,
    required this.players,
  });

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'].toString(),
      word: map['word'] ?? '',
      hint: map['hint'] ?? '',
      status: map['status'] ?? 'waiting',
      players: List<String>.from(map['players'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'hint': hint,
      'status': status,
      'players': players,
    };
  }
}
