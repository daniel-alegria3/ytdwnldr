import 'package:flutter/material.dart';

class Downloaded {
  const Downloaded({required this.name, required this.url, required this.dir});
  final String name;
  final String url;
  final String dir;
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
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: .min,
          children: [
            ListTile(
              leading: Icon(Icons.video_file_sharp),
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
