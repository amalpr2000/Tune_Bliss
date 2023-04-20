import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../functions/fetch_songs.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/like_icon.dart';
import '../liked/liked_screen.dart';
import '../now_playing.dart';
import '../playlist/add_to_playlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarRow(
            title: ' All Songs',
          ),
          Container(
            color: Colors.transparent,
            height: 10,
          ),
          Expanded(
              child: Material(
            color: Colors.black.withOpacity(0),
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  bool isliked;
                  if (likedSongsNotifier.value.contains(allsongs[index])) {
                    isliked = true;
                  } else {
                    isliked = false;
                  }
                  return ListTile(
                    onTap: () {
                      MiniPlayer(context, index, displayHeight, displayWidth);
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
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    subtitle: Text(
                      allsongs[index].artist!,
                      style: TextStyle(
                        color: Color(0xFF9DA8CD),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LikedButton(
                            isfav: likedSongsNotifier.value
                                .contains(allsongs[index]),
                            currentSongs: allsongs[index]),
                        PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert_rounded,
                            color: Color(0xFF9DA8CD),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
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
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ))
                          ],
                          onSelected: (value) =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AddToPlaylist(song: allsongs[index]),
                          )),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: allsongs.length),
          )),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.transparent,
      //   onPressed: () {
      //     double displayWidth = MediaQuery.of(context).size.width;
      //     double displayHeight = MediaQuery.of(context).size.height;

      //     musicBottomPage(context, displayHeight, displayWidth);
      //   },
      //   child: Stack(children: [
      //     Container(
      //       margin: EdgeInsets.all(15),
      //       color: Color(0xFF20225D),
      //     ),
      //     Icon(
      //       Icons.play_circle_fill_rounded,
      //       color: Colors.white,
      //       size: 55,
      //     ),
      //   ]),
      // ));
    );
  }

  PersistentBottomSheetController<dynamic> MiniPlayer(BuildContext context,
      int index, double displayHeight, double displayWidth) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return ColoredBox(
          color: Color(0xFF030230),
          child: InkWell(
            onTap: () => musicBottomPage(context, displayHeight, displayWidth),
            child: Container(
              height: 76,
              decoration: BoxDecoration(
                color: Color(0xFF07014F),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  QueryArtworkWidget(
                    artworkHeight: 60,
                    artworkWidth: 65,
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
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      allsongs[index].songname!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Spacer(),
                  IconNew(
                      size: 40,
                      icon: Icons.skip_previous_rounded,
                      btnState: isPlay),
                  IconNew(
                      size: 40,
                      icon: Icons.play_circle_fill_rounded,
                      btnState: isPlay),
                  IconNew(
                      size: 40,
                      icon: Icons.skip_next_rounded,
                      btnState: isPlay),
                  Spacer()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
