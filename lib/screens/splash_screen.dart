import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tune_bliss/screens/playlist/playlist_screen.dart';
import 'package:tune_bliss/screens/user_details.dart';

import '../database/model/liked_model/liked_model.dart';
import '../database/model/playlist_model/playlist_model.dart';
import '../functions/fetch_songs.dart';
import '../model/song_model.dart';
import 'bottom_nav.dart';
import 'liked/liked_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final audioQuery = OnAudioQuery();
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      await fetchSongs();

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LandingPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: displayHeight,
        width: displayWidth,
        decoration: BoxDecoration(gradient: bodyGradient),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(
            right: displayWidth * .05,
            left: displayWidth * .05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image(
                  image: AssetImage('assets/logo/logo.png'),
                  width: displayWidth * .6,
                  height: displayHeight * .2,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  goToLandingPage() async {}

  fetchSongs() async {
    final status = await requestPermission();
    if (status) {
      List<SongModel> fetchsongs = await audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      for (SongModel element in fetchsongs) {
        if (element.fileExtension == 'mp3') {
          allsongs.add(Songs(
              songname: element.displayNameWOExt,
              artist: element.artist,
              duration: element.duration,
              id: element.id,
              songurl: element.uri));
        }
      }
      favFetching();
      playlistfetch();
    }
  }

  Future favFetching() async {
    List<LikedSongs> favSongCheck = [];
    Box<LikedSongs> likeddb = await Hive.openBox('likedsongs');

    favSongCheck.addAll(likeddb.values);

    for (var favs in favSongCheck) {
      int count = 0;
      for (var songs in allsongs) {
        if (favs.id == songs.id) {
          likedSongsNotifier.value.add(songs);
          continue;
        } else {
          count++;
        }
      }
      if (count == allsongs.length) {
        var key = favs.key;
        likeddb.delete(key);
      }
    }
    likeddb.close();
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

  Future<bool> requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
