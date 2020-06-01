// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:qrs/constant/formdecoration.dart';
// import 'package:qrs/constant/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:qrs/services/authBase.dart';
// // import 'package:qrs/services/databaseService.dart';

// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:qrs/services/databaseService.dart';

// class Register extends StatefulWidget {
//   final Function toggleView;
//   Register({this.toggleView});
//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final AuthService _auth = AuthService();
//   final _formkey = GlobalKey<FormState>();
//   bool loading = false;
//   String email = '';
//   String password = '';
//   String confirmPassword = '';
//   String errr = '';
//   String phoneNo;
//   String smsCode;
//   String verificationId;
//   String eid;

//   Future<void> verifyPhone() async {
//     final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
//       this.verificationId = verId;
//     };

//     final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
//       this.verificationId = verId;
//     };

//     // final PhoneVerificationCompleted verifiedSucess = (FirebaseUser user) {
//     //   print('verified');
//     // };

//     final PhoneVerificationFailed verificationFailed =
//         (AuthException exception) {
//       print('${exception.message}');
//     };
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: this.phoneNo,
//       timeout: const Duration(seconds: 5),
//       verificationCompleted: null,
//       verificationFailed: verificationFailed,
//       codeSent: smsCodeSent,
//       codeAutoRetrievalTimeout: autoRetrieve,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return loading
//         ? Loading()
//         : Scaffold(
//             backgroundColor: Colors.blue[50],
//             appBar: AppBar(
//               backgroundColor: Colors.blue,
//               elevation: 0,
//               title: Text('Sign up to QrCode',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                   )),
//               actions: <Widget>[
//                 FlatButton.icon(
//                   onPressed: () {
//                     widget.toggleView();
//                   },
//                   icon: Icon(Icons.account_box),
//                   color: Colors.blue,
//                   label: Text("Sign In",
//                       style: TextStyle(color: Colors.white, fontSize: 19)),
//                 )
//               ],
//             ),
//             body: ListView(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.fromLTRB(50, 40, 50, 0),
//                   child: Form(
//                     key: _formkey,
//                     child: Column(
//                       children: <Widget>[
// //email
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                             decoration:
//                                 textInputDecoration.copyWith(hintText: 'email'),
//                             validator: (val) =>
//                                 email.isEmpty ? 'Email is not valid!!' : null,
//                             onChanged: (val) {
//                               setState(() => email = val);
//                             }),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                             decoration:
//                                 textInputDecoration.copyWith(hintText: 'eid'),
//                             // validator: (val) =>
//                             //     eid.isEmpty ? 'Email is not valid!!' : null,
//                             // validator: (val) => Firestore.instance
//                             //         .collection('Employee')
//                             //         .document(val)
//                             //         .get()
//                             //         .then((val) {
//                             //       if (val.exists) {
//                             //         return null;
//                             //       } else {
//                             //         return "emp doesn't exist";
//                             //       }
//                             //     }).toString(),
//                             // validator:setState(() =>);,

