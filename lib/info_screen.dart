import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          children: [
            Text(
              "Information",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              "This app borrows the methodology used by Emil Abrahamsson in his Youtube videos. "
              "It is based on research by Keith Baar, who recommends 10 minutes of low-intensity training "
              "done AT MOST every 6 hours for optimal finger health/strength. "
              "It is recommended that you watch Emil's videos first before using this app. "
              "They can be found at the bottom of this page. "
              "\n"
              "\n"
              "The routine involves doing no-hangs (ie. hangboarding WITHOUT actually lifting your feet off the ground) "
              "for 10 seconds followed by a 20 second rest. You should not feel significant strain "
              "as you should only be loading 30-40% of your maximum. "
              "Please note that training tendon strength is NOT the same as muscles and overloading your fingers "
              "will only make you more susceptible to injury or irritation. "
              "\n"
              "\n"
              "To use this app, simply press the start button and follow the instructions on screen. "
              "It can be done with a doorframe if a hangboard is not available, but please make sure it is safe. "
              "The creator of this app is not liable for any damages or injury caused by finger training. "
              "During rest periods, feel free to LIGHTLY stretch your pinkies or, as recommended by Emil, work on your posture. "
              "\n"
              "\n"
              "The first video discussing methodology and the second video outline the routine used here can be found below. "
              "\n"
              "\n"
              "Good luck! "
              "\n",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.start,
            ),
            TextButton(
              onPressed: () {
                launchUrl(
                  Uri.parse("https://www.youtube.com/watch?v=sBTI9qiH4UE"),
                );
              },
              child: Text("https://www.youtube.com/watch?v=sBTI9qiH4UE"),
            ),
            TextButton(
              onPressed: () {
                launchUrl(
                  Uri.parse("https://www.youtube.com/watch?v=3FNZdixeuZw"),
                );
              },
              child: Text("https://www.youtube.com/watch?v=3FNZdixeuZw"),
            ),
            SizedBox(height: 40),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close", style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
