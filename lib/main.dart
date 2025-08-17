import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/charades/viewmodels/role_selection_viewmodel.dart';
import 'features/charades/viewmodels/game_setup_viewmodel.dart';
import 'features/charades/viewmodels/game_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // здесь нужно добавить Supabase инициализацию (supabaseUrl, anonKey)
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
        debugShowCheckedModeBanner: false,
        title: 'Charades Game',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const PlaceholderScreen(),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("UI здесь"),
      ),
    );
  }
}
