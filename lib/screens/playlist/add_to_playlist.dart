import 'package:flutter/material.dart';

import '../../database/functions/playlist_db_function.dart';
import '../../model/song_model.dart';
import '../bottom_nav.dart';
import '../liked/liked_screen.dart';
import 'playlist_screen.dart';

class AddToPlaylist extends StatefulWidget {
  AddToPlaylist({super.key, required this.song});
  Songs song;

  @override
  AddToPlaylistState createState() => AddToPlaylistState();
}

class AddToPlaylistState extends State<AddToPlaylist> {
  final playlistNameController = TextEditingController();

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add To Playlist',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration:
                                      BoxDecoration(gradient: bodyGradient),
                                  height: 450,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Text(
                                          'Give the playlist name.',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        TextField(
                                          controller: playlistNameController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixIcon: Icon(
                                              Icons.playlist_play_rounded,
                                              size: 25,
                                            ),
                                            hintText: 'Playlist name',
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                elevation: 2,
                                                backgroundColor:
                                                    Color(0xFF20225D)),
                                            onPressed: () {
                                              playlistcreating(
                                                  playlistNameController.text);
                                              setState(() {
                                                playlistNameController.clear();
                                              });
                                              snack(context,
                                                  message: 'Playlist Added',
                                                  color: Color(0xFF4CAF50));
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Create'))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.add_box_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    (playlist.isEmpty)
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 250,
                                ),
                                Text(
                                  'No Playlist Found',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: GridView.builder(
                              itemCount: playlist.length,
                              physics: BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 30,
                                      mainAxisSpacing: 30),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  highlightColor: Colors.white,
                                  onTap: () {
                                    if (playlist[index]
                                        .playlistSongs
                                        .contains(widget.song)) {
                                      snack(context,
                                          message: 'Song is already exist',
                                          color: Colors.red);
                                    } else {
                                      snack(context,
                                          message:
                                              'Song is added to ${playlist[index].playlistName}',
                                          color: Colors.green);
                                    }

                                    if (!playlist[index]
                                        .playlistSongs
                                        .contains(widget.song)) {
                                      playlist[index]
                                          .playlistSongs
                                          .add(widget.song);
                                    }

                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/playlistcover.jpg'))),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20)),
                                                    color: Colors.black
                                                        .withOpacity(.5),
                                                  ),
                                                  width: double.infinity,
                                                  height: 30,
                                                  child: Center(
                                                    child: Text(
                                                      playlist[index]
                                                          .playlistName,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )),
                                            ],
                                          )
                                        ],
                                      )),
                                );
                              },
                            ),
                          ),
                  ],
                ))),
      ),
    );
  }
}
