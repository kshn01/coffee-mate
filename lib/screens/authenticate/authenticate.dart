import 'package:coffee_crew/screens/authenticate/register.dart';
import 'package:coffee_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignInScreen = true;

  void toggleView(){
    setState(() {
      showSignInScreen = !showSignInScreen;
    });
  }



  @override
  Widget build(BuildContext context) {

    if(showSignInScreen){
      return SignIn(toggleView : toggleView);
    }else{
      return Register(toggleView : toggleView);
    }


  }
}
