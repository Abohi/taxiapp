import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hitchyke/app/utils/custom_navigation_controller.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/screen_controllers/app_controller.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:hitchyke/ui/widgets/CustomButton1.dart';
import 'package:hitchyke/ui/widgets/hitchyke_header.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:provider/provider.dart';

class VerificationView extends StatefulWidget {
  @override
  _VerificationViewState createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final _key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var auth = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: WillPopScope(
        onWillPop: () async{
          Navigator.pop(context);
          return false;
        },
        child: SafeArea(
          child: Container(
            width: width,
            height: height,
            child: Column(
              children: <Widget>[
                Hitchyke_Header(
                  headerText: "Email Verification",
                  headerBgColor: headerColor,
                ),
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                          "Please click on the button below to verify your email account",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff898989))),
                      SizedBox(height: 40,),
                      GestureDetector(
                        child: Custombutton1(
                          btnText: "Goto Mail",
                        ),
                        onTap: () async {
                          var result = await OpenMailApp.openMailApp();
                          if (!result.didOpen && !result.canOpen) {

                            showNoMailAppsDialog(context);

                          } else if (!result.didOpen && result.canOpen) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return MailAppPickerDialog(
                                    mailApps: result.options,
                                  );
                                });
                          }
                        },
                      ),
                      SizedBox(height:20),
                      GestureDetector(
                        child: Custombutton1(
                          btnText: "Login",
                        ),
                        onTap: ()async{
                          await auth.signOut();
                          changeScreenReplacement(context: context, widget: ScreensController());
                        },
                      ),
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: ()async{
                         await auth.user.sendEmailVerification();
                         _key.currentState.showSnackBar(
                             SnackBar(content: Text("Email Verification Sent"),)
                         );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Click To ",
                            style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: headerColor.withOpacity(0.7))),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Resend",
                                  style:GoogleFonts.roboto(textStyle: TextStyle(decoration: TextDecoration.underline,fontSize: 14,fontWeight: FontWeight.normal,color: headerColor))),
                              // can add more TextSpans here...
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

   void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
