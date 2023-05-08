import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_bliss/database/functions/most_played_function.dart';
import 'package:tune_bliss/model/song_model.dart';
import 'package:tune_bliss/screens/home/miniplayer.dart';
import 'package:tune_bliss/screens/liked/liked_screen.dart';
import 'package:tune_bliss/screens/playlist/add_to_playlist.dart';
import 'package:tune_bliss/widgets/like_icon.dart';
import '../functions/fetch_songs.dart';
import 'bottom_nav.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  bool isenteredtomostplayed = false;
  bool isrepeat = false;
  bool isshuffle = false;
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(body: SingleChildScrollView(
      child: playerMini.builderCurrent(
        builder: (context, playing) {
          int id = int.parse(playing.audio.audio.metas.id!);
          currentSongFinder(id);
          bool isenteredtomostplayed = false;
          return Container(
            height: displayHeight,
            width: displayWidth,
            decoration: BoxDecoration(gradient: bodyGradient),
            child: Padding(
              padding: EdgeInsets.only(
                  right: displayWidth * .05,
                  left: displayWidth * .05,
                  top: displayWidth * .05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: displayWidth * .05,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: EdgeInsets.all(displayWidth * .03),
                      child: Center(
                        child: Container(
                          height: displayWidth * .012,
                          width: displayWidth * .08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF9DA8CD)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displayWidth * .18,
                  ),
                  Center(
                    child: Container(
                      height: displayHeight * .4,
                      width: displayWidth * .85,
                      child: QueryArtworkWidget(
                        size: 3000,
                        quality: 100,
                        keepOldArtwork: true,
                        artworkQuality: FilterQuality.high,
                        artworkBorder: BorderRadius.circular(10),
                        artworkFit: BoxFit.cover,
                        id: int.parse(playing.audio.audio.metas.id!),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurStyle: BlurStyle.outer,
                            blurRadius: 10,
                            color: Color(0xFF9DA8CD),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displayWidth * .22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            playerMini.getCurrentAudioTitle,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            playerMini.getCurrentAudioArtist,
                            style: TextStyle(
                                color: Color(0xFF9DA8CD), fontSize: 15),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AddToPlaylist(song: currentlyplaying!),
                            ));
                          },
                          icon: Icon(
                            Icons.playlist_add,
                            size: 30,
                            color: Colors.white,
                          )),
                      LikedButton(
                          isfav: likedSongsNotifier.value
                              .contains(currentlyplaying),
                          currentSongs: currentlyplaying!),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  playerMini.builderRealtimePlayingInfos(
                      builder: (context, infos) {
                    Duration currentposition = infos.currentPosition;
                    Duration totalduration = infos.duration;
                    double currentposvalue =
                        currentposition.inMilliseconds.toDouble();
                    double totalvalue = totalduration.inMilliseconds.toDouble();
                    double value = currentposvalue / totalvalue;
                    if (!isenteredtomostplayed && value > 0.5) {
                      int id = int.parse(playing.audio.audio.metas.id!);
                      mostplayedaddtodb(id);
                      isenteredtomostplayed = true;
                    }
                    return ProgressBar(
                      progress: currentposition,
                      // buffered: Duration(milliseconds: 2000),
                      total: totalduration,
                      progressBarColor: Colors.white,
                      baseBarColor: Color(0xFF9DA8CD),
                      bufferedBarColor: Color.fromARGB(0, 5, 58, 234),
                      timeLabelTextStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      thumbColor: Color.fromARGB(255, 255, 255, 255),
                      onSeek: (to) {
                        playerMini.seek(to);
                      },
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              playerMini.toggleShuffle();
                            });
                          },
                          icon: playerMini.isShuffling.value
                              ? Icon(
                                  Icons.shuffle_on_rounded,
                                  size: 30,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.shuffle_rounded,
                                  size: 30,
                                  color: Colors.white,
                                )),
                      GestureDetector(
                        onTap: () {
                          playerMini.previous();
                          setState(() {});
                        },
                        child: Icon(
                          color: Colors.white,
                          size: 50,
                          Icons.skip_previous_rounded,
                        ),
                      ),
                      PlayerBuilder.isPlaying(
                          player: playerMini,
                          builder: (context, isPlaying) => InkWell(
                                onTap: () async {
                                  await playerMini.playOrPause();
                                  setState(() {
                                    isPlaying = !isPlaying;
                                  });
                                },
                                child: (isPlaying)
                                    ? Icon(
                                        size: 80,
                                        Icons.pause_circle_filled_rounded,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        size: 80,
                                        Icons.play_circle_fill_rounded,
                                        color: Colors.white,
                                      ),
                              )),
                      GestureDetector(
                        onTap: () async {
                          await playerMini.next();
                          setState(() {});
                        },
                        child: Icon(
                          color: Colors.white,
                          size: 50,
                          Icons.skip_next_rounded,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (isrepeat == false) {
                                isrepeat = true;
                                playerMini.setLoopMode(LoopMode.single);
                              } else {
                                isrepeat = false;
                                playerMini.setLoopMode(LoopMode.playlist);
                              }
                            });
                          },
                          icon: isrepeat
                              ? Icon(
                                  Icons.repeat_on_rounded,
                                  size: 30,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.repeat_rounded,
                                  size: 30,
                                  color: Colors.white,
                                )),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}

// Future<dynamic> musicBottomPage(
//     BuildContext context, double displayHeight, double displayWidth) {
//   return showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     builder: (BuildContext context) {
//       return playerMini.builderCurrent(builder: (context, playing) {
//         int id = int.parse(playing.audio.audio.metas.id!);
//         currentSongFinder(id);
//         return Container(
//           height: displayHeight,
//           width: displayWidth,
//           decoration: BoxDecoration(gradient: bodyGradient),
//           child: Padding(
//             padding: EdgeInsets.only(
//                 right: displayWidth * .05,
//                 left: displayWidth * .05,
//                 top: displayWidth * .05),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: displayWidth * .05,
//                 ),
//                 InkWell(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: Padding(
//                     padding: EdgeInsets.all(displayWidth * .03),
//                     child: Center(
//                       child: Container(
//                         height: displayWidth * .012,
//                         width: displayWidth * .08,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Color(0xFF9DA8CD)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: displayWidth * .18,
//                 ),
//                 Center(
//                   child: Container(
//                     height: displayHeight * .4,
//                     width: displayWidth * .85,
//                     decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             blurStyle: BlurStyle.outer,
//                             blurRadius: 10,
//                             color: Color(0xFF9DA8CD),
//                           )
//                         ],
//                         borderRadius: BorderRadius.circular(20),
//                         image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage(
//                               'https://pub-static.fotor.com/assets/projects/pages/c7d9749a29fc44a5a54da2bba21165af/gradient-cool-new-bullet-e52b9cac8825471981dc12dd343176da.jpg',
//                             ))),
//                   ),
//                 ),
//                 SizedBox(
//                   height: displayWidth * .22,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           playerMini.getCurrentAudioTitle,
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           playerMini.getCurrentAudioArtist,
//                           style:
//                               TextStyle(color: Color(0xFF9DA8CD), fontSize: 15),
//                         ),
//                       ],
//                     ),
//                     Spacer(),
//                     IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.playlist_add,
//                           size: 30,
//                           color: Colors.white,
//                         )),
//                     // LikedButton(isfav: false), currentSongs: currentSongs),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 playerMini.builderRealtimePlayingInfos(
//                     builder: (context, infos) {
//                   Duration currentposition = infos.currentPosition;
//                   Duration totalduration = infos.duration;
//                   return ProgressBar(
//                     progress: currentposition,
//                     // buffered: Duration(milliseconds: 2000),
//                     total: totalduration,
//                     progressBarColor: const Color.fromARGB(255, 182, 75, 249),
//                     baseBarColor: const Color.fromARGB(190, 255, 255, 255),
//                     bufferedBarColor: const Color.fromARGB(255, 182, 75, 249),
//                     timeLabelTextStyle: TextStyle(
//                       color: const Color.fromARGB(255, 182, 75, 249),
//                     ),
//                     thumbColor: const Color.fromARGB(255, 182, 75, 249),
//                     onSeek: (to) {
//                       playerMini.seek(to);
//                     },
//                   );
//                 }),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     IconNew(
//                       size: 30,
//                       icon: Icons.shuffle_rounded,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         playerMini.previous();
//                       },
//                       child: IconNew(
//                         size: 50,
//                         icon: Icons.skip_previous_rounded,
//                       ),
//                     ),
//                     PlayerBuilder.isPlaying(
//                         player: playerMini,
//                         builder: (context, isPlaying) => InkWell(
//                               onTap: () async {
//                                 await playerMini.playOrPause();
//                                 isPlaying = !isPlaying;
//                               },
//                               child: (isPlaying)
//                                   ? IconNew(
//                                       size: 80,
//                                       icon: Icons.play_circle_fill_rounded,
//                                     )
//                                   : IconNew(
//                                       size: 80,
//                                       icon: Icons.pause_circle_filled_rounded,
//                                     ),
//                             )),
//                     InkWell(
//                       onTap: () {
//                         playerMini.next();
//                       },
//                       child: IconNew(
//                         size: 50,
//                         icon: Icons.skip_next_rounded,
//                       ),
//                     ),
//                     IconNew(
//                       size: 30,
//                       icon: Icons.repeat_rounded,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
//     },
//   );
// }

class IconNew extends StatefulWidget {
  IconNew({
    super.key,
    required this.size,
    required this.icon,
  });

  double size;
  IconData icon;

  @override
  State<IconNew> createState() => _IconNewState();
}

class _IconNewState extends State<IconNew> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Colors.white,
        iconSize: widget.size,
        onPressed: () {},
        icon: Icon(widget.icon));
  }
}
