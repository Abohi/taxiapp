import 'package:flutter/material.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';

class Custombutton1 extends StatelessWidget {
  final String btnText;
  final Color btnTextColor;
  final Color btnBg;
  final bool isBorder;
  const Custombutton1({@required this.btnText,this.btnTextColor=Colors.white,this.btnBg,this.isBorder=false});
  @override
  Widget build(BuildContext context) {
    return Container(

        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height*0.065,

        decoration:BoxDecoration(color:btnBg??headerColor,borderRadius: BorderRadius.circular(5),border: this.isBorder?Border.all(color:Colors.blueAccent,width: 1 ):null ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(this.btnText??"Continue",style:TextStyle(fontSize:20,color:this.btnTextColor,fontWeight:FontWeight.bold))
          ],
        )
    );
  }
}