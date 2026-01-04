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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: [
        Center(child: SavePage(onSaved: (url) => {print("Got ${url}")})),
        Center(child: DownloadedPage()),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.download),
            icon: Icon(Icons.download_sharp),
            label: 'Save',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.folder)),
            label: 'Descargados',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Theme.of(context).colorScheme.tertiaryContainer,
      ),
    );
  }
}
