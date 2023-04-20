import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../database/model/playlist_model/playlist_model.dart';
import '../model/song_model.dart';
import '../screens/playlist/playlist_screen.dart';

List<Songs> allsongs = [];

class FetchSong {
  final _audioQuery = OnAudioQuery();
  fetchSongs() async {
    if (await requestPermission()) {
      List<SongModel> fetchsongs = [];
      fetchsongs = await _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      for (SongModel element in fetchsongs) {
        allsongs.add(Songs(
            songname: element.displayNameWOExt,
            artist: element.artist,
            duration: element.duration,
            id: element.id,
            songurl: element.uri));
      }
    }
  }

  Future<bool> requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future playlistfetch() async {
    Box<PlaylistModal> playlistDB = await Hive.openBox('playlist');
    for (PlaylistModal element in playlistDB.values) {
      String name = element.playlistName;
      EachPlaylist playlistfetch = EachPlaylist(playlistName: name);
      if (element.playlistSongID.isNotEmpty) {
        for (int id in element.playlistSongID) {
          for (Songs songs in allsongs) {
            if (id == songs.id) {
              playlistfetch.playlistSongs.add(songs);
              break;
            }
          }
        }
      }
      playlist.add(playlistfetch);
    }
    playlistDB.close();
  }
}
