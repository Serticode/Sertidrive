import 'package:flutter/material.dart';
import 'package:sertidrive/Screens/Authenticate/register.dart';
import 'package:sertidrive/Screens/Authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn == true ? SignIn(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}
