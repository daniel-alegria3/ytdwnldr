import 'package:flutter/material.dart';
import 'package:ytdwnldr/pages/save/widgets.dart' show SavePage;
import 'package:ytdwnldr/pages/downloaded/widgets.dart' show DownloadedPage;
import 'package:ytdwnldr/pages/downloaded/downloadedCard.dart' show Downloaded;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final double INPUT_BORDER_RADIOUS = 15;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.red),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(INPUT_BORDER_RADIOUS),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(INPUT_BORDER_RADIOUS),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(INPUT_BORDER_RADIOUS),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Youtube Downloader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  List<Downloaded> downloads = [];
  List<Downloaded> selectedDownloads = [];

  void downloadUrl(String? url) {
    if (this.downloads.any((d) => d.url == url)) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: const Center(child: Text('Video ya descargado')),
            behavior: SnackBarBehavior.floating,
            width: MediaQuery.of(context).size.width * 0.45,
            duration: const Duration(seconds: 3),
          ),
        );
      return;
    }

    setState(() {
      this.downloads.add(
        // TODO: change name and dir with ytdlp plugin
        Downloaded(name: '${url}', url: '${url}', dir: '${url}'),
      );
    });

    print("Got url '${url}'");
  }

  void openCard(String? dir) {
    print("Got dir '${dir}'");
  }

  void longPressCard(Downloaded? down) {
    setState(() {
      this.selectedDownloads.add(down!);
    });
  }

  void deleteSelectedDownloads() {
    for (Downloaded down in this.selectedDownloads) {
      try {
        print("Deleted ${down.dir}");
        setState(() {
          this.selectedDownloads.remove(down);
          this.downloads.remove(down);
        });
      } catch (e) {
        print("ERROR: ${e}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: [
        Center(
          /* Pagina de guardado de videos a descargar */
          child: SavePage(onSaved: this.downloadUrl),
        ),
        Center(
          /* Pagina de listado de videos descargados */
          child: DownloadedPage(
            downloads: this.downloads,
            onOpenCard: this.openCard,
            onCardLongPress: this.longPressCard,
          ),
        ),
      ][this.currentPageIndex],
      bottomNavigationBar: this.selectedDownloads.length == 0
          ? NavigationBar(
              selectedIndex: this.currentPageIndex,
              destinations: [
                NavigationDestination(
                  label: 'Save',
                  selectedIcon: Icon(Icons.download),
                  icon: Icon(Icons.download_sharp),
                ),
                NavigationDestination(
                  label: 'Descargados',
                  icon: Badge(
                    label: Text('${this.downloads.length}'),
                    child: Icon(Icons.folder),
                  ),
                ),
              ],
              onDestinationSelected: (int index) {
                setState(() {
                  this.currentPageIndex = index;
                });
              },
              indicatorColor: Theme.of(context).colorScheme.tertiaryContainer,
            )
          : BottomAppBar(
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: 'Delete',
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.onPrimary,
                    onPressed: () {
                      deleteSelectedDownloads();
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
