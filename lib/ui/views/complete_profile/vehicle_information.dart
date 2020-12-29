import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hitchyke/app/utils/custom_navigation_controller.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:hitchyke/ui/views/complete_profile/vehicle_photo_upload.dart';
import 'package:hitchyke/ui/widgets/CustomButton1.dart';
import 'package:hitchyke/ui/widgets/pageback_widget.dart';
import 'package:intl/intl.dart';
class VehicleInformation extends StatefulWidget {
  final String roleType,name;
  final File profilePhoto;
  const VehicleInformation({@required this.name,@required this.roleType,@required this.profilePhoto});

  @override
  _VehicleInformationState createState() => _VehicleInformationState();
}

class _VehicleInformationState extends State<VehicleInformation> {
  final _formKey = GlobalKey<FormState>();
  String _manufacturer,_model,_color,_lincense, _otherInfo;
  DateTime _yearOfProduction,_yearOfPurchase;
  TextEditingController editingController;
  final format = DateFormat("yyyy-MM-dd");
  Color pickerColor = Color(0xff443a49);
  @override
  void initState() {
    super.initState();
    editingController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{
          Navigator.pop(context);
        return true;
        },
        child: SafeArea(
          child: Stack(
              children: [
                Image.asset('assets/images/bg.jpg',
                  width: double.maxFinite,
                  height: double.maxFinite,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 13,),
                      PageBack(bgColor: const Color(0xff000000), iconColor: Colors.white,isTitle: true,appBarTitle: "Hitchyke",titleColor: headerColor, onBackPress: (){
                        Navigator.pop(context);
                      }),
                      SizedBox(height: 20,),
                      Center(
                        child: widget.profilePhoto==null?CircleAvatar(
                          radius: size.width*0.1,
                          backgroundImage: AssetImage("assets/images/profilephoto.png"),
                        ):CircleAvatar(
                          radius: size.width * 0.1,
                          backgroundImage: FileImage(widget.profilePhoto),
                        ),
                      ),
                      Center(child: Text(widget.name??"",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: colorBackground),
                      ),

                      ),
                      Center(child: Text(widget.roleType??"Driver",style: TextStyle(fontSize: 10,color:colorSecondary,fontWeight: FontWeight.bold),),),
                      SizedBox(height: 16,),
                      Center(
                        child: Text(
                          "Please complete your profile by providing accurate information below",
                          style: TextStyle(
                              fontSize:16,
                              color: colorBackground,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: Text("Vehicle Information",
                          style: TextStyle(fontSize: 14,color: colorBackground,fontWeight: FontWeight.w400),),
                      ),
                      SizedBox(height: 20,),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Manufacturer",style: TextStyle(fontSize: 12,color: const Color(0xffE0B37E),fontWeight: FontWeight.normal),),
                                SizedBox(height: 10,),
                                Theme(
                                  data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                                  child: TextFormField(
                                    autofocus: false,
                                    keyboardType:
                                    TextInputType.text,
                                    validator: (val){
                                      if(val.isEmpty)return "Field cannot be empty";
                                      else return null;
                                    },
                                    onChanged: (val){
                                      _manufacturer = val;
                                    },
                                    style: TextStyle(fontSize: 18.0, color: colorPrimary),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
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
                            Row(children: <Widget>[
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Model",style: TextStyle(fontSize: 12,color: const Color(0xffE0B37E),fontWeight: FontWeight.normal),),
                                  SizedBox(height: 15,),
                                  Theme(
                                    data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                                    child: TextFormField(
                                      autofocus: false,
                                      keyboardType:
                                      TextInputType.text,
                                      validator: (val){
                                        if(val.isEmpty)return "Field cannot be empty";
                                        else return null;
                                      },
                                      onChanged: (val){
                                        _model = val;
                                      },
                                      style: TextStyle(fontSize: 18.0, color: colorPrimary),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                        const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
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
                              ),),
                              SizedBox(width: 10,),
                              Expanded(child:   Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Year",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: const Color(0xffE0B37E),
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Theme(
                                    data: Theme.of(context)
                                        .copyWith(splashColor: Colors.transparent),
                                    child: DateTimeField(

                                      onChanged: (DateTime date){
                                        _yearOfProduction = date;
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
                                            initialDatePickerMode: DatePickerMode.year,
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
                              ),)
                            ],),
                            SizedBox(height: 13,),
                            Row(children: <Widget>[
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Color",style: TextStyle(fontSize: 12,color: const Color(0xffE0B37E),fontWeight: FontWeight.normal),),
                                  SizedBox(height: 10,),
                                  Theme(
                                    data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                                    child: InkWell(
                                      onTap: (){
                                        showDialog(context: context,child: alertDialog());
                                      },
                                      child: TextFormField(
                                        autofocus: false,
                                        enabled: false,
                                        keyboardType:null,
                                        controller: editingController,
                                        style: TextStyle(fontSize: 18.0, color: colorPrimary),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
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
                                    ),
                                  )
                                ],
                              ),),
                              SizedBox(width: 15,),
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Lincense",style: TextStyle(fontSize: 12,color: const Color(0xffE0B37E),fontWeight: FontWeight.normal),),
                                  SizedBox(height: 10,),
                                  Theme(
                                    data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                                    child: TextFormField(
                                      autofocus: false,
                                      keyboardType:
                                      TextInputType.text,
                                      validator: (val){
                                        if(val.isEmpty)return "Field cannot be empty";
                                        else return null;
                                      },
                                      onChanged: (val){
                                        _lincense = val;
                                      },
                                      style: TextStyle(fontSize: 18.0, color: colorPrimary),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                        const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
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
                              ),)
                            ],),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Year of purchase",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: const Color(0xffE0B37E),
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Theme(
                                  data: Theme.of(context)
                                      .copyWith(splashColor: Colors.transparent),
                                  child: DateTimeField(
                                    onChanged: (DateTime date){
                                      _yearOfPurchase = date;
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
                                          initialDatePickerMode: DatePickerMode.year,
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
                            SizedBox(height: 13,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Other Info",style: TextStyle(fontSize: 12,color: const Color(0xffE0B37E),fontWeight: FontWeight.normal),),
                                SizedBox(height: 10,),
                                Theme(
                                  data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                                  child: TextFormField(
                                    autofocus: false,
                                    keyboardType:
                                    TextInputType.multiline,
                                    validator: (val){
                                      if(val.isEmpty)return "Field cannot be empty";
                                      else return null;
                                    },
                                    onChanged: (val){
                                      _otherInfo = val;
                                    },
                                    style: TextStyle(fontSize: 18.0, color: colorPrimary),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
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

                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                              child: GestureDetector(
                                  onTap: (){
                                    if (_formKey.currentState.validate()) {
                                      changeScreen(context: context, widget: VehiclePhotoUpload(roleType: widget.roleType,name:widget.name,profilePhoto: widget.profilePhoto,
                                      manufacturer: _manufacturer,model: _model,color: pickerColor.toString(),lincese: _lincense,otherInfo: _otherInfo,
                                      yearOfProduction: _yearOfProduction,yearOfPurchase: _yearOfPurchase,));
                                    }
                                  },
                                  child: Custombutton1(btnText: "Continue",isBorder: false,btnBg: headerColor,)),
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ]

          ),
        ),
      ),
    );
  }
  Widget alertDialog(){
    return AlertDialog(
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void changeColor(Color color) {
    setState(()  {
      pickerColor = color;
      editingController.text=pickerColor.toString();
    });
  }

}
