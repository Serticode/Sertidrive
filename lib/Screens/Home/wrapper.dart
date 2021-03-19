import 'package:flutter/material.dart';
import 'package:sertidrive/Models/user.dart';
import 'package:sertidrive/Screens/Authenticate/authenticate.dart';
import 'package:sertidrive/Screens/Home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUserModel>(context);

    (user != null)
        ? print("${user.email} is logged in")
        : print("$user is logged in");
    //RETURN EITHER HOME OR AUTHENTICATE WIDGET.
    return user == null ? Authenticate() : Home();
  }
}
