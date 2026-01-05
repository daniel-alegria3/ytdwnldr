import 'package:flutter/material.dart';
import 'package:ytdwnldr/pages/downloaded/index.dart' show DownloadMode;
import './urlTextField.dart' show UrlTextField;
import './selectDownloadMode.dart' show SelectDownloadMode;

/* La pagina del Formulario para descargar un url de Youtube */

class SavePage extends StatefulWidget {
  const SavePage({required this.onSubmit, super.key});

  final void Function(String?, DownloadMode mode)? onSubmit;

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  String? _url;
  DownloadMode? _mode = DownloadMode.Auto;

  void _handleUrlSaved(String? url) {
    setState(() => _url = url);
    _submitIfReady();
  }

  void _handleModeSaved(DownloadMode? mode) {
    setState(() => _mode = mode);
  }

  void _submitIfReady() {
    if (_url != null && _mode != null) {
      widget.onSubmit?.call(_url, _mode!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        UrlTextField(onSaved: _handleUrlSaved),
        SelectDownloadMode(onSaved: _handleModeSaved, initialMode: _mode),
      ],
    );
  }
}
