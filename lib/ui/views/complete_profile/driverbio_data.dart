
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hitchyke/app/utils/custom_navigation_controller.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:hitchyke/ui/views/complete_profile/driverbiodata_otherinfo.dart';
import 'package:hitchyke/ui/widgets/CustomButton1.dart';
import 'package:intl/intl.dart';

class DriverBioData extends StatefulWidget {
  final String roleType;
  const DriverBioData({@required this.roleType});
  @override
  _DriverBioDataState createState() => _DriverBioDataState();
}

class _DriverBioDataState extends State<DriverBioData> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValueGender = 'Male';
  String dropdownValueMaritalStatus = 'Single';
  String dropdownValueOccupation = 'Student';
  final format = DateFormat("yyyy-MM-dd");
  String _name,_phoneNo,_email,_address;
  DateTime _dateOfBirth;
  File photo;

  @override
  Widget build(BuildContext context) {
   var size = MediaQuery.of(context).size;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async{
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
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  title: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Hitchyke",
                      style: TextStyle(
                          color: headerColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  pinned: true,
                  elevation: 0,
                ),
                SliverList(delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: size.width * 0.1,
                      backgroundColor: Colors.transparent,
                      child: photo == null
                          ? GestureDetector(
                        onTap: () async {
                          File getPic = await FilePicker.getFile(
                              type: FileType.image);
                          if (getPic != null) {
                            setState(() {
                              photo = getPic;
                            });
                          }
                        },
                        child: Stack(children: [
                          Positioned.fill(child:  Image.asset('assets/images/profilephoto.png')),
                          Positioned(left:0,top:0,
                            child: Icon(Icons.add_a_photo,color: headerColor,size: 20,),)
                        ]),
                      )
                          : GestureDetector(
                        onTap: () async {
                          File getPic = await FilePicker.getFile(
                              type: FileType.image);
                          if (getPic != null) {
                            setState(() {
                              photo = getPic;
                            });
                          }
                        },
                        child: CircleAvatar(
                          radius: size.width * 0.3,
                          backgroundImage: FileImage(photo),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      widget.roleType??"Driver",
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
                          fontSize: 16,
                          color: colorBackground,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Bio Data",
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
                              "Name",
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
                                validator: (val) {
                                  if (val.isEmpty)
                                    return "Field must not be empty";
                                  else
                                    return null;
                                },
                                onChanged: (String value){
                                  _name = value;
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
                        SizedBox(
                          height: 13,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Phone No",
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
                                validator: (val) {
                                  if (val.isEmpty)
                                    return "Field must not be empty";
                                  else if(val.length<11)return "Field must not be less than 11 digit";
                                  else
                                    return null;
                                },
                                onChanged: (String value){
                                  _phoneNo=value;
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
                        SizedBox(
                          height: 13,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Email",
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
                                validator: (val) {
                                  if (val.isEmpty)
                                    return "Field must not be empty";
                                  else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val))
                                    return "Email is not valid";
                                  else
                                    return null;
                                },
                                onChanged: (String value){
                                  _email = value;
                                },
                                autofocus: false,
                                keyboardType: TextInputType.emailAddress,
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
                                autofocus: false,
                                validator: (val){
                                  if (val.isEmpty)
                                    return "Field must not be empty";
                                  else
                                    return null;
                                },
                                onChanged: (String value){
                                  _address=value;
                                },
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
                              "Date of birth",
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
                              child: DateTimeField(
                                onChanged: (DateTime date){
                                  _dateOfBirth = date;
                                },
                                validator: (val){
                                  if(val==null) return "Field must not be empty";
                                  else
                                    return null;
                                },
                                format: format,
                                style: TextStyle(fontSize: 18.0, color: colorPrimary),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.only(
                                      left: 12.0, bottom: 12.0, top: 12.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onShowPicker: (context, currentValue) {
                                  return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate: currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100),
                                      builder: (BuildContext context, Widget child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                              colorScheme: ColorScheme.light().copyWith(
                                                primary: headerColor,
                                              )//selection color
                                          ),
                                          child: child,
                                        );
                                      }
                                  );
                                },
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
                      children: [
                        Text(
                          "Marital Status",
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xffE0B37E),
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: DropdownButton<String>(
                            value: dropdownValueMaritalStatus,
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
                                dropdownValueMaritalStatus = newValue;
                              });
                            },
                            items: <String>[
                              'Single',
                              'Married',
                              'Divorced'
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                          child: GestureDetector(
                              onTap: (){
                                if (_formKey.currentState.validate()) {
                                 changeScreen(context: context, widget:  DriverBioData_OtherInfo(name:_name,phoneNo:_phoneNo,email:_email,address:_address,maritalStatus:dropdownValueMaritalStatus,gender:dropdownValueGender,userType: widget.roleType,occupation: dropdownValueOccupation,
                                   dateOfBirth: _dateOfBirth,profileImage:photo,));
                                }
                              },
                              child: Custombutton1(btnText: "Continue",isBorder: false,btnBg: headerColor,)),
                        )
                      ],
                    ),
                  )
                ]),)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}


