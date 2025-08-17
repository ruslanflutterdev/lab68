import 'package:flutter/material.dart';
import 'package:lab68/features/charades/widgets/custom_button.dart';
import 'package:lab68/features/charades/widgets/custom_text_field.dart';


class JoinSetupWidget extends StatefulWidget {
  final void Function(String roomId)? onSubmit;

  const JoinSetupWidget({super.key, this.onSubmit});

  @override
  State<JoinSetupWidget> createState() => _JoinSetupWidgetState();
}

class _JoinSetupWidgetState extends State<JoinSetupWidget> {
  late final TextEditingController _roomIdController;

  @override
  void initState() {
    super.initState();
    _roomIdController = TextEditingController();
  }

  @override
  void dispose() {
    _roomIdController.dispose();
    super.dispose();
  }

  void _handleJoin() {
    final roomId = _roomIdController.text.trim();
    if (roomId.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Введите ID комнаты')));
      return;
    }
    if (widget.onSubmit != null) {
      widget.onSubmit!(roomId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Подключение (локально) к комнате: $roomId')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          controller: _roomIdController,
          hintText: "Введите ID комнаты",
        ),
        SizedBox(height: 20),
        CustomButton(text: "Подключиться", onPressed: _handleJoin),
      ],
    );
  }
}
