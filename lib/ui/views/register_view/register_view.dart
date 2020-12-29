import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hitchyke/app/enums/auth-result-status.dart';
import 'package:hitchyke/app/utils/custom_navigation_controller.dart';
import 'package:hitchyke/providers/user_provider.dart';
import 'package:hitchyke/services/auth-exception-handler.dart';
import 'package:hitchyke/ui/constants/hitchyke_colors.dart';
import 'package:hitchyke/ui/views/login_view/login_view.dart';
import 'package:hitchyke/ui/views/verification_view/verification_view.dart';
import 'package:hitchyke/ui/widgets/CustomButton1.dart';
import 'package:hitchyke/ui/widgets/customprogressbody.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {


  RegisterView();

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool _passwordVisible;
  String email,password;
  ProgressDialog _progressDialog;
  @override
  void initState() {
    super.initState();
    _passwordVisible=false;
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final auth = Provider.of<UserProvider>(context);
    _progressDialog = ProgressDialog(context,type:ProgressDialogType.Normal,isDismissible: false,customBody: CustomProgressBody());
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        key: _key,
        body: Container(
            width: width,
            height: height,
            color:Colors.black,
            child: Stack(children: [
              Image.asset('assets/images/bg.jpg',
                width: double.maxFinite,
                height: double.maxFinite,
                fit: BoxFit.fill,
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 21),
                      child: ListView(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/logo.png',
                            width: height * 0.10,
                            height:height*0.30,
                            fit: BoxFit.scaleDown,
                          ),
                          Form(key: _formKey,
                              child: Column(children: <Widget>[
                                TextFormField(
                                  validator: (val){

                                    if(val.isEmpty) return "Field must not be empty";

                                    else if ( !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)) return "Email is not valid";

                                    else
                                      return null;
                                  },
                                  onChanged:(String value){
                                    email = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:FloatingLabelBehavior.auto,
                                    labelText: 'Enter your email',
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),

                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: headerColor)),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),

                                  ),
                                ),
                                SizedBox(height:15),
                                TextFormField(
                                  validator: (val){
                                    if(val.isEmpty) return "Field must not be empty";

                                    else if(val.length<6) return "Password must be more than 6 characters";

                                    else
                                      return null;
                                  },
                                  onChanged:(String value){
                                    password = value;
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
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    floatingLabelBehavior:FloatingLabelBehavior.auto,
                                    labelText: 'Enter your password',
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: headerColor)),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),

                                  ),
                                ),
                                SizedBox(height: 20,),
                                GestureDetector(
                                    onTap: () async{
                                      if(_formKey.currentState.validate()){
                                        _progressDialog.show();
                                        AuthResultStatus status = await auth.registerUser(email, password);
                                        String errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
                                        switch(status){
                                          case AuthResultStatus.emailAlreadyExists:
                                            _progressDialog.hide();
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
                                          case AuthResultStatus.emailNotVerified:
                                            _progressDialog.hide();
                                            _key.currentState.showSnackBar(
                                                SnackBar(content: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Text(errorMsg),
                                                    Icon(Icons.error),
                                                  ],
                                                ))
                                            );
                                            changeScreenReplacement(context: context, widget: VerificationView());
                                            break;
                                          case AuthResultStatus.failure:
                                            _progressDialog.hide();
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
                                          default:
                                            return _progressDialog.hide();

                                        }
                                      }
                                    },
                                    child: Custombutton1(btnText: "Register",)),
                                SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: (){
                                    changeScreenReplacement(context: context, widget: LoginView());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:   Center(
                                      child: Text.rich(
                                        TextSpan(
                                          text: "Already have an account ",
                                          style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.white.withOpacity(0.7))),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Login",
                                                style:GoogleFonts.roboto(textStyle: TextStyle(decoration: TextDecoration.underline,fontSize: 14,fontWeight: FontWeight.normal,color: Colors.white))),
                                            // can add more TextSpans here...
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                              ],)
                          )],
                      ),
                    ),
                  ),
                ],
              ),
            ])),
      ),
    );
  }


}