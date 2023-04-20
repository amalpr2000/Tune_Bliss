import 'package:flutter/material.dart';

import 'bottom_nav.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
                ' Settings',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: displayWidth * .2,
              ),
              Center(
                child: Image(
                  image: AssetImage('assets/logo/logo.png'),
                  width: displayWidth * .6,
                  height: displayHeight * .2,
                ),
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
                        leading: settingsIcons[index],
                        title: Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  settingItems[index],
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
                    itemCount: 3),
              )),
            ],
          ),
        )),
      ),
    );
  }
}

List settingItems = ['Privacy Policy', 'Terms and condition', 'About'];
List settingsIcons = [
  Icon(
    Icons.security_rounded,
  ),
  Icon(Icons.card_travel),
  Icon(Icons.touch_app)
];
