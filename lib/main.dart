import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sertidrive/Models/user.dart';
import 'package:sertidrive/Screens/Home/wrapper.dart';
import 'package:sertidrive/Services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUserModel>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue[900],
          accentColor: Colors.white,
          splashColor: Colors.blue[900],
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            color: Colors.blue[900],
            actionsIconTheme: IconThemeData(
              size: 25.0,
            ),
          ),
          iconTheme: IconThemeData(
            size: 25.0,
            color: Colors.white,
          ),
        ),
        home: Wrapper(),
      ),
    );
  }
}