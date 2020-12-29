import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageBack extends StatelessWidget  {
  final Color bgColor,iconColor,titleColor;
  final Function onBackPress;
  final String appBarTitle;
  final bool isTitle;
  const PageBack({@required this.bgColor,@required this.iconColor,@required this.onBackPress,this.appBarTitle,this.isTitle=false,this.titleColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: (){
//              Navigator.pop(context);
            onBackPress();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back,color: iconColor,size: 24,),
            ),
          ),
          Spacer(),
          this.isTitle?Text(this.appBarTitle,style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 20,color:titleColor??Colors.black,fontWeight: FontWeight.w500))):Text(""),
        ],
      ),
    );
  }
}
