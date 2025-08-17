import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/game/view/role_selection_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoleSelectionViewModel()),
        ChangeNotifierProvider(create: (_) => GameSetupViewModel()),
        ChangeNotifierProvider(create: (_) => GameViewModel()),
      ],
      child: MaterialApp(
        title: 'Онлайн игра Шарады',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const RoleSelectionScreen(),
      ),
    );
  }
}
