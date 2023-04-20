import 'package:hive_flutter/hive_flutter.dart';
import '../../model/song_model.dart';
import '../../screens/playlist/playlist_screen.dart';
import '../model/playlist_model/playlist_model.dart';

Future playlistcreating(String name) async {
  playlist.add(EachPlaylist(playlistName: name));
  Box<PlaylistModal> playlistDB = await Hive.openBox('playlist');
  playlistDB.add(PlaylistModal(playlistName: name));
  print(playlistDB.values);
  playlistDB.close();
}

Future playlistRename(
    {required String oldName, required String newName}) async {
  for (int i = 0; i < playlist.length; i++) {
    if (playlist[i].playlistName == oldName) {
      playlist[i].playlistName = newName;
      break;
    }
  }
  Box<PlaylistModal> playlistDB = await Hive.openBox('playlist');
  var key;
  for (PlaylistModal element in playlistDB.values) {
    if (element.playlistName == oldName) {
      key = element.key;
      break;
    }
  }
  playlistDB.put(key, PlaylistModal(playlistName: newName));
  playlistDB.close();
}

Future playlistDelete(int index) async {
  String name = playlist[index].playlistName;
  playlist.removeAt(index);
  Box<PlaylistModal> playlistDB = await Hive.openBox('playlist');
  for (PlaylistModal element in playlistDB.values) {
    if (element.playlistName == name) {
      var key = element.key;
      playlistDB.delete(key);
      break;
    }
  }
}
