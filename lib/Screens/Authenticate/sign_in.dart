import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sertidrive/Services/auth.dart';
import 'package:sertidrive/Shared/constants.dart';
import 'package:sertidrive/Shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //TEXT FIELD STATE
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Sign in to Sertidrive"),
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 50.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    //FOR EMAIL
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: textInputDecoration.copyWith(
                          hintText: "Email: sample@sample.com"),
                      validator: (value) =>
                          value.isEmpty ? "Enter an Email" : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),

                    //FOR PASSWORD
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: "Password: Your Password"),
                      validator: (value) => value.length < 6
                          ? "Enter a password at least 6 characters long"
                          : null,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),

                    //SIGN IN BUTTON
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.login_sharp),
                      label: Text(
                        "Sign In",
                        style: elevatedButtonTextStyle,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          var result = await _auth.signInWithEmailAndPassword(
                              email, password);

                          if (result == null) {
                            setState(() {
                              error =
                                  "Could not sign in with those credentials";
                              loading = false;
                            });
                          }
                        }
                      },
                      style: elevatedButtonStyle,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
