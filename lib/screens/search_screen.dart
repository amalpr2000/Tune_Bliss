import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:tune_bliss/functions/fetch_songs.dart';
import 'package:tune_bliss/model/song_model.dart';
import 'package:tune_bliss/screens/home/home_screen.dart';
import 'package:tune_bliss/screens/home/miniplayer.dart';
import 'package:tune_bliss/screens/now_playing.dart';
import 'package:tune_bliss/widgets/like_icon.dart';
import 'bottom_nav.dart';
import 'liked/liked_screen.dart';
import 'playlist/add_to_playlist.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  final _searchController = TextEditingController();
  List<Songs> searchList = List<Songs>.from(allsongs);
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
              top: displayWidth * .06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' Search',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchList = allsongs
                        .where((element) => element.songname!
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 25,
                  ),
                  // suffixIcon: Icon(Icons.clear_rounded),
                  hintText: 'Search',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
              SizedBox(
                height: displayHeight * .03,
              ),
              Expanded(
                  child: Material(
                color: Colors.black.withOpacity(0),
                child: searchList.isEmpty
                    ? Center(
                        child: Text(
                        'No Song Found',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                    : ListView.separated(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          // bool isliked;
                          // if (likedSongs.contains(song[index])) {
                          //   isliked = true;
                          // } else {
                          //   isliked = false;
                          // }
                          return ListTile(
                            onTap: () {
                              int idx = 0;
                              for (idx = 0; idx < allsongs.length; idx++) {
                                if (searchList[index].id == allsongs[idx].id) {
                                  break;
                                }
                              }
                              playingAudio(allsongs, idx);
                              home.notifyListeners();
                              // Navigator.pop(context);
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => NowPlaying(),
                              ));
                            },
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            tileColor: Color(0xFF20225D),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            leading: Container(
                              height: 60,
                              width: 60,
                              child: QueryArtworkWidget(
                                artworkHeight: 60,
                                artworkWidth: 60,
                                size: 3000,
                                quality: 100,
                                artworkQuality: FilterQuality.high,
                                artworkBorder: BorderRadius.circular(12),
                                artworkFit: BoxFit.cover,
                                id: searchList[index].id!,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/en/e/e5/Marshmello_and_Bastille_Happier.png'),
                                ),
                              ),
                            ),
                            title: Text(
                              searchList[index].songname!,
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                            ),
                            subtitle: Text(
                              searchList[index].artist!,
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
                                        .contains(searchList[index]),
                                    currentSongs: searchList[index]),
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ))
                                  ],
                                  onSelected: (value) => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) =>
                                        AddToPlaylist(song: searchList[index]),
                                  )),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: searchList.length),
              )),
            ],
          ),
        )),
      ),
    );
  }
}
