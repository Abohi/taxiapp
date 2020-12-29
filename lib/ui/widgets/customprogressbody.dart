import 'package:flutter/material.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';

class CustomProgressBody extends StatelessWidget {
  const CustomProgressBody();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.60,
      height: 70,
      color: headerColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 10,),
          Text("Loading...",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w700),),
          Spacer(),
          CircularProgressIndicator(backgroundColor: Colors.white,valueColor:  AlwaysStoppedAnimation<Color>(Colors.black54),),
          SizedBox(width: 10,),
        ],
      ),
    );
  }
}