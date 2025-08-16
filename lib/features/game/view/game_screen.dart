import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/game_model.dart';
import '../viewmodel/game_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class GameScreen extends ConsumerWidget {
  final GameModel game;
  final bool isHost;

  const GameScreen({super.key, required this.game, required this.isHost});

  String _maskedWord(String w) => List.filled(w.characters.length, '•').join();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameData = ref.watch(gameViewModelProvider(game));
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Игра'),
            Text('Комната: ${gameData.id}', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Подсказка:', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 6),
            Text(
              gameData.hint.isNotEmpty
                  ? gameData.hint
                  : 'Подсказка появится здесь',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text('Слово:', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 6),
            Text(
              isHost ? gameData.word : _maskedWord(gameData.word),
              style: TextStyle(fontSize: 24, letterSpacing: 2),
            ),
            SizedBox(height: 24),
            CustomTextField(controller: controller, hintText: 'Ваш ответ'),
            SizedBox(height: 12),
            CustomButton(
              text: 'Отправить',
              onPressed: () {
                ref
                    .read(gameViewModelProvider(game).notifier)
                    .checkAnswer(controller.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
