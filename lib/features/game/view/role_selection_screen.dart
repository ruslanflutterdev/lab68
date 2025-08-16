import 'package:flutter/material.dart';
import 'package:lab68/features/game/view/game_setup_screen.dart';
import 'package:lab68/features/game/widgets/custom_button.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Выбор роли")),
      body: Padding(
        padding:  EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: "Играть за ведущего (A)",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>  GameSetupScreen(),
                  ),
                );
              },
            ),
             SizedBox(height: 20),
            CustomButton(
              text: "Играть за угадывающего (B)",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>  GameSetupScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
