import 'package:flutter/material.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';

class DashBoardHeader extends StatelessWidget {
  final String headTitle;
  const DashBoardHeader({this.headTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.06,
      width:MediaQuery.of(context).size.width ,
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent,width: 2),
          color: colorBackground,
          borderRadius: BorderRadius.circular(15)),
      child: Align(child: Padding(
        padding: const EdgeInsets.only(left:10.0),
        child: Text(headTitle??"Driver DashBoard"),
      ),
      alignment: Alignment.centerLeft,),
    );
  }
}