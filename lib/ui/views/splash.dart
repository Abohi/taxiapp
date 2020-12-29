import 'package:flutter/material.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: headerColor,
      body: Container(
        width: size.width,
        child: Center(
          child: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
