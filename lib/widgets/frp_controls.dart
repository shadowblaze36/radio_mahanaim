import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_player_event.dart';

class FRPPlayerControls extends StatefulWidget {
  final FlutterRadioPlayer flutterRadioPlayer;
  final Function addSourceFunction;
  final Function nextSource;
  final Function prevSource;
  final Function(String status) updateCurrentStatus;
  final Function updateHeaderFunction;

  const FRPPlayerControls(
      {Key? key,
      required this.flutterRadioPlayer,
      required this.addSourceFunction,
      required this.nextSource,
      required this.prevSource,
      required this.updateCurrentStatus,
      required this.updateHeaderFunction})
      : super(key: key);

  @override
  State<FRPPlayerControls> createState() => _FRPPlayerControlsState();
}

class _FRPPlayerControlsState extends State<FRPPlayerControls> {
  String latestPlaybackStatus = "flutter_radio_stopped";
  String currentPlaying = "-";
  double volume = 0.5;
  final nowPlayingTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.flutterRadioPlayer.frpEventStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FRPPlayerEvents frpEvent =
              FRPPlayerEvents.fromJson(jsonDecode(snapshot.data as String));
          if (kDebugMode) {
            print("====== EVENT START =====");
            print("Playback status: ${frpEvent.playbackStatus}");
            print("Icy details: ${frpEvent.icyMetaDetails}");
            print("Other: ${frpEvent.data}");
            print("====== EVENT END =====");
          }
          if (frpEvent.playbackStatus != null) {
            latestPlaybackStatus = frpEvent.playbackStatus!;
            widget.updateCurrentStatus(latestPlaybackStatus);
          }
          if (frpEvent.icyMetaDetails != null) {
            currentPlaying = frpEvent.icyMetaDetails!;
            nowPlayingTextController.text = frpEvent.icyMetaDetails!;
          }
          var statusIcon = const Icon(Icons.pause_circle_filled);
          switch (frpEvent.playbackStatus) {
            case "flutter_radio_playing":
              statusIcon = const Icon(
                Icons.pause_circle_filled,
                size: 45,
              );
              break;
            case "flutter_radio_paused":
              statusIcon = const Icon(
                Icons.play_circle_filled,
                size: 45,
              );
              break;
            case "flutter_radio_loading":
              statusIcon = const Icon(
                Icons.refresh_rounded,
                size: 45,
              );
              break;
            case "flutter_radio_stopped":
              statusIcon = const Icon(
                Icons.play_circle_filled,
                size: 45,
              );
              break;
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 45.0,
                        onPressed: () async {
                          if (latestPlaybackStatus == "flutter_radio_stopped") {
                            widget.flutterRadioPlayer.play();
                          }
                          widget.flutterRadioPlayer.playOrPause();
                          widget.updateHeaderFunction;
                        },
                        icon: statusIcon,
                      ),
                      IconButton(
                        iconSize: 45.0,
                        onPressed: () async {
                          widget.flutterRadioPlayer.stop();
                          widget.flutterRadioPlayer.initPlayer();
                          widget.addSourceFunction();
                          widget.flutterRadioPlayer.seekToMediaSource(0, false);
                          widget.updateHeaderFunction;
                        },
                        icon: const Icon(Icons.stop_circle_outlined),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.volume_up_rounded,
                        size: 30,
                      ),
                      Slider(
                        value: volume,
                        onChanged: (value) {
                          setState(() {
                            volume = value;
                            widget.flutterRadioPlayer.setVolume(volume);
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        } else if (latestPlaybackStatus == "flutter_radio_stopped") {
          return IconButton(
              iconSize: 70.0,
              onPressed: () async {
                widget.flutterRadioPlayer.playOrPause();
                widget.updateHeaderFunction;
              },
              icon: const Icon(
                Icons.play_circle_filled,
                size: 70,
              ));
        }
        return const Text("Determining state ...");
      },
    );
  }
}
