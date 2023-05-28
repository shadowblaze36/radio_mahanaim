import 'dart:convert';

StreamInfo streamInfoFromJson(String str) =>
    StreamInfo.fromJson(json.decode(str));

String streamInfoToJson(StreamInfo data) => json.encode(data.toJson());

class StreamInfo {
  int id;
  String artist;
  String title;
  dynamic album;
  String startedAt;
  String endAt;
  String nextTrack;
  double duration;
  dynamic buyLink;
  bool isLive;
  String cover;
  bool defaultCover;
  bool forcedTitle;

  StreamInfo({
    required this.id,
    required this.artist,
    required this.title,
    this.album,
    required this.startedAt,
    required this.endAt,
    required this.nextTrack,
    required this.duration,
    this.buyLink,
    required this.isLive,
    required this.cover,
    required this.defaultCover,
    required this.forcedTitle,
  });

  factory StreamInfo.fromJson(Map<String, dynamic> json) => StreamInfo(
        id: json["id"],
        artist: json["artist"],
        title: json["title"],
        album: json["album"],
        startedAt: json["started_at"],
        endAt: json["end_at"],
        nextTrack: json["next_track"],
        duration: json["duration"]?.toDouble(),
        buyLink: json["buy_link"],
        isLive: json["is_live"],
        cover: json["cover"],
        defaultCover: json["default_cover"],
        forcedTitle: json["forced_title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "artist": artist,
        "title": title,
        "album": album,
        "started_at": startedAt,
        "end_at": endAt,
        "next_track": nextTrack,
        "duration": duration,
        "buy_link": buyLink,
        "is_live": isLive,
        "cover": cover,
        "default_cover": defaultCover,
        "forced_title": forcedTitle,
      };
}
