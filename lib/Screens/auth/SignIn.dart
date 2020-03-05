import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_feed/Auth/Auth.dart';
import 'package:news_feed/Constant/CustomTextField.dart';

class SignIn extends StatefulWidget {
  final Function changeView;
  SignIn({this.changeView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Auth _auth = Auth();
  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  String _password;

  bool show = false;

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 63, horizontal: 26),
          child: Form(
            key: formKey,
            autovalidate: _autoValidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome \nBack',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                CustomTextField(
                  onSaved: (input) => _email = input,
                  validator: (input) => input.isEmpty ? '*Required' : null,
                  icon: Icon(Icons.email),
                  obsecure: false,
                  hint: 'EMAIL',
                ),
                SizedBox(height: 20),
                CustomTextField(
                  onSaved: (input) => _password = input,
                  validator: (input) => input.isEmpty ? '*Required' : null,
                  icon: Icon(Icons.lock),
                  obsecure: true,
                  hint: 'Password',
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      highlightElevation: 0.0,
                      elevation: 0.0,
                      color: Colors.blue,
                      padding: EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 34,
                        right: 34,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () => widget.changeView(),
                    ),
                    RaisedButton(
                      highlightElevation: 0.0,
                      elevation: 0.0,
                      color: Colors.blue,
                      padding: EdgeInsets.only(
                        bottom: 12,
                        top: 12,
                        left: 34,
                        right: 34,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: show
                          ? SpinKitWave(color: Colors.white, size: 20)
                          : Text(
                              'Sign In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          dynamic result =
                              await _auth.signIn(_email, _password);
                          setState(() => show = true);

                          if (result == null) {
                            setState(() => show = false);
                            errorMessage =
                                'Please Enter A Valid Email And Password..';
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
