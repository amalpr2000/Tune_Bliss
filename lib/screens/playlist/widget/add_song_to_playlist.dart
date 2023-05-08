import 'package:flutter/material.dart';
import 'package:tune_bliss/database/functions/playlist_db_function.dart';
import 'package:tune_bliss/screens/playlist/current_playlist.dart';
import '../../../model/song_model.dart';

class AddSongToPlaylist extends StatefulWidget {
  const AddSongToPlaylist(
      {super.key, required this.object, required this.song});
  final EachPlaylist object;
  final Songs song;
  @override
  State<AddSongToPlaylist> createState() => _AddSongToPlaylistState();
}

class _AddSongToPlaylistState extends State<AddSongToPlaylist> {
  late bool isadded;
  @override
  Widget build(BuildContext context) {
    isadded = widget.object.playlistSongs.contains(widget.song);
    return IconButton(
        onPressed: () {
          if (isadded == false) {
            setState(() {
              widget.object.playlistSongs.add(widget.song);
              playlistAddDB(widget.song, widget.object.playlistName);
              currentPlaylistBodyNotifier.notifyListeners();
            });
          } else {
            setState(() {
              widget.object.playlistSongs.remove(widget.song);
              playlistRemoveDB(widget.song, widget.object.playlistName);
              currentPlaylistBodyNotifier.notifyListeners();
            });
          }
        },
        icon: isadded ? Icon(Icons.remove) : Icon(Icons.add));
  }
}
