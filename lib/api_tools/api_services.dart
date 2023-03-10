import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:video_urok/api_tools/channel_model.dart';
import 'package:video_urok/api_tools/video_model.dart';
import 'package:video_urok/main.dart';


class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<Channel> fetchChannel({required String channelID}) async {
    Map<String, String> parameters = {
      "part": "snippet, contentDetails, statistics",
      "id": channelID,
      "key": API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      "/youtube/v3/channels/",
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    ///Get channel
    ///

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      /// For Playlist
      ///
      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId,
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchVideosFromPlaylist({
    required String playlistId,
  }) async {
    Map<String, String> parameters = {
      "part": "snippet",
      "playlistId": playlistId,
      "maxResults": "500",
      "pageToken": _nextPageToken,
      "key": API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      'youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];
      List<Video> videos = [];
      videosJson.forEach((json) =>
          videos.add(Video.fromMap(json['snippet']),),);
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
    }
  }

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
