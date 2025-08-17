import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/charades/view/role_selection_screen.dart';
import 'features/charades/viewmodels/role_selection_viewmodel.dart';
import 'features/charades/viewmodels/game_setup_viewmodel.dart';
import 'features/charades/viewmodels/game_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zigycvqdtdozvopaswbd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InppZ3ljdnFkdGRvenZvcGFzd2JkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM4OTc2MDcsImV4cCI6MjA2OTQ3MzYwN30.IgKrXFJckAGrz24eEq-NqkCIxvXRok6igvYbu3alSXI',
  );

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
        home: const RoleSelectionScreen(),
      ),
    );
  }
}