//                             // Firestore.instance
//                             //     .collection('Employee')
//                             //     .document(val)
//                             //     .get()
//                             //     .then((doc) {
//                             //   if (doc.exists) {
//                             //     return null;
//                             //   } else {
//                             //     return "emp doesn;t exist";
//                             //   }
//                             // })
//                             onChanged: (val) {
//                               setState(() => eid = val);
//                             }),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                             decoration: textInputDecoration.copyWith(
//                                 hintText: 'phone number'),
//                             validator: (val) =>
//                                 phoneNo.isEmpty ? 'Field is empty!!' : null,
//                             onChanged: (val) {
//                               setState(() => phoneNo = val);
//                             }),
// // //password
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                             decoration: textInputDecoration.copyWith(
//                                 hintText: 'password'),
//                             validator: (val) => password.length < 8
//                                 ? 'password len must be at least 8!!'
//                                 : null,
//                             obscureText: true,
//                             onChanged: (val) {
//                               setState(() => password = val);
//                             }),
// //Confirm password
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                             decoration: textInputDecoration.copyWith(
//                                 hintText: 'confirm Password'),
//                             validator: (val) => (password != confirmPassword)
//                                 ? 'wrong password entered !!'
//                                 : null,
//                             obscureText: true,
//                             onChanged: (val) {
//                               setState(() => confirmPassword = val);
//                             }),
//                         SizedBox(height: 30),
//                         SizedBox(
//                           height: 50,
//                           width: 150,
//                           child: RaisedButton(
//                             color: Colors.pink,
//                             child: Text("Verify Mobile No. and Register",
//                                 style: TextStyle(
//                                     fontSize: 20, color: Colors.white)),
//                             onPressed: () async {
//                               dynamic validator =
//                                   await Database().checkEid(eid);
//                               if (validator == true) {
//                                 if (_formkey.currentState.validate()) {
//                                   setState(() => loading = true);
//                                   dynamic result =
//                                       await _auth.registerWithEmailandPassword(
//                                           email, password);
//                                   // verifyPhone;
//                                   if (result == null) {
//                                     setState(() {
//                                       error =
//                                           'Error while registering please try again!!';
//                                       loading = false;
//                                     });
//                                   }
//                                 }
//                               } else {
//                                 showDialog(
//                                     context: context,
//                                     builder: (context) => AlertDialog(
//                                           // actions: <Widget>[
//                                           //   Text("No Entered Employee Found!!")
//                                           // ],
//                                           content: ListTile(
//                                             title:Text("No Employee Exists"),
//                                             subtitle: Text("Check your Employee Id"),
//                                           ),
//                                           actions: <Widget>[
//                                             FlatButton(
//                                                 child: Text('ok'),
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 }),
//                                           ]));
//                               }
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(error,
//                             style: TextStyle(fontSize: 14, color: Colors.red)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }
// }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:qrs/constant/formdecoration.dart';
import 'package:qrs/constant/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:qrs/services/authBase.dart';
// import 'package:qrs/services/databaseService.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qrs/services/databaseService.dart';
import 'package:qrs/pages/authenticate/otp.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // final AuthService _auth = AuthService();
  bool loading = false;
  String eid;
  var opacityIndicatior = 0.0;
  RegExp re = RegExp(r'(@)');
  RegExp dotcom = RegExp(r'(.com)');
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _eidKey = GlobalKey<FormFieldState>();
  final _formKey = GlobalKey<FormState>();
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();
  final employeeId = TextEditingController();
  FocusNode passwordNode;
  FocusNode eidNode;
  FocusNode submitNode;
  String email;
  String password;
  String error = '';
  @override
  void initState() {
    super.initState();
    passwordNode = FocusNode();
    eidNode = FocusNode();
    submitNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    passwordNode.dispose();
    eidNode.dispose();
    submitNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Stack(children: <Widget>[
                Positioned(
                  top: -185,
                  left: 30.0,
                  child: CircleAvatar(
                    radius: 120.0,
                    backgroundColor: Colors.orange[200],
                  ),
                ),
                Positioned(
                  left: -100.0,
                  top: -225.0,
                  child: CircleAvatar(
                    radius: 150.0,
                    backgroundColor: Colors.purple[400],
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  top: MediaQuery.of(context).size.height * 0.11,
                  child: Card(
                    elevation: 0.0,
                    margin: EdgeInsets.zero,
                    color: Colors.white,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                      child: ListView(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontFamily: 'QuickSand',
                                  fontSize: 35.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  key: _emailKey,
                                  controller: emailInput,
                                  onFieldSubmitted: (_) {
                                    if (_emailKey.currentState.validate()) {
                                      FocusScope.of(context)
                                          .requestFocus(passwordNode);
                                    }
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Email Id';
                                    }
                                    if (!(re.hasMatch(value) &&
                                        dotcom.hasMatch(value))) {
                                      return 'Enter Valid Email Id';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                  decoration: InputDecoration(
                                      labelStyle:
                                          TextStyle(color: Colors.blue[900]),
                                      labelText: 'Email',
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.blue[900],
                                      )),
                                ),
                                SizedBox(height: 15.0),
                                TextFormField(
                                  key: _passwordKey,
                                  controller: passwordInput,
                                  focusNode: passwordNode,
                                  onFieldSubmitted: (_) {
                                    if (_passwordKey.currentState.validate()) {
                                      FocusScope.of(context)
                                          .requestFocus(eidNode);
                                    }
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Password';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                  decoration: InputDecoration(
                                      labelStyle:
                                          TextStyle(color: Colors.blue[900]),
                                      labelText: 'Password',
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.blue[900],
                                      )),
                                  obscureText: true,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  key: _eidKey,
                                  onFieldSubmitted: (_) {
                                    if (_eidKey.currentState.validate()) {
                                      FocusScope.of(context)
                                          .requestFocus(submitNode);
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() => eid = val);
                                  },
                                  focusNode: eidNode,
                                  controller: employeeId,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Employee ID is MANDATORY';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.perm_identity,
                                      color: Colors.blue[900],
                                    ),
                                    labelText: 'Employee ID',
                                    labelStyle:
                                        TextStyle(color: Colors.blue[900]),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                AnimatedOpacity(
                                    duration: Duration(milliseconds: 300),
                                    opacity: opacityIndicatior,
                                    child: Container(
                                      child: Text(error,
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.red)),
                                    )),
                                SizedBox(
                                  height: 175.0,
                                ),
                                InkWell(
                                  focusNode: submitNode,
                                  onTap: () async {
                                    bool validator =
                                        await Database().checkEid(eid);
                                    if (_formKey.currentState.validate()) {
                                      if (validator == true) {
                                        setState(() => loading = true);

                                        // dynamic result = await _auth
                                        //     .registerWithEmailandPassword(
                                        //         email, password);
                                        // verifyPhone;
                                        // if (result == null) {
                                        //   setState(() {
                                        //     opacityIndicatior = 1.0;
                                        //     error =
                                        //         'Error while registering please try again!!';
                                        //     loading = false;
                                        //   });
                                        // }
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Verification(empid: eid)));
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                    content: ListTile(
                                                      title: Text(
                                                          "No Employee Exists"),
                                                      subtitle: Text(
                                                          "Check your Employee Id"),
                                                    ),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                          child: Text('ok'),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                    ]));
                                      }
                                    }
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Center(
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Text(
                                            'SIGN UP',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'HammerHead',
                                                fontSize: 20),
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Already have an Account?'),
                                      InkWell(
                                          onTap: () {
                                            widget.toggleView();
                                          },
                                          child: Text("Sign In!",
                                              style: TextStyle(
                                                color: Colors.blue,
                                              )))
                                    ])
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          );
  }
}
