import 'package:flutter/material.dart';
import './downloadedCard.dart' show DownloadedCard, Downloaded;

class DownloadedList extends StatefulWidget {
  const DownloadedList({
    required this.downloads,
    required this.onOpenCard,
    super.key,
  });

  final List<Downloaded> downloads;
  final void Function(String?)? onOpenCard;

  @override
  State<DownloadedList> createState() => _DownloadedListState();
}

class _DownloadedListState extends State<DownloadedList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: widget.downloads.map((down) {
        return DownloadedCard(download: down, onOpenCard: widget.onOpenCard);
      }).toList(),
    );
  }
}
