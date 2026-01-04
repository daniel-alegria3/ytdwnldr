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
    super.key,
  });

  final Downloaded download;
  final void Function(String?)? onOpenCard;

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
            ),
            Row(
              mainAxisAlignment: .end,
              children: [
                TextButton(
                  child: const Text('Open'),
                  onPressed: () {
                    if (this.onOpenCard != null) {
                      this.onOpenCard!("${this.download.dir}");
                    }
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
