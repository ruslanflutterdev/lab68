import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class GameScreen extends StatefulWidget {
  final String gameId;
  final bool isHost;

  const GameScreen({super.key, required this.gameId, required this.isHost});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _maskedWord(String w) => List.filled(w.characters.length, '•').join();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Игра'),
            Text(
              'Комната: ${widget.gameId}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: Consumer<GameViewModel>(
        builder: (context, gameViewModel, child) {
          final gameData = gameViewModel.game;

          if (gameData == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Подсказка:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  gameData.hint.isNotEmpty
                      ? gameData.hint
                      : 'Подсказка появится здесь',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text('Слово:', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(
                  widget.isHost ? gameData.word : _maskedWord(gameData.word),
                  style: const TextStyle(fontSize: 24, letterSpacing: 2),
                ),
                const SizedBox(height: 24),
                if (!widget.isHost) ...[
                  CustomTextField(
                    controller: _controller,
                    hintText: 'Ваш ответ',
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Отправить',
                    onPressed: () async {
                      final isCorrect = await Provider.of<GameViewModel>(
                        context,
                        listen: false,
                      ).checkAnswer(widget.gameId, _controller.text);
                      if (!context.mounted) return;

                      final snackbarMessage = isCorrect
                          ? 'Поздравляем! Вы угадали слово!'
                          : 'Неверно. Попробуйте еще раз.';

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(snackbarMessage)));
                    },
                  ),
                ],
                if (gameData.status == 'finished') ...[
                  const SizedBox(height: 20),
                  const Text(
                    'Игра завершена!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
