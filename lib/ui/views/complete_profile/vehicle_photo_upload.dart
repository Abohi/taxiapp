import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hitchyke/app/utils/custom_navigation_controller.dart';
import 'package:hitchyke/bloc/dashboard_bloc/hitchyke_dashboard_bloc.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/screen_controllers/hitchyke_dashboard_ui_controller.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:hitchyke/ui/views/splash.dart';
import 'package:hitchyke/ui/widgets/CustomButton1.dart';
import 'package:hitchyke/ui/widgets/customprogressbody.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class VehiclePhotoUpload extends StatefulWidget {

  final File profilePhoto;
  final String manufacturer, model,color, lincese,otherInfo,name,roleType;
  final DateTime yearOfProduction, yearOfPurchase;
  const VehiclePhotoUpload({this.roleType,this.name,this.profilePhoto,this.manufacturer,this.model,this.color,this.lincese,this.otherInfo,this.yearOfProduction,this.yearOfPurchase});
  @override
  _VehiclePhotoUploadState createState() => _VehiclePhotoUploadState();
}

class _VehiclePhotoUploadState extends State<VehiclePhotoUpload> {
  final _key = GlobalKey<ScaffoldState>();
  File file1, file2, file3, file4, file5, file6;
  ProgressDialog progressDialog;
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<UserProvider>(context);
    var size = MediaQuery.of(context).size;
    progressDialog = ProgressDialog(context,type:ProgressDialogType.Normal,isDismissible: false,customBody: CustomProgressBody());
    return Scaffold(
      key: _key,
      body: WillPopScope(
        onWillPop: ()async{
        Navigator.pop(context);
        return true;
        },
        child: SafeArea(
          child: Stack(
              children:[
                Image.asset(
                  'assets/images/bg.jpg',
                  width: double.maxFinite,
                  height: double.maxFinite,
                  fit: BoxFit.fill,
                ),
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title:
                      Align(alignment: Alignment.centerRight, child: Text("Hitchyke",style: GoogleFonts.roboto(color: const Color(0xffC48132),fontSize: 16,fontWeight: FontWeight.bold),)),
                      pinned: true,
                      backgroundColor: const Color(0xff000000),
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back,color: Colors.white,size: 24,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SliverList(delegate: SliverChildListDelegate([
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: widget.profilePhoto==null?CircleAvatar(
                          radius: size.width*0.1,
                          backgroundImage: AssetImage("assets/images/profilephoto.png"),
                        ):CircleAvatar(
                          radius: size.width * 0.1,
                          backgroundImage: FileImage(widget.profilePhoto),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text(
                          widget.name??"Hitchyke Name",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Center(
                        child: Text(
                          widget.roleType??"Hitchyke Driver",
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
                          style: GoogleFonts.roboto(textStyle: TextStyle(
                              fontSize: 16,
                              color: colorBackground,
                              fontWeight: FontWeight.w400)),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: Text(
                          "Vehicle Photo Upload",
                          style: GoogleFonts.roboto(textStyle: TextStyle(
                              fontSize: 14,
                              color: colorBackground,
                              fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: 45,),
                    ])),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 41),
                      sliver: SliverGrid.count( crossAxisSpacing: 15,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: 4 / 5,
                        children: [
                          GridItem(
                            gridItemTitle: "Front View",
                            onTap: (file) {
                              setState(() {
                                file1 = file;
                                print("file 1: " + file1.toString());
                              });
                            },
                          ),
                          GridItem(
                            gridItemTitle: "Rear View",
                            onTap: (file) {
                              setState(() {
                                file2 = file;
                                print("file 2: " + file2.toString());
                              });
                            },
                          ),
                          GridItem(
                            gridItemTitle: "Left Side View",
                            onTap: (file) {
                              setState(() {
                                file3 = file;
                                print("file 3: " + file1.toString());
                              });
                            },
                          ),
                          GridItem(
                            gridItemTitle: "Right Side View",
                            onTap: (file) {
                              setState(() {
                                file4 = file;
                                print("file 4: " + file4.toString());
                              });
                            },
                          ),
                          GridItem(
                            gridItemTitle: "Inside Front View",
                            onTap: (file) {
                              setState(() {
                                file5 = file;
                                print("file 5: " + file5.toString());
                              });
                            },
                          ),
                          GridItem(
                            gridItemTitle: "Inside Rare View",
                            onTap: (file) {
                              setState(() {
                                file6 = file;
                                print("file 6: " + file6.toString());
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(padding: EdgeInsets.symmetric(vertical: 20),
                      sliver:  SliverToBoxAdapter(
                        child:   Padding(
                          padding: const EdgeInsets.symmetric(horizontal:15),
                          child: GestureDetector(
                              onTap: ()async{
                                if (file1!=null){
                                  List<File> fileList= [file1,file2,file3,file4,file5,file6];
                                  try {
                                    progressDialog.show();

                                    await  auth.profileVehicleSubmitted(userType:widget.roleType,manufacturer: widget.manufacturer,model: widget.model,color: widget.color,
                                        lincese: widget.lincese,otherInfo: widget.otherInfo,yearOfPurchase: widget.yearOfPurchase,yearOfProduction:widget.yearOfProduction,file:fileList);

                                    progressDialog.hide();
                                    _key.currentState.showSnackBar(
                                        SnackBar(content: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("Other BioData Submitted Successfully"),
                                            Icon(Icons.star),
                                          ],
                                        ))
                                    );

                                    changeScreen(context: context, widget: BlocProvider(
                                      create: (context) => HitchykeDashBoardBloc(),
                                      child: HitchykeDashBoardUIController(),
                                    ));
                                  } catch (e) {
                                    progressDialog.hide();
                                    _key.currentState.showSnackBar(
                                        SnackBar(content: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("Error Submitting Other BioData"),
                                            Icon(Icons.error),
                                          ],
                                        ))
                                    );
                                  }
                                }
                              },
                              child: Custombutton1(btnText: "Continue",isBorder: false,btnBg: headerColor,)),
                        ),
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatefulWidget {
  final String gridItemTitle;
  final Function(File photo) onTap;

  GridItem({this.gridItemTitle, this.onTap});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  File photo;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      height: size.width * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.gridItemTitle,
            style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xffE0B37E)),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              width: size.width * 0.5,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: headerColor, borderRadius: BorderRadius.circular(10)),
              child: photo == null
                  ? GestureDetector(
                      onTap: () async {
                        File getPic =
                            await FilePicker.getFile(type: FileType.image);
                        if (getPic != null) {
                          widget.onTap(getPic);
                          setState(() {
                            photo = getPic;
                          });
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_upload,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 15.93,
                          ),
                          Text(
                            "SELECT IMAGE",
                            style: GoogleFonts.roboto(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        File getPic =
                            await FilePicker.getFile(type: FileType.image);
                        if (getPic != null) {
                          setState(() {
                            photo = getPic;
                          });
                        }
                      },
                      child: Expanded(
                          child: Image(
                        image: FileImage(photo),
                        fit: BoxFit.contain,
                      ))),
            ),
          )
        ],
      ),
    );
  }
}
