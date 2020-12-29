import 'package:flutter/material.dart';
import 'package:hitchyke/app/utils/custom_navigation_controller.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:hitchyke/ui/views/complete_profile/driverbio_data.dart';
import 'package:hitchyke/ui/widgets/CustomButton1.dart';
import 'package:hitchyke/ui/widgets/CustomRoundBtn.dart';
import 'package:hitchyke/ui/widgets/hitchyke_header.dart';


class RegisterRoleView extends StatefulWidget {


  const RegisterRoleView();
  @override
  _RegisterRoleViewState createState() => _RegisterRoleViewState();
}

class _RegisterRoleViewState extends State<RegisterRoleView> {
  bool rnPassenger=true; bool rnDriver = false;
  @override
  void initState() {

  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hitchyke_Header(headerText: "Select Your Role", headerBgColor: headerColor,),
                SizedBox(height: 80),
                Column(

                    children:[
                      Center(child: Text("Select your role",style:TextStyle(fontSize:20,color:Colors.black,fontWeight: FontWeight.bold))),
                      SizedBox(height:15),
                      Center(
                        child: Column(

                          children: <Widget>[
                            CustomRoundBtn(
                              roleText1: "I am",
                              roleText2: "Passenger",
                              selected: rnPassenger,
                              onTap: () {
                                setState(() {
                                  rnPassenger = true;
                                  rnDriver = false;
                                });
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            CustomRoundBtn(
                                roleText1: "I am",
                                roleText2: "Driver",
                                selected: rnDriver,
                                onTap: () {
                                  setState(() {
                                    rnPassenger = false;
                                    rnDriver = true;
                                  });
                                })
                          ],
                        ),
                      ),
                    ]),
                Expanded(child:Text("")),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:50.0,horizontal: 20),
                  child: GestureDetector(onTap:(){
                    if(this.rnDriver){
                      changeScreen(context: context, widget: DriverBioData(roleType: "Drivers"));
                    }else if(this.rnPassenger){
                      changeScreen(context: context, widget: DriverBioData(roleType: "Hikers"));
                    }
                  },
                      child: Custombutton1(btnText: "Continue",btnBg: headerColor,)),
                ),
              ]),
        ),
      ),
    );;
  }
}



