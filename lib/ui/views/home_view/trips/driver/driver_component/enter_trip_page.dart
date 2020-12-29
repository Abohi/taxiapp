import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hitchyke/bloc/dashboard_bloc/hitchyke_dashboard_bloc.dart';
import 'package:hitchyke/bloc/dashboard_bloc/hitchyke_dashboard_event.dart';
import 'package:hitchyke/models/placemodel.dart';
import 'package:hitchyke/models/user.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/services/googlemap_service.dart';
import 'package:hitchyke/services/userServices.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:hitchyke/ui/widgets/CustomButton1.dart';
import 'package:hitchyke/ui/widgets/autocompletetextview.dart';
import 'package:hitchyke/ui/widgets/pageback_widget.dart';
import 'package:intl/intl.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:provider/provider.dart';

class EnterTrip extends StatefulWidget {
  const EnterTrip();
  @override
  _EnterTripState createState() => _EnterTripState();
}

class _EnterTripState extends State<EnterTrip> {
  TextEditingController autoCompleteController2, autoCompleteController;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  final format = DateFormat("yyyy-MM-dd");
  final formatTime = DateFormat("HH:mm");
  String dropdownValuePassenger = '3';
  String dropdownValueFare = '#6000';
  UserService userService;


  @override
  void initState() {
    super.initState();
    autoCompleteController = TextEditingController();
    autoCompleteController2 = TextEditingController();
    userService= UserService();
  }

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<UserProvider>(context).user.uid;
    var size= MediaQuery.of(context).size;
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
                      color:headerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          centerTitle: true,
          pinned: true,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              BlocProvider.of<HitchykeDashBoardBloc>(context)
                  .add(DashBoardDriverTripEvent());
            },
          ),
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
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal:17.0),
          sliver: SliverList(delegate: SliverChildListDelegate([
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Take Off Point",
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
                  child: AutoCompleteTextView(
                    suggestionsApiFetchDelay: 300,
                    focusGained: () {},
                    onTapCallback: (placeId) async {},
                    focusLost: () {},
                    onValueChanged: (String text) {},
                    controller: autoCompleteController,
                    suggestionStyle: Theme.of(context).textTheme.bodyText1,
                    getSuggestionsMethod: getLocationSuggestionsList,
                    tfTextAlign: TextAlign.left,
                    tfStyle: TextStyle(fontSize: 12.0, color: colorPrimary),
                    tfTextDecoration: InputDecoration(
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
                  "Destination",
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
                  child: AutoCompleteTextView(
                    suggestionsApiFetchDelay: 300,
                    focusGained: () {},
                    onTapCallback: (placeId) async {},
                    focusLost: () {},
                    onValueChanged: (String text) {},
                    controller: autoCompleteController2,
                    suggestionStyle: Theme.of(context).textTheme.bodyText1,
                    getSuggestionsMethod: getLocationSuggestionsList,
                    tfTextAlign: TextAlign.left,
                    tfStyle: TextStyle(fontSize: 12.0, color: colorPrimary),
                    tfTextDecoration: InputDecoration(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Date",
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
                          format: format,
                          style:
                          TextStyle(fontSize: 12.0, color: colorPrimary),
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
                                lastDate: DateTime(2100));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 31,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Time",
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
                          format: formatTime,
                          style:
                          TextStyle(fontSize: 12.0, color: colorPrimary),
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
                          onShowPicker: (context, currentValue) async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.convert(time);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Max. Passengers",
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
                          value: dropdownValuePassenger,
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
                              dropdownValuePassenger = newValue;
                              switch (dropdownValuePassenger) {
                                case '3':
                                  break;
                                case '2':
                                  break;
                              }
                            });
                          },
                          items: <String>[
                            '3',
                            '2',
                            '1',
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
                ),
                SizedBox(
                  width: 31,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Fare",
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
                          value: dropdownValueFare,
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
                              dropdownValueFare = newValue;
                              switch (dropdownValueFare) {
                                case '#6000':
                                  break;
                                case '#4000':
                                  break;
                              }
                            });
                          },
                          items: <String>[
                            '#6000',
                            '#4000',
                            '#2000',
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
                  "Other Info",
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
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 12.0, color: colorPrimary),
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
            SizedBox(height: 20,),
            Custombutton1(btnText: "SUBMIT",isBorder: false,btnBg: headerColor,),
            SizedBox(height: size.height*0.1,),
          ]),),
        )
      ],
    );
  }

  Future<List<Place>> getLocationSuggestionsList(String input) async {
    List<Place> response =
        await _googleMapsServices.getLocationPlaceData(input);
    return response;
  }
}



