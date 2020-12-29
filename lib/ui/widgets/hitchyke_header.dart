import 'package:flutter/material.dart';
import 'package:hitchyke/ui/widgets/responsive_widget_builder.dart';

class Hitchyke_Header extends StatelessWidget {
  final String headerText;
  final Color headerBgColor;
  const Hitchyke_Header({@required this.headerText,@required this.headerBgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height*0.08,
        color:this.headerBgColor,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(this.headerText,style:TextStyle(fontSize:21,color:Colors.white,fontWeight:FontWeight.bold))
          ],
        )
    );
  }
}
