import 'package:coffee_crew/models/my_user.dart';
import 'package:coffee_crew/screens/authenticate/authenticate.dart';
import 'package:coffee_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      print('▶ Authenticate');
      return Authenticate();
    } else {
      print("▶ Home");
      return Home();
    }
  }
}

