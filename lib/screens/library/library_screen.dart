import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tune_bliss/screens/bottom_nav.dart';
import 'package:tune_bliss/screens/library/most_played.dart';
import 'package:tune_bliss/screens/library/recent_played.dart';

import 'package:tune_bliss/widgets/app_bar.dart';
import '../home/miniplayer.dart';
import '../splash_screen.dart';

class MyLibrary extends StatelessWidget {
  const MyLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBarRow(title: ' My Library'),
          SizedBox(
            height: displayWidth * 0.1,
          ),
          Container(
            height: displayHeight * .24,
            width: displayWidth * .5,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    blurRadius: 10,
                    color: Color(0xFF9DA8CD),
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://media.istockphoto.com/id/1205771672/vector/young-man-listen-to-music-on-headphones-music-therapy-guy-profile-avatar.jpg?s=612x612&w=0&k=20&c=CqTw8UXCSxtyyPZxJOFLdWt8GiETIbkdjRDs94-hQCI=',
                    ))),
          ),
          SizedBox(
            height: displayWidth * .1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userId,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                  onTap: () {
                    final userNameCtr = TextEditingController();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Color(0xFF07014F),
                        title: TextField(
                          controller: userNameCtr,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              hintText: 'Username'),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Cancel',
                                  style: TextStyle(color: Colors.white))),
                          TextButton(
                              onPressed: () async {
                                final userNameDb =
                                    await Hive.openBox<String>('userName');

                                if (userNameCtr.text.trim().isNotEmpty) {
                                  log('message');

                                  final userNameDb =
                                      await Hive.openBox<String>('userName');
                                  // userNameDb.add(userNameCtr.text.trim());
                                  userNameDb.putAt(userNameDb.length - 1,
                                      userNameCtr.text.trim());
                                  userId = userNameCtr.text.trim();
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    );
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ))
            ],
          ),
          SizedBox(
            height: displayWidth * .1,
          ),
          Expanded(
              child: Material(
            color: Colors.black.withOpacity(0),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  if (currentlyplaying != null) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      showBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => const MiniPlayer(),
                      );
                    });
                  }
                  return ListTile(
                    onTap: () {
                      if (index == 0) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RecentPlayed()));
                      }
                      if (index == 1) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MostPlayed()));
                      }
                    },
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    tileColor: Color(0xFF20225D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    title: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              itemName[index],
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                        Spacer()
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: displayWidth * .05,
                    ),
                itemCount: itemName.length),
          )),
        ],
      ),
    );
  }
}

List itemName = ['Recently Played', 'Most Played'];
