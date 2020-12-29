import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hitchyke/bloc/dashboard_bloc/hitchyke_dashboard_bloc.dart';
import 'package:hitchyke/bloc/dashboard_bloc/hitchyke_dashboard_event.dart';
import 'package:hitchyke/bloc/dashboard_bloc/hitchyke_dashboard_state.dart';
import 'package:hitchyke/models/user.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/services/userServices.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:hitchyke/ui/views/home_view/MainPage.dart';
import 'package:hitchyke/ui/views/home_view/trips/driver/driver_component/enter_trip_page.dart';
import 'package:hitchyke/ui/views/home_view/trips/driver/driver_trips_page.dart';
import 'package:hitchyke/ui/widgets/pageback_widget.dart';
import 'package:hitchyke/ui/widgets/sidebar/sidebar.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:provider/provider.dart';

class HitchykeDashBoardUIController extends StatefulWidget {


  const HitchykeDashBoardUIController();

  @override
  _HitchykeDashBoardUIControllerState createState() =>
      _HitchykeDashBoardUIControllerState();
}

class _HitchykeDashBoardUIControllerState
    extends State<HitchykeDashBoardUIController> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{
          showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit an App'),
              actions: <Widget>[
                new GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text("NO"),
                ),
                SizedBox(height: 16),
                new GestureDetector(
                  onTap: () => SystemNavigator.pop(),
                  child: Text("YES"),
                ),
              ],
            ),
          );
          return true;
        },
        child: SafeArea(
          child: Stack(children: [
            Image.asset(
              'assets/images/bg.jpg',
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.fill,
            ),
            BlocBuilder<HitchykeDashBoardBloc, HitchykeDashBoardState>(
              builder: (BuildContext context, HitchykeDashBoardState state) {
                if (state is DashBoardNotInitializedState) {
                  return MainPage();
                } else if (state is DashBoardDriverTripState) {
                  return DriverTrips();
                }
                else if (state is DashBoardDriverEnterTripState){
                  return EnterTrip();
                }else {
                  return MainPage();
                }
              },
            ),
            BlocBuilder<HitchykeDashBoardBloc, HitchykeDashBoardState>(
              builder: (BuildContext context, HitchykeDashBoardState state) {
                return SideBar(
                  userType: "Drivers",
                );
              },
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        child: BlocBuilder<HitchykeDashBoardBloc, HitchykeDashBoardState>(
            builder: (BuildContext context, HitchykeDashBoardState state) {
          return MainPageBottomSheet();
        }),
      ),
    );
  }
}

class MainPageBottomSheet extends StatefulWidget {
  @override
  _MainPageBottomSheetState createState() => _MainPageBottomSheetState();
}

class _MainPageBottomSheetState extends State<MainPageBottomSheet> {
  bool rnHome = true;
  bool rnTrip = false;
  bool rnRatings = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HitchykeDashBoardBloc, HitchykeDashBoardState>(
      listener: (context, state) {
        if (state is DashBoardNotInitializedState) {
          setState(() {
            rnHome = true;
            rnTrip = false;
            rnRatings = false;
          });
        }else if (state is DashBoardDriverTripState){
          setState(() {
            rnHome = false;
            rnTrip = true;
            rnRatings = false;
          });
        }
        else if (state is DashBoardDriverEnterTripState){
          setState(() {
            rnHome = false;
            rnTrip = true;
            rnRatings = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: MainPageBottomButtons(
                    bottomIcon: Icons.home,
                    iconTitle: "Home",
                    selected: rnHome,
                    onTap: () {
                      setState(() {
                        rnHome = true;
                        rnTrip = false;
                        rnRatings = false;
                      });
                      BlocProvider.of<HitchykeDashBoardBloc>(context)
                          .add(DashBoardStartEvent());
                    })),
            Expanded(
                child: MainPageBottomButtons(
                    bottomIcon: Icons.directions_car,
                    iconTitle: "Start Trip",
                    selected: rnTrip,
                    onTap: () {
                      setState(() {
                        rnHome = false;
                        rnTrip = true;
                        rnRatings = false;
                      });
                      BlocProvider.of<HitchykeDashBoardBloc>(context)
                          .add(DashBoardDriverTripEvent());
                    })),
            Expanded(
                child: MainPageBottomButtons(
                    bottomIcon: Icons.star,
                    iconTitle: "Ratings",
                    selected: rnRatings,
                    onTap: () {
                      setState(() {
                        rnHome = false;
                        rnTrip = false;
                        rnRatings = true;
                      });
                    })),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class MainPageBottomButtons extends StatefulWidget {
  final IconData bottomIcon;
  final String iconTitle;
  final VoidCallback onTap;
  final bool selected;

  const MainPageBottomButtons(
      {this.bottomIcon, this.iconTitle, this.onTap, this.selected});

  @override
  _MainPageBottomButtonsState createState() => _MainPageBottomButtonsState();
}

class _MainPageBottomButtonsState extends State<MainPageBottomButtons> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    isSelected = widget.selected;
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        if (widget.onTap != null) widget.onTap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          isSelected
              ? Icon(
                  widget.bottomIcon,
                  color: const Color(0xffFFFFFF),
                  size: 20,
                )
              : Icon(
                  widget.bottomIcon,
                  color: const Color(0xffE0B37E),
                  size: 20,
                ),
          isSelected
              ? Text(
                  widget.iconTitle,
                  style:
                      TextStyle(fontSize: 12, color: const Color(0xffFFFFFF)),
                )
              : Text(
                  widget.iconTitle,
                  style:
                      TextStyle(fontSize: 12, color: const Color(0xffE0B37E)),
                )
        ],
      ),
    );
  }
}
