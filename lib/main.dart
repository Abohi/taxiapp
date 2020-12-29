
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/screen_controllers/app_controller.dart';
import 'package:provider/provider.dart';




void main() async{
  //Locator helps in injecting dependencies(classes) into our whole app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();



  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hitchyke',
          home: ScreensController())));

}


