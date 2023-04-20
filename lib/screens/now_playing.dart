import 'package:flutter/material.dart';
import 'bottom_nav.dart';

bool isPlay = true;
Future<dynamic> musicBottomPage(
    BuildContext context, double displayHeight, double displayWidth) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
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
                        'Blinding Lights ',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Weekend',
                        style:
                            TextStyle(color: Color(0xFF9DA8CD), fontSize: 15),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.playlist_add,
                        size: 30,
                        color: Colors.white,
                      )),
                  // LikedButton(isfav: false), currentSongs: currentSongs),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              LinearProgressIndicator(
                value: .5,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconNew(
                      size: 30, icon: Icons.shuffle_rounded, btnState: isPlay),
                  IconNew(
                      size: 50,
                      icon: Icons.skip_previous_rounded,
                      btnState: isPlay),
                  isPlay == false
                      ? IconNew(
                          size: 80,
                          icon: Icons.play_circle_fill_rounded,
                          btnState: isPlay)
                      : IconNew(
                          size: 80,
                          icon: Icons.pause_circle_filled_rounded,
                          btnState: isPlay),
                  IconNew(
                      size: 50,
                      icon: Icons.skip_next_rounded,
                      btnState: isPlay),
                  IconNew(
                      size: 30, icon: Icons.repeat_rounded, btnState: isPlay),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class IconNew extends StatefulWidget {
  IconNew({
    super.key,
    required this.size,
    required this.icon,
    required this.btnState,
  });
  bool btnState;
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
        onPressed: () {
          if (isPlay == true) {
            isPlay = false;
            setState(() {});
          } else {
            isPlay = true;
            setState(() {});
          }
        },
        icon: Icon(widget.icon));
  }
}
