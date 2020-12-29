
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hitchyke/app/utils/custom_navigation_controller.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:hitchyke/ui/views/complete_profile/vehicle_information.dart';
import 'package:hitchyke/ui/widgets/CustomButton1.dart';
import 'package:hitchyke/ui/widgets/customprogressbody.dart';
import 'package:hitchyke/ui/widgets/pageback_widget.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';


class DriverBioData_OtherInfo extends StatefulWidget {
  final String name,phoneNo,email,gender,userType,address,maritalStatus,occupation;
  final DateTime dateOfBirth;
  final File profileImage;
  const DriverBioData_OtherInfo ({this.name,this.phoneNo,this.email,this.gender,this.userType,this.address,this.dateOfBirth,this.maritalStatus,this.occupation,this.profileImage});
  @override
  _DriverBioData_OtherInfoState createState() => _DriverBioData_OtherInfoState();
}

class _DriverBioData_OtherInfoState extends State<DriverBioData_OtherInfo> {
  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String dropdownValueBank = 'Select Bank';
  String dropdownValueOccupation = 'Student';
  String dropdownValueGender = 'Male';
  String dropdownValueRelationship = 'Sister';
  final format = DateFormat("yyyy-MM-dd");
  ProgressDialog progressDialog;
  String _acctName,_nameOfNextOfKin,_phoneNoOfNextOfKin,_addressOfNextOfKin,_acctNo;
@override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<UserProvider>(context);
    var width = MediaQuery.of(context).size.width;
    progressDialog = ProgressDialog(context,type:ProgressDialogType.Normal,isDismissible: false,customBody: CustomProgressBody());
    return Scaffold(
      key: _key,
      body: WillPopScope(
        onWillPop: ()async{
         Navigator.pop(context);
         return true;
        },
        child: Stack(children: [
          Image.asset(
            'assets/images/bg.jpg',
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 13,
                ),
                PageBack(bgColor: const Color(0xff000000), iconColor: Colors.white,isTitle: true,appBarTitle: "Hitchyke",titleColor: headerColor, onBackPress: (){
                   Navigator.pop(context);
                }),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: widget.profileImage==null?CircleAvatar(
                    radius: width*0.1,
                    backgroundImage: AssetImage("assets/images/profilephoto.png"),
                  ):CircleAvatar(
                    radius: width * 0.1,
                    backgroundImage: FileImage(widget.profileImage),
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: Text(
                    widget.name??"",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: colorBackground),
                  ),
                ),
                Center(
                  child: Text(
                    widget.userType??"",
                    style: TextStyle(
                        fontSize: 10,
                        color: colorSecondary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    "Please complete your profile by providing accurate information below",
                    style: TextStyle(
                        fontSize:16,
                        color: colorBackground,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Bio Data Other Info",
                    style: TextStyle(
                        fontSize: 14,
                        color: colorBackground,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
               Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Bank Details",
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xffE0B37E),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: DropdownButton<String>(
                              value: dropdownValueBank,
                              icon: Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Spacer(),
                                    Transform.rotate(
                                      child: SizedBox(
                                        width: 18,
                                        height: 13.41,
                                        child: Image.asset(
                                            'assets/images/backicon.png',
                                            color: Color(0xff000000)),
                                      ),
                                      angle: 4.7,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Color(0xff000000)),
                              underline: Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValueBank = newValue;
                                  switch (dropdownValueBank) {
                                    case 'GT Bank':
                                      break;
                                    case 'UBA':
                                      break;
                                    case 'Zenith Bank':
                                      break;
                                  }
                                });
                              },
                              items: <String>[
                                'Select Bank',
                                'GT Bank',
                                'UBA',
                                'Zenith Bank',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 12, bottom: 12),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Account Name",
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xffE0B37E),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              autofocus: false,
                              validator: (val){
                                if(val.isEmpty) return "Field must not be empty";
                                else
                                  return null;
                              },
                              onChanged: (val){
                                _acctName = val;
                              },
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontSize: 18.0, color: colorPrimary),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Account Number",
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xffE0B37E),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              validator: (val){
                                if(val.isEmpty) return "Field must not be empty";
                                else
                                  return null;
                              },
                              onChanged: (val){
                                _acctNo =val;
                              },
                              autofocus: false,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 18.0, color: colorPrimary),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      SizedBox(height: 13,),
                      Container(width: width,height: 2,color:headerColor,),
                      SizedBox(height: 13,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Name of Next of Kin",
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xffE0B37E),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              validator: (val){
                                if(val.isEmpty) return "Field must not be empty";
                                else
                                  return null;
                              },
                              onChanged: (val){
                                _nameOfNextOfKin =val;
                              },
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontSize: 18.0, color: colorPrimary),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 13,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Phone",
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xffE0B37E),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              validator: (val){
                                if(val.isEmpty) return "Field must not be empty";
                                else if(val.length<11) return "Field must not be less than 11 digit";
                                else
                                  return null;
                              },
                              onChanged: (val){
                                _phoneNoOfNextOfKin =val;
                              },
                              autofocus: false,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 18.0, color: colorPrimary),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 13,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Gender",
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xffE0B37E),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: DropdownButton<String>(
                              value: dropdownValueGender,
                              icon: Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Spacer(),
                                    Transform.rotate(
                                      child: SizedBox(
                                        width: 18,
                                        height: 13.41,
                                        child: Image.asset(
                                            'assets/images/backicon.png',
                                            color: Color(0xff000000)),
                                      ),
                                      angle: 4.7,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Color(0xff000000)),
                              underline: Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValueGender = newValue;
                                  switch (dropdownValueGender) {
                                    case 'Male':
                                      break;
                                    case 'Female':
                                      break;
                                  }
                                });
                              },
                              items: <String>[
                                'Male',
                                'Female',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 12, bottom: 12),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xffE0B37E),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              validator: (val){
                                if(val.isEmpty) return "Field must not be empty";
                                else
                                  return null;
                              },
                              onChanged: (val){
                                _addressOfNextOfKin =val;
                              },
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(fontSize: 18.0, color: colorPrimary),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "RelationShip",
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xffE0B37E),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: DropdownButton<String>(
                              value: dropdownValueRelationship,
                              icon: Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Spacer(),
                                    Transform.rotate(
                                      child: SizedBox(
                                        width: 18,
                                        height: 13.41,
                                        child: Image.asset(
                                            'assets/images/backicon.png',
                                            color: Color(0xff000000)),
                                      ),
                                      angle: 4.7,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Color(0xff000000)),
                              underline: Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValueRelationship = newValue;
                                  switch (dropdownValueRelationship) {
                                    case 'Sister':
                                      break;
                                    case 'Brother':
                                      break;
                                  }
                                });
                              },
                              items: <String>[
                                'Sister',
                                'Brother',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 12, bottom: 12),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Occupation",
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xffE0B37E),
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: DropdownButton<String>(
                              value: dropdownValueOccupation,
                              underline: Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              icon: Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Spacer(),
                                    Transform.rotate(
                                      child: SizedBox(
                                        width: 18,
                                        height: 13.41,
                                        child: Image.asset(
                                            'assets/images/backicon.png',
                                            color: Color(0xff000000)),
                                      ),
                                      angle: 4.7,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    )
                                  ],
                                ),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Color(0xff000000)),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValueOccupation = newValue;
                                  switch (dropdownValueOccupation) {
                                    case 'Employed':
                                      break;
                                    case 'Self-employed':
                                      break;
                                    case 'Student':
                                      break;
                                  }
                                });
                              },
                              items: <String>[
                                'Employed',
                                'Self-employed',
                                'Student'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 12, bottom: 12),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: ()async{
                            if (_formKey.currentState.validate()) {
                              try{
                                progressDialog.show();
                                await auth.submittedDriverBioData(name:widget.name,phoneNo: widget.phoneNo,email: widget.email,gender: widget.gender,
                                    userType: widget.userType,address: widget.address,dateOfBirth: widget.dateOfBirth,maritalStatus: widget.maritalStatus,occupation: widget.occupation,
                                    accountName: _acctName,accountNumber:_acctNo,bankType: dropdownValueBank,nextOfKinAddress: _addressOfNextOfKin,nextOfKinName: _nameOfNextOfKin,nextOfKinPhonNo: _phoneNoOfNextOfKin,
                                    nextOfKinGender: dropdownValueGender,nextOfKinRela: dropdownValueRelationship,nextOfKinOccu: dropdownValueOccupation,profilePhoto:widget.profileImage);

                                progressDialog.hide();

                                _key.currentState.showSnackBar(
                                    SnackBar(content: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("BioData Submitted Successfully"),
                                        Icon(Icons.star),
                                      ],
                                    ))
                                );
                                changeScreen(context: context, widget: VehicleInformation(name: widget.name, roleType: widget.userType, profilePhoto: widget.profileImage));

                              }catch(_){
                                progressDialog.hide();
                                _key.currentState.showSnackBar(
                                    SnackBar(content: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Error Submitting BioData"),
                                        Icon(Icons.error),
                                      ],
                                    ))
                                );
                              }

                            }
                          },
                          child: Custombutton1(btnText: "Continue",isBorder: false,btnBg: headerColor,)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
