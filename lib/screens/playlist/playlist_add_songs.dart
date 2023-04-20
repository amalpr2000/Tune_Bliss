import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../functions/fetch_songs.dart';
import '../../model/song_model.dart';
import '../bottom_nav.dart';
import '../liked/liked_screen.dart';
import 'widget/add_song_to_playlist.dart';

class PlaylistAddSongs extends StatelessWidget {
  final EachPlaylist object;
  const PlaylistAddSongs({super.key, required this.object});

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      body: Container(
        height: displayHeight,
        width: displayWidth,
        decoration: BoxDecoration(gradient: bodyGradient),
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(
                    right: displayWidth * .05,
                    left: displayWidth * .05,
                    top: displayWidth * .05),
                child: Column(
                  children: [
                    Text(
                      'Add To Playlist',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: displayHeight * .03,
                    ),
                    Expanded(
                        child: Material(
                      color: Colors.black.withOpacity(0),
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            bool isliked;
                            if (likedSongsNotifier.value
                                .contains(allsongs[index])) {
                              isliked = true;
                            } else {
                              isliked = false;
                            }
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
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
                                id: allsongs[index].id!,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/en/e/e5/Marshmello_and_Bastille_Happier.png'),
                                ),
                              ),
                              title: Text(
                                allsongs[index].songname!,
                              ),
                              subtitle: Text(
                                allsongs[index].artist!,
                                style: TextStyle(color: Color(0xFF9DA8CD)),
                              ),
                              trailing: AddSongToPlaylist(
                                  object: object, song: allsongs[index]),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: allsongs.length),
                    )),
                  ],
                ))),
      ),
    );
  }
}
