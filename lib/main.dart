import 'package:flutter/material.dart';
import 'package:ytdwnldr/pages/save/widgets.dart' show SavePage;
import 'package:ytdwnldr/pages/downloaded/widgets.dart' show DownloadedPage;

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
  int downloadingCounter = 0;
  String? prevUrl = null;

  void onSaved(String? url) {
    if (this.prevUrl == url) {
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
      this.downloadingCounter++;
    });

    print("Got '${url}'");
    prevUrl = url;
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
          child: SavePage(onSaved: this.onSaved),
        ),
        Center(
          /* Pagina de listado de videos descargados */
          child: DownloadedPage(),
        ),
      ][this.currentPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: this.currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            label: 'Save',
            selectedIcon: Icon(Icons.download),
            icon: Icon(Icons.download_sharp),
          ),
          NavigationDestination(
            label: 'Descargados',
            icon: Badge(
              label: Text('${this.downloadingCounter}'),
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
      ),
    );
  }
}
