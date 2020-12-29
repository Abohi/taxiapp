import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hitchyke/models/user.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/services/userServices.dart';

import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UserService userService;

  @override
  void initState() {
    super.initState();
    userService= UserService();
  }
  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<UserProvider>(context).user.uid;
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 5,
            automaticallyImplyLeading: false,
            title: Text(
              "Hitchyke",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color:  headerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ),
            centerTitle: true,
            pinned: true,
            backgroundColor: Colors.black,
          ),
          SliverAppBar(
            titleSpacing: 0,
            elevation: 0,
            automaticallyImplyLeading: false,
            collapsedHeight: size.height*0.25,
            flexibleSpace: Container(
              width: size.width,
              height: size.height*0.25,
              color: Colors.transparent,
              child: StreamBuilder(
                  initialData:  UserModel(name: "Hitchyke",photoUrl: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"),
                  stream: userService.streamUser(userType:"Drivers",id:uid),
                builder:(context,snapshot){
                  if (snapshot.hasData){
                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:80,
                          height: 80,
                          child: ClipOval(
                            child: OptimizedCacheImage(
                              imageUrl: snapshot.data.photoUrl==null?"":snapshot.data.photoUrl,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.account_circle,color: Colors.white,size: 60,),
                            ),
                          ),
                        ),
                        SizedBox(height: 7,),
                        Text(
                          snapshot.data.name==null?"":snapshot.data.name,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colorBackground),
                        ),
                        SizedBox(height: 7,),
                        Text(
                          "Driver",
                          style: TextStyle(
                              fontSize: 14,
                              color: colorSecondary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    );
                  }else {
                    return Text("");
                  }
                }
              ),
            ),
            backgroundColor: Colors.transparent,
            pinned: true,
            centerTitle: false,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverGrid.count(
              crossAxisSpacing: 5,
              mainAxisSpacing: 15,
              crossAxisCount: 3,
              childAspectRatio: 4 / 5,
              children: [
                GridItem(
                  itemTitle: "TRIP",
                  itemTitleValue: "140",
                ),
                GridItem(
                  itemTitle: "INCOME",
                  itemTitleValue: "24k",
                ),
                GridItem(
                  itemTitle: "AVG. RATING",
                  itemTitleValue: "4.2",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String itemTitle;
  final String itemTitleValue;
  final Color itemBackgroundColor;

  const GridItem(
      {this.itemTitle, this.itemTitleValue, this.itemBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            itemTitleValue,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorBackground),
          ),
          Text(
            itemTitle,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: colorBackground),
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xffE0B37E),
      ),
    );
  }
}
