import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../model/song_model.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/like_icon.dart';
import '../now_playing.dart';
import '../playlist/add_to_playlist.dart';

class Liked extends StatefulWidget {
  Liked({
    super.key,
    required this.displayWidth,
  });

  final double displayWidth;

  @override
  State<Liked> createState() => _LikedState();
}

ValueNotifier<List<Songs>> likedSongsNotifier = ValueNotifier([]);

class _LikedState extends State<Liked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarRow(
              title: ' Liked Songs',
            ),
            Container(
              color: Colors.transparent,
              height: 15,
            ),
            ValueListenableBuilder(
              valueListenable: likedSongsNotifier,
              builder: (context, value, child) => (likedSongsNotifier
                      .value.isEmpty)
                  ? Center(
                      child: Text(
                        'Add songs to liked',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Expanded(
                      child: Material(
                      color: Colors.black.withOpacity(0),
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              tileColor: Color(0xFF20225D),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              leading: QueryArtworkWidget(
                                artworkHeight: 60,
                                artworkWidth: 60,
                                size: 3000,
                                quality: 100,
                                artworkQuality: FilterQuality.high,
                                artworkBorder: BorderRadius.circular(12),
                                artworkFit: BoxFit.cover,
                                id: likedSongsNotifier.value[index].id!,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/en/e/e5/Marshmello_and_Bastille_Happier.png'),
                                ),
                              ),
                              title: Text(
                                likedSongsNotifier.value[index].songname!,
                              ),
                              subtitle: Text(
                                likedSongsNotifier.value[index].artist!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Color(0xFF9DA8CD)),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LikedButton(
                                      isfav: true,
                                      currentSongs:
                                          likedSongsNotifier.value[index]),
                                  PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert_rounded,
                                      color: Color(0xFF9DA8CD),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Color(0xFF07014F),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                          value: 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(Icons.playlist_add),
                                              Text(
                                                'Add to Playlist',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ))
                                    ],
                                    onSelected: (value) => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => AddToPlaylist(
                                          song:
                                              likedSongsNotifier.value[index]),
                                    )),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, likedSongIndex) =>
                              SizedBox(
                                height: 10,
                              ),
                          itemCount: likedSongsNotifier.value.length),
                    )),
            )
          ],
        ));

    floatingActionButton:
    FloatingActionButton(
      backgroundColor: Colors.transparent,
      onPressed: () {
        double displayWidth = MediaQuery.of(context).size.width;
        double displayHeight = MediaQuery.of(context).size.height;

        musicBottomPage(context, displayHeight, displayWidth);
      },
      child: Stack(children: [
        Container(
          margin: EdgeInsets.all(15),
          color: Color(0xFF20225D),
        ),
        Icon(
          Icons.play_circle_fill_rounded,
          color: Colors.white,
          size: 55,
        ),
      ]),
    );
  }
}

void snack(BuildContext context,
    {required String message, required Color color}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(message),
      backgroundColor: color,
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 21),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
}
