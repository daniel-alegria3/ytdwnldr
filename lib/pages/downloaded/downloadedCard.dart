import 'package:flutter/material.dart';

/* Item de lista para downloadedList, provee informacion botones de accion para
 * los urls descargados */

enum DownloadMode { Auto, Audio, Video }

class Downloaded {
  const Downloaded({
    required this.name,
    required this.url,
    required this.dir,
    required this.mode,
  });
  final String name;
  final String url;
  final String dir;
  final DownloadMode mode;
}

class DownloadedCard extends StatelessWidget {
  const DownloadedCard({
    required this.download,
    required this.onOpenCard,
    required this.onCardLongPress,
    super.key,
  });

  final Downloaded download;
  final void Function(String?)? onOpenCard;
  final void Function(Downloaded?)? onCardLongPress;

  @override
  Widget build(BuildContext context) {
    Icon cardIcon;
    switch (this.download.mode) {
      case DownloadMode.Auto:
        cardIcon = Icon(Icons.auto_mode);
        break;
      case DownloadMode.Video:
        cardIcon = Icon(Icons.video_file_sharp);
        break;
      case DownloadMode.Audio:
        cardIcon = Icon(Icons.music_video_sharp);
        break;
    }

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: .min,
          children: [
            ListTile(
              leading: cardIcon,
              title: Text(this.download.name),
              subtitle: Text("${this.download.url}"),
              onLongPress: () {
                this.onCardLongPress?.call(this.download);
              },
            ),
            Row(
              mainAxisAlignment: .end,
              children: [
                TextButton(
                  child: const Text('Open'),
                  onPressed: () {
                    this.onOpenCard?.call("${this.download.dir}");
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
