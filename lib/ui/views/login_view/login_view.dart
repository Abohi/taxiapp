import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitchyke/app/enums/auth-result-status.dart';
import 'package:hitchyke/app/utils/custom_navigation_controller.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/screen_controllers/app_controller.dart';
import 'package:hitchyke/services/auth-exception-handler.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:hitchyke/ui/views/register_view/register_view.dart';
import 'package:hitchyke/ui/widgets/CustomButton1.dart';
import 'package:hitchyke/ui/widgets/customprogressbody.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView();

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  String _email, _password;
  bool _passwordVisible;
  ProgressDialog progressDialog;

  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final auth = Provider.of<UserProvider>(context);
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        customBody: CustomProgressBody());

    return WillPopScope(
      onWillPop: () async {
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
      child: Scaffold(
        key: _key,
        body: Container(
            width: width,
            height: height,
            child: Stack(children: [
              Image.asset(
                'assets/images/bg.jpg',
                width: double.maxFinite,
                height: double.maxFinite,
                fit: BoxFit.fill,
              ),
              Column(children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: ListView(children: <Widget>[
                          Image.asset(
                            'assets/images/logo.png',
                            width: height * 0.10,
                            height: height * 0.30,
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
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
                                    onChanged: (String value) {
                                      _email = value;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      labelText: 'Enter your email',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: headerColor)),
                                      labelStyle: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return "Field must not be empty";
                                      else if (val.length < 6)
                                        return "Password must be more than 6 characters";
                                      else
                                        return null;
                                    },
                                    onChanged: (String value) {
                                      _password = value;
                                    },
                                    obscureText: !_passwordVisible,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      labelText: 'Enter your password',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: headerColor)),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState
                                            .validate()) {
                                          progressDialog.show();
                                          AuthResultStatus status = await auth
                                              .loginUser(_email, _password);
                                          String errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
                                          switch(status){
                                            case AuthResultStatus.wrongPassword:
                                              progressDialog.hide();
                                              _key.currentState.showSnackBar(
                                                  SnackBar(content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(errorMsg),
                                                      Icon(Icons.error),
                                                    ],
                                                  ))
                                              );
                                              break;
                                            case AuthResultStatus.invalidEmail:
                                              progressDialog.hide();
                                              _key.currentState.showSnackBar(
                                                  SnackBar(content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(errorMsg),
                                                      Icon(Icons.error),
                                                    ],
                                                  ))
                                              );
                                              break;

                                            case AuthResultStatus.userNotFound:
                                              progressDialog.hide();
                                              _key.currentState.showSnackBar(
                                                  SnackBar(content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(errorMsg),
                                                      Icon(Icons.error),
                                                    ],
                                                  ))
                                              );
                                              break;
                                            case AuthResultStatus.successful:
                                              progressDialog.hide();
                                              _key.currentState.showSnackBar(
                                                  SnackBar(content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(errorMsg),
                                                      Icon(Icons.star),
                                                    ],
                                                  ))
                                              );
                                              changeScreenReplacement(context: context, widget: ScreensController());
                                              break;

                                            case AuthResultStatus.failure:
                                              progressDialog.hide();
                                              _key.currentState.showSnackBar(
                                                  SnackBar(content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(errorMsg),
                                                      Icon(Icons.error),
                                                    ],
                                                  ))
                                              );
                                              changeScreenReplacement(context: context, widget: ScreensController());
                                              break;
                                            default:
                                              return progressDialog.hide();
                                          }
                                        }
                                      },
                                      child: Custombutton1(
                                        btnText: "Login",
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  FlatButton(
                                    child: Text(
                                      "I Don't have an account? Register",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      changeScreen(context: context, widget: RegisterView());
                                    },
                                  )
                                ],
                              ))
                        ])))
              ])
            ])),
      ),
    );
  }
}
