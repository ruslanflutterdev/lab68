import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../charades/viewmodels/game_setup_viewmodel.dart';
import '../../charades/viewmodels/game_viewmodel.dart';
import '../widgets/custom_button.dart';
import '../widgets/host_setup_widget.dart';
import '../widgets/join_setup_widget.dart';
import 'game_screen.dart';

class GameSetupScreen extends StatelessWidget {
  final bool isHost;

  const GameSetupScreen({super.key, required this.isHost});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GameSetupViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isHost ? 'Создание игры' : 'Подключение к игре'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : isHost
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HostSetupWidget(
              onSubmit: (word, hint) async {
                await Provider.of<GameSetupViewModel>(context, listen: false).createGame(word, hint);
                final snackbarMessage = viewModel.error != null
                    ? 'Ошибка: ${viewModel.error}'
                    : 'Комната создана: ${viewModel.game!.id}';
                if(!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(snackbarMessage)),
                );
              },
            ),
            if (viewModel.game != null) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              const Text(
                'Комната создана',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              SelectableText('ID комнаты: ${viewModel.game!.id}'),
              const SizedBox(height: 8),
              Row(
                children: [
                  CustomButton(
                    text: 'Копировать ID',
                    expanded: false,
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: viewModel.game!.id),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ID скопирован')),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  CustomButton(
                    text: 'Начать игру',
                    expanded: false,
                    onPressed: () {
                      final gameViewModel = Provider.of<GameViewModel>(context, listen: false);
                      gameViewModel.subscribeGame(viewModel.game!.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GameScreen(
                            gameId: viewModel.game!.id,
                            isHost: true,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ],
        )
            : JoinSetupWidget(
          onSubmit: (roomId) async {
            await Provider.of<GameSetupViewModel>(context, listen: false).joinGame(roomId, 'playerB');
            if (viewModel.error != null) {
              if(!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ошибка: ${viewModel.error}')),
              );
            } else {
              if(!context.mounted) return;
              final gameViewModel = Provider.of<GameViewModel>(context, listen: false);
              gameViewModel.subscribeGame(roomId);
              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GameScreen(
                    gameId: roomId,
                    isHost: false,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
