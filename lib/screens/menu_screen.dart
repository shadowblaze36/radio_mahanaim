import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redirect_icon/redirect_icon.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff3be9ff), Colors.lightGreenAccent],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.jpeg'),
                  radius: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RedirectSocialIcon(
                      url: "https://www.radiomahanaimhn.com",
                      icon: FontAwesomeIcons.earthAmericas,
                      radius: 25,
                      size: 30,
                      iconColor: Colors.white,
                      circleAvatarColor: Colors.green,
                    ),
                    SizedBox(width: 12),
                    RedirectSocialIcon(
                      url:
                          "https://www.facebook.com/RadioOnlineMahanaimHonduras",
                      icon: FontAwesomeIcons.facebook,
                      radius: 25,
                      size: 30,
                      iconColor: Colors.white,
                      circleAvatarColor: Colors.blueAccent,
                    ),
                    SizedBox(width: 12),
                    RedirectSocialIcon(
                      url: "https://www.instagram.com/mahanaimhn/",
                      icon: FontAwesomeIcons.instagram,
                      radius: 25,
                      size: 30,
                      iconColor: Colors.white,
                      circleAvatarColor: Colors.pink,
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
