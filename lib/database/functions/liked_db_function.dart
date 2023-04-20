import 'package:hive_flutter/hive_flutter.dart';

import '../../model/song_model.dart';
import '../../screens/liked/liked_screen.dart';
import '../model/liked_model/liked_model.dart';

addToLiked(Songs song) async {
  likedSongsNotifier.value.add(song);

  Box<LikedSongs> likeddb = await Hive.openBox('likedsongs');

  LikedSongs likedSongModel = LikedSongs(id: song.id);

  likeddb.add(likedSongModel);
  likeddb.close();
}

removeFromLiked(Songs song) async {
  likedSongsNotifier.value.remove(song);
  List<LikedSongs> templist = [];
  Box<LikedSongs> likeddb = await Hive.openBox('likedsongs');
  templist.addAll(likeddb.values);

  for (var elements in templist) {
    if (elements.id == song.id) {
      var key = elements.key;
      likeddb.delete(key);
      break;
    }
  }
}
