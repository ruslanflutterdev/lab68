import 'package:flutter/material.dart';
import 'package:lab68/features/charades/widgets/custom_button.dart';
import 'custom_text_field.dart';

class HostSetupWidget extends StatefulWidget {
  final void Function(String word, String hint)? onSubmit;

  const HostSetupWidget({super.key, this.onSubmit});

  @override
  State<HostSetupWidget> createState() => _HostSetupWidgetState();
}

class _HostSetupWidgetState extends State<HostSetupWidget> {
  late final TextEditingController _wordController;
  late final TextEditingController _hintController;

  @override
  void initState() {
    super.initState();
    _wordController = TextEditingController();
    _hintController = TextEditingController();
  }

  @override
  void dispose() {
    _wordController.dispose();
    _hintController.dispose();
    super.dispose();
  }

  void _handleCreate() {
    final word = _wordController.text.trim();
    final hint = _hintController.text.trim();
    if (word.isEmpty || hint.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Заполните слово и подсказку')));
      return;
    }
    if (widget.onSubmit != null) {
      widget.onSubmit!(word, hint);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Игра создана (локально)')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(controller: _wordController, hintText: "Введите слово"),
        SizedBox(height: 12),
        CustomTextField(
          controller: _hintController,
          hintText: "Введите подсказку",
        ),
        SizedBox(height: 20),
        CustomButton(text: "Создать игру", onPressed: _handleCreate),
      ],
    );
  }
}
