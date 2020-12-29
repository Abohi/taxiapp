import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hitchyke/models/user.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/services/userServices.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:hitchyke/ui/widgets/sidebar/menu_item.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {

  final String userType;

  SideBar({ @required userType})
      :userType = userType;

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  UserService userService = UserService();
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;

   Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);
  @override
  void initState(){
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;

  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<UserProvider>(context).user.uid;
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth * 0.60,
          right:
              isSideBarOpenedAsync.data ? screenWidth * 0.50 : screenWidth - 45,
          child: StreamBuilder<UserModel>(
            stream: userService.streamUser(id: uid,userType: widget.userType),
            initialData: UserModel(name: "Hitchyke",photoUrl: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"),
            builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot){
              if(snapshot.hasData){
                return  Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: headerColor,
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 58,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width:30,
                                  height: 30,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child:OptimizedCacheImage(
                                        imageUrl: snapshot.data.photoUrl==null?"":snapshot.data.photoUrl,
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Icon(Icons.account_circle,size:30,color: Colors.white,),
                                      )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),

                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(snapshot.data.name==null?"":snapshot.data.name),
                                      Row(
                                        children: <Widget>[
                                          Spacer(),
                                          Text("Driver",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10)),
                                          SizedBox(
                                            width: 18,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 69,
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  MenuItem(
                                    icon: Icons.person,
                                    title: "Profile",
                                    onTap: () {
                                      onIconPressed();
                                    },
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  MenuItem(
                                    icon: Icons.directions_car,
                                    title: "Trips",
                                    onTap: () {
                                      onIconPressed();
                                    },
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  MenuItem(
                                    icon: Icons.settings,
                                    title: "Settings",
                                    onTap: () {
                                      onIconPressed();
                                    },
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  MenuItem(
                                    icon: Icons.exit_to_app,
                                    title: "Logout",
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -0.9),
                      child: GestureDetector(
                        onTap: () {
                          onIconPressed();
                        },
                        child: ClipPath(
                          clipper: CustomMenuClipper(),
                          child: Container(
                            width: 35,
                            height: 110,
                            color: headerColor,
                            alignment: Alignment.centerLeft,
                            child: AnimatedIcon(
                              progress: _animationController.view,
                              icon: AnimatedIcons.menu_close,
                              color: colorBackground,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }else{
                return  Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: headerColor,
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 58,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Icon(Icons.account_circle,size:30,color: Colors.white,),),
                                SizedBox(
                                  width: 10,
                                ),

                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(""),
                                      Row(
                                        children: <Widget>[
                                          Spacer(),
                                          Text("Driver",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10)),
                                          SizedBox(
                                            width: 18,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 69,
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  MenuItem(
                                    icon: Icons.person,
                                    title: "Profile",
                                    onTap: () {
                                      onIconPressed();
                                    },
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  MenuItem(
                                    icon: Icons.directions_car,
                                    title: "Trips",
                                    onTap: () {
                                      onIconPressed();
                                    },
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  MenuItem(
                                    icon: Icons.settings,
                                    title: "Settings",
                                    onTap: () {
                                      onIconPressed();
                                    },
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  MenuItem(
                                    icon: Icons.exit_to_app,
                                    title: "Logout",
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -0.9),
                      child: GestureDetector(
                        onTap: () {
                          onIconPressed();
                        },
                        child: ClipPath(
                          clipper: CustomMenuClipper(),
                          child: Container(
                            width: 35,
                            height: 110,
                            color: headerColor,
                            alignment: Alignment.centerLeft,
                            child: AnimatedIcon(
                              progress: _animationController.view,
                              icon: AnimatedIcons.menu_close,
                              color: colorBackground,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
