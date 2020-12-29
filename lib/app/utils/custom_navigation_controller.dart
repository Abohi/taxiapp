
import 'package:flutter/material.dart';

void changeScreen({@required BuildContext context,@required Widget widget}){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>widget));
}

void changeScreenReplacement({@required BuildContext context,@required Widget widget}){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>widget));
}