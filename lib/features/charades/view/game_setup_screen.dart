import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab68/features/charades/viewmodels/game_setup_viewmodel.dart';
import 'package:lab68/features/charades/widgets/custom_button.dart';
import 'package:lab68/features/charades/widgets/host_setup_widget.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';
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
            ? Center(child: CircularProgressIndicator())
            : isHost
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HostSetupWidget(
                    onSubmit: (word, hint) async {
                      try {
                        await Provider.of<GameSetupViewModel>(
                          context,
                          listen: false,
                        ).createGame(word, hint);
                        if (!context.mounted) return;
                        final gameViewModel = Provider.of<GameViewModel>(
                          context,
                          listen: false,
                        );
                        gameViewModel.subscribeGame(viewModel.game!.id);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GameScreen(
                              gameId: viewModel.game!.id,
                              isHost: true,
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Ошибка создания игры: ${e.toString()}',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  if (viewModel.game != null) ...[
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 12),
                    Text(
                      'Комната создана! Поделитесь ID с другим игроком:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    SelectableText(
                      viewModel.game!.id,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomButton(
                      text: 'Копировать ID',
                      expanded: false,
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: viewModel.game!.id),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('ID скопирован')),
                        );
                      },
                    ),
                  ],
                ],
              )
            : JoinSetupWidget(
                onSubmit: (roomId) async {
                  try {
                    await Provider.of<GameSetupViewModel>(
                      context,
                      listen: false,
                    ).joinGame(roomId);
                    if (!context.mounted) return;
                    final gameViewModel = Provider.of<GameViewModel>(
                      context,
                      listen: false,
                    );
                    gameViewModel.subscribeGame(roomId);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            GameScreen(gameId: roomId, isHost: false),
                      ),
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Ошибка подключения: ${e.toString()}'),
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}
