import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/game_setup_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/host_setup_widget.dart';
import '../widgets/join_setup_widget.dart';
import 'game_screen.dart';

class GameSetupScreen extends ConsumerWidget {
  final bool isHost;

  const GameSetupScreen({super.key, required this.isHost});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(gameSetupViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isHost ? 'Создание игры' : 'Подключение к игре'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: viewModel.isLoading
            ? Center(child: CircularProgressIndicator())
            : isHost
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HostSetupWidget(
                    onSubmit: (word, hint) async {
                      await ref
                          .read(gameSetupViewModelProvider)
                          .createGame(word, hint);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Комната создана: ${viewModel.createdGame!.id}',
                          ),
                        ),
                      );
                    },
                  ),
                  if (viewModel.createdGame != null) ...[
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 12),
                    Text(
                      'Комната создана',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    SelectableText('ID комнаты: ${viewModel.createdGame!.id}'),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        CustomButton(
                          text: 'Копировать ID',
                          expanded: false,
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: viewModel.createdGame!.id),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('ID скопирован')),
                            );
                          },
                        ),
                        SizedBox(width: 12),
                        CustomButton(
                          text: 'Начать игру',
                          expanded: false,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GameScreen(
                                  game: viewModel.createdGame!,
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
                  final game = await ref
                      .read(gameSetupViewModelProvider)
                      .joinGame(roomId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GameScreen(game: game, isHost: false),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
