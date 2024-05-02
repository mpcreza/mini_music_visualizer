import 'package:example/song_metadata.dart';
import 'package:flutter/material.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> playing = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Project')),
      body: SizedBox.expand(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: musicLibrary.length,
          itemBuilder: (context, index) {
            final item = musicLibrary[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                title: Text(item.title),
                subtitle: Text(item.artist),
                leading: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Image(
                    image: AssetImage(item.image),
                    fit: BoxFit.cover,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index == 1)
                      ValueListenableBuilder<bool>(
                        valueListenable: playing,
                        builder: (BuildContext context, value, Widget? child) {
                          return MiniMusicVisualizer(
                            color: Colors.red,
                            width: 4,
                            height: 15,
                            radius: 2,
                            animate: value,
                          );
                        },
                      ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: playing,
        builder: (BuildContext context, bool value, Widget? child) {
          return FloatingActionButton.extended(
            onPressed: () {
              playing.value = !playing.value;
            },
            label: const Text('Play / Pause'),
            icon: Icon(playing.value ? Icons.pause : Icons.play_arrow),
          );
        },
      ),
    );
  }
}

const musicLibrary = [
  SongMetadata(
    title: 'Invader',
    artist: 'Dance With the Dead',
    image: 'assets/images/Dance_with_the_dead_near_dark.jpg',
  ),
  SongMetadata(
    title: 'Don\'t Stop Me Now',
    artist: 'Queen',
    image: 'assets/images/Queen_Jazz.png',
  ),
  SongMetadata(
    title: 'I\'m Good (Blue)',
    artist: 'David Guetta, Bebe Rexha',
    image: 'assets/images/I\'m_Good_Blue.png',
  ),
  SongMetadata(
    title: 'Excaping the Void',
    artist: 'Timecop1983',
    image: 'assets/images/Excaping_the_Void.jpg',
  ),
  SongMetadata(
    title: 'Master of Puppets (Remastered)',
    artist: 'Metallica',
    image: 'assets/images/Master_of_Puppets_Remastered.jpg',
  ),
];
