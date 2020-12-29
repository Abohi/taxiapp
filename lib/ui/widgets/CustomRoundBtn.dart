import 'package:flutter/material.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';

class CustomRoundBtn extends StatefulWidget {
  final VoidCallback onTap;
  final bool selected;
  final String roleText1,roleText2;
  const CustomRoundBtn({Key key, this.onTap, this.selected,this.roleText1,this.roleText2}) : super(key: key);

  @override
  _CustomRoundBtnState createState() => _CustomRoundBtnState();
}

class _CustomRoundBtnState extends State<CustomRoundBtn> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    isSelected = widget.selected;
    return GestureDetector(
      onTap: (){
        setState(() {
           isSelected = !isSelected;
        });
         if (widget.onTap != null) widget.onTap();
      },
          child: Container(
            width: 130,
            height: 130,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(shape:BoxShape.circle,color:headerColor),
            child: Container(
        decoration: BoxDecoration(
              color: isSelected?headerColor:Color(0xffF0F0F0), shape:BoxShape.circle),
        child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(widget.roleText1,
                      style: TextStyle(color: isSelected?headerColor:Color(0xffD56F25), fontSize: 13.0)),
                  SizedBox(height:10),
                  Text(widget.roleText2,
                      style: TextStyle(color: isSelected?Color(0xffFFFFFF):headerColor, fontSize: 13.0)),
                ],
              )),
      ),
          ),
    );
  }
}
