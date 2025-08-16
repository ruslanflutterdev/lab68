class GameModel {
  final String id;
  final String word;
  final String hint;
  final String status;
  final List<String> players;

  GameModel({
    required this.id,
    required this.word,
    required this.hint,
    required this.status,
    required this.players,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] as String,
      word: json['word'] as String,
      hint: json['hint'] as String,
      status: json['status'] as String,
      players: List<String>.from(json['players'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'hint': hint,
      'status': status,
      'players': players,
    };
  }
}
