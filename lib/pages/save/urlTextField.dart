import 'package:flutter/material.dart';

/* Widget que proporciona una entrada para el url de Youtube */

class UrlTextField extends StatefulWidget {
  const UrlTextField({required this.onSaved, super.key});

  final void Function(String?)? onSaved;

  @override
  State<UrlTextField> createState() => _UrlTextFieldState();
}

class _UrlTextFieldState extends State<UrlTextField> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  bool _isValidUrl = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_validateUrl);
  }

  void _validateUrl() {
    setState(() {
      _isValidUrl = _validateYoutubeUrl(_controller.text) == null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Valida que un url tenga el formato de uno de Youtube
  String? _validateYoutubeUrl(String? value) {
    final trimmedValue = value?.trim();

    if (trimmedValue == null || trimmedValue.isEmpty) {
      return 'Por favor ingresa una URL';
    }

    final youtubeRegex = RegExp(
      r'^(https?://)?(www\.)?(youtube\.com/watch\?v=|youtu\.be/)[a-zA-Z0-9_-]{11}',
    );

    if (!youtubeRegex.hasMatch(trimmedValue)) {
      return 'Por favor ingresa una URL de YouTube válida';
    }

    return null;
  }

  void _clearTextField() {
    _controller.clear();
  }

  void _submitUrl() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // print('URL válida: ${_controller.text}');
    }
  }

  // Build principal
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Form(
        key: _formKey,
        child: FormField<String>(
          initialValue: '',
          validator: _validateYoutubeUrl,
          onSaved: (value) => widget.onSaved?.call(value?.trim()),
          builder: (FormFieldState<String> state) {
            return TextField(
              controller: _controller,
              onChanged: (value) => state.didChange(value),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.link),
                /// DECORACION DEL SUFIX
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 24,
                          maxHeight: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceDim,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.clear),
                          iconSize: 12,
                          padding: .zero,
                          onPressed: _clearTextField,
                          tooltip: 'Limpiar',
                        ),
                      ),
                      if (_isValidUrl) ...[
                        Container(
                          height:
                              50, // TODO: learn how to use the available height of the parent widget
                          width: 2,
                          color: Theme.of(context).dividerColor,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: _submitUrl,
                          tooltip: 'Descargar',
                        ),
                      ],
                    ],
                  ),
                ),
                hintText: 'pegar el link aca',
                errorText: state.errorText,
              ),
            );
          },
        ),
      ),
    );
  }
}
