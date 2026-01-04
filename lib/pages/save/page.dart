import 'package:flutter/material.dart';
import './urlTextField.dart' show UrlTextField;

class SavePage extends StatelessWidget {
  const SavePage({required this.onSaved, super.key});

  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [UrlTextField(onSaved: this.onSaved)],
    );
  }
}
