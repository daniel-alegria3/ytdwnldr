import 'package:flutter/material.dart';
import './downloadedList.dart' show DownloadedList;
import './downloadedCard.dart' show Downloaded;

class DownloadedPage extends StatelessWidget {
  const DownloadedPage({
    required this.downloads,
    this.onOpenCard,
    this.onCardLongPress,
    super.key,
  });

  final List<Downloaded> downloads;
  final void Function(String?)? onOpenCard;
  final void Function(Downloaded?)? onCardLongPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Expanded(
          child: DownloadedList(
            downloads: this.downloads,
            onOpenCard: this.onOpenCard,
            onCardLongPress: this.onCardLongPress,
          ),
        ),
      ],
    );
  }
}
