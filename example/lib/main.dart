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

  final ValueNotifier<bool> playing = ValueNotifier(false);

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
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index == 1)
                      ValueListenableBuilder<bool>(valueListenable: playing, builder: (BuildContext context, value, Widget? child) {
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
        valueListenable: playing, builder: (BuildContext context, bool value, Widget? child) { 
          return  IconButton(icon: playing.value ? const Icon(Icons.pause) : const Icon(Icons.play_arrow), onPressed: () {
            playing.value = !playing.value;
          });
         }, 
      ),
    );
  }
}

const musicLibrary = [
  SongMetadata(
    title: 'champagne problems',
    artist: 'Taylor Swift',
    image: 'assets/images/Taylor_Swift_Evermore.png',
  ),
  SongMetadata(
    title: 'my tears ricochet',
    artist: 'Taylor Swift',
    image: 'assets/images/Taylor_Swift_Folklore.png',
  ),
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
    title: 'Shake It Off',
    artist: 'Taylor Swift',
    image: 'assets/images/Taylor_Swift_1989.png',
  ),
];
