import 'package:flutter/material.dart';
import 'package:tune_bliss/widgets/app_bar.dart';
import '../now_playing.dart';

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
                        'https://pub-static.fotor.com/assets/projects/pages/c7d9749a29fc44a5a54da2bba21165af/gradient-cool-new-bullet-e52b9cac8825471981dc12dd343176da.jpg',
                      ))),
            ),
            SizedBox(
              height: displayWidth * .1,
            ),
            Text(
              ' User #4384783 ',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: displayWidth * .1,
            ),
            Expanded(
                child: Material(
              color: Colors.black.withOpacity(0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
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
        floatingActionButton: FloatingActionButton(
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
        ));
  }
}

List itemName = ['Recently Played', 'Most Played'];
