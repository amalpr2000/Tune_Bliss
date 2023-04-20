
import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'bottom_nav.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final userNamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: displayHeight,
          width: displayWidth,
          decoration: BoxDecoration(gradient: bodyGradient),
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.only(
              right: displayWidth * .05,
              left: displayWidth * .05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Skip',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BottomNav(),
                            )),
                        icon: Icon(
                          Icons.skip_next,
                          color: Colors.white,
                        )),
                  ],
                ),
                Center(
                  child: Image(
                    image: AssetImage('assets/logo/logo.png'),
                    width: displayWidth * .6,
                    height: displayHeight * .4,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: userNamecontroller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.person,
                      size: 25,
                    ),
                    // suffixIcon: Icon(Icons.clear_rounded),
                    hintText: 'Enter your name',
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
                  height: 30,
                ),
                ActionSlider.standard(
                  backgroundColor: Color(0xFF07014F),
                  toggleColor: Color(0xFF20225D),
                  icon: Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  successIcon: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                  ),
                  failureIcon: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.58,
                  actionThresholdType: ThresholdType.release,
                  child: Text(
                    'Slide to continue',
                    style: TextStyle(color: Colors.white),
                  ),
                  action: (controller) async {
                    controller.loading(); //starts loading animation
                    await Future.delayed(const Duration(seconds: 3));
                    String userName = userNamecontroller.text;
                    if (userName.isNotEmpty) {
                      controller.success(); //starts success animation
                      await Future.delayed(const Duration(seconds: 2));

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => BottomNav()));
                    } else {
                      await Future.delayed(const Duration(seconds: 1));
                      controller.reset(); //resets the slider
                    }
                  },
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
