import 'package:qrs/services/authBase.dart';
import 'package:qrs/constant/formdecoration.dart';
import 'package:qrs/constant/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  // String confirmPssword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[50],
            appBar: AppBar(
              backgroundColor: Colors.blue,
              elevation: 5,
              centerTitle: false,
              title: Text('Sign In to QRScanner',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2)),
              actions: <Widget>[
                RaisedButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    
                    color: Colors.blue,
                    icon: Icon(Icons.person),
                    label: Text("register",
                        style: TextStyle(fontSize: 20, color: Colors.white))),
              ],
            ),
            body: Container(
                padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
                child: Form(
                    key: _formkey,
                    child: Column(children: <Widget>[
//email
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'email'),
                          validator: (val) =>
                              email.isEmpty ? 'Email is not valid!!' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          }),
//password
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'password'),
                          obscureText: true,
                          validator: (val) => password.length < 8
                              ? 'password len must be at least 8!!'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          }),
                      SizedBox(height: 50),
                      SizedBox(
                        height: 50,
                        width: 100,

                        child: RaisedButton(
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signinWithEmailandPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'no user found with email - $email!';
                                });
                              }
                            }
                          },
                          color: Colors.lightBlue,
                          child: Text("sign in", style: TextStyle(fontSize: 20,color: Colors.white)),
                          
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Text(error,
                          style: TextStyle(fontSize: 14, color: Colors.red)),
                    ]))));
  }
}
