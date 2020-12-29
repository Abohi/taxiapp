import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hitchyke/bloc/dashboard_bloc/hitchyke_dashboard_bloc.dart';
import 'package:hitchyke/bloc/dashboard_bloc/hitchyke_dashboard_event.dart';
import 'package:hitchyke/models/user.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/services/userServices.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:provider/provider.dart';

class DriverTrips extends StatefulWidget {
  @override
  _DriverTripsState createState() => _DriverTripsState();
}

class _DriverTripsState extends State<DriverTrips> {
  UserService userService;
  @override
  void initState() {
    super.initState();
    userService = UserService();
  }
  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<UserProvider>(context).user.uid;
    var size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 5,
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Hitchyke",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: headerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          centerTitle: true,
          pinned: true,
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
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
                          height:80,
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
          pinned: false,
          centerTitle: false,
        ),
        SliverPadding(padding: const EdgeInsets.only(left:17.0,right:17,bottom:24),
        sliver: SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 OfferRideBtn(onButtonPressed: (){
                  BlocProvider.of<HitchykeDashBoardBloc>(context)
                      .add(DashBoardDriverEnterTripEvent());
                },)
            ],
          ),
        ),),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          sliver: SliverList(delegate: SliverChildListDelegate(List.generate(10, (index){
            if(index<=3){
              return CustomListItem(statusColor: Color(0xffF4B425),statusText: "Active",isActive: true,isPending: false,isDone: false,);
            }
            else if (index>3 && index<=7){
              return CustomListItem(statusColor: Color(0xff31692C),statusText: "Done",isDone: true,isPending: false,isActive: false,);
            }
            else{
              return CustomListItem(statusColor: Color(0xffA8A8A8),statusText: "Pending",isPending: true,isActive: false,isDone: false,);
            }
          })),),
        )
      ],
    );
  }
}

class OfferRideBtn extends StatelessWidget {
  final Function onButtonPressed;
  const OfferRideBtn({this.onButtonPressed});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        onButtonPressed();
      },
      child: Container(
        width: size.width*0.3,
        height: 33,
        decoration: BoxDecoration(color: headerColor,borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Text("+ Offer a Ride",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w700),),
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  Color statusColor;
   String statusText;
   bool isActive=false;
   bool isPending=false;
   bool isDone=false;
   CustomListItem({this.statusColor,this.statusText,this.isActive,this.isDone,this.isPending});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height*0.1,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.symmetric(vertical: 7,horizontal: 7),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lagos",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
              SizedBox(height: 5,),
              Text("Start Time: 10.00am",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: const Color(0xffA8A8A8)),),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.arrow_forward,color: Colors.black,size: 18,),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Abuja",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isActive?Icon(Icons.error,color:Color(0xffF4B425),size: 14,):Text(""),
                  isDone?Container(
                    width: 16,
                      height: 16,
                      decoration: BoxDecoration(color: const Color(0xff31692C),shape: BoxShape.circle),
                      child: Center(child: Icon(Icons.done,size: 10,color: Colors.white,))):Text(""),
                  isPending?Text(""):Text(""),
                  SizedBox(width: 3.04,),
                  Text(statusText??"Active",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: statusColor??const Color(0xffF4B425)),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

