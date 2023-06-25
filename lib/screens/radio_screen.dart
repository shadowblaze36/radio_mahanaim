import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/stream_info.dart';
import '../providers/package_manager.dart';

// const String baseUrl =
//     'https://api.radioking.io/widget/radio/radio-mahanaim/track/current';

const String nowPlayingUrl =
    'http://app.sonicpanelradio.com:8052/currentsong?sid=1';

// Future<StreamInfo> fetchAlbum() async {
//   final response = await http.get(Uri.parse(baseUrl));
//   if (response.statusCode == 200) {
//     return StreamInfo.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load stream');
//   }
// }
String nowPlayingText = '-';

StreamController<String>? streamController;

void fetchData() async {
  while (true) {
    final data = await fetchNowPlaying();
    streamController?.add(data); // Emite el dato obtenido al stream
    await Future.delayed(const Duration(
        seconds: 15)); // Espera 15 segundos antes de volver a obtener datos
  }
}

Future<String> fetchNowPlaying() async {
  final nowPlayingresponse = await http.get(Uri.parse(nowPlayingUrl));
  if (nowPlayingresponse.statusCode == 200) {
    nowPlayingText = nowPlayingresponse.body;
    return nowPlayingresponse.body;
  } else {
    return '-';
  }
}

class RadioScreen extends StatefulWidget {
  const RadioScreen({Key? key}) : super(key: key);

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  late Future<String> nowPlaying;
  late Future<StreamInfo> streamInfo;
  late final PageManager _pageManager;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    streamController = StreamController<String>();
    fetchData();
    // streamInfo = fetchAlbum();
    nowPlaying = fetchNowPlaying();
    _pageManager = PageManager();
    timer = Timer.periodic(const Duration(seconds: 15),
        (Timer t) => nowPlaying = fetchNowPlaying());
    _pageManager.play();
  }

  @override
  void dispose() {
    streamController?.close();
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff3be9ff), Colors.lightGreenAccent],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: const Image(
                            image: AssetImage('assets/portrait.png'),
                            height: 300,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: StreamBuilder<String>(
                          stream: streamController
                              ?.stream, // Utiliza el stream del StreamController
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              // Si no hay datos disponibles, muestra un texto de carga
                              return const Text("Cargando...");
                            } else {
                              // Si hay datos, muestra el dato obtenido
                              return Text(snapshot.data.toString());
                            }
                          },
                        ),
                      ),
                      ValueListenableBuilder<ButtonState>(
                        valueListenable: _pageManager.buttonNotifier,
                        builder: (_, value, __) {
                          switch (value) {
                            case ButtonState.loading:
                              return Container(
                                margin: const EdgeInsets.all(8.0),
                                width: 32.0,
                                height: 32.0,
                                child: const CircularProgressIndicator(),
                              );
                            case ButtonState.paused:
                              return IconButton(
                                icon:
                                    const Icon(Icons.play_circle_fill_rounded),
                                color: const Color(0xFF032555),
                                iconSize: 70.0,
                                onPressed: _pageManager.play,
                              );
                            case ButtonState.playing:
                              return IconButton(
                                icon: const Icon(
                                    Icons.pause_circle_filled_rounded),
                                color: const Color(0xFF032555),
                                iconSize: 70.0,
                                onPressed: _pageManager.stop,
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
