import 'package:flutter/material.dart';
import 'package:ytdwnldr/pages/downloaded/index.dart' show DownloadMode;

/* Widget para seleccionar un enum del modo de descarga (ver 'DownloadMode') */

class SelectDownloadMode extends StatefulWidget {
  const SelectDownloadMode({
    required this.onSaved,
    this.initialMode,
    super.key,
  });

  final void Function(DownloadMode?)? onSaved;
  final DownloadMode? initialMode;

  @override
  State<SelectDownloadMode> createState() => _SelecteDownloadModeState();
}

class _SelecteDownloadModeState extends State<SelectDownloadMode> {
  late DownloadMode mode;

  @override
  void initState() {
    super.initState();
    mode = widget.initialMode ?? DownloadMode.Auto;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<DownloadMode>(
      segments: const <ButtonSegment<DownloadMode>>[
        ButtonSegment<DownloadMode>(
          value: DownloadMode.Auto,
          label: Text('auto'),
          icon: Icon(Icons.auto_mode),
        ),
        ButtonSegment<DownloadMode>(
          value: DownloadMode.Video,
          label: Text('mp4'),
          icon: Icon(Icons.video_file_sharp),
        ),
        ButtonSegment<DownloadMode>(
          value: DownloadMode.Audio,
          label: Text('mp3'),
          icon: Icon(Icons.music_video_sharp),
        ),
      ],
      selected: <DownloadMode>{mode},
      onSelectionChanged: (Set<DownloadMode> newSelection) {
        setState(() {
          mode = newSelection.first;
          widget.onSaved?.call(mode);
        });
      },
    );
  }
}
