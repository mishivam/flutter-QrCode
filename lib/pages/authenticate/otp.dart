import 'package:flutter/material.dart';
import 'package:qrs/services/databaseService.dart';

class Verification extends StatefulWidget {
  final String empid;
  Verification({this.empid});
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _formKey = GlobalKey<FormState>();
  FocusNode nextButNode;
  final otpInput = TextEditingController();

  dynamic number;
  @override
  void initState() {
    super.initState();
    nextButNode = FocusNode();
    number = Database().getNumber(widget.empid);
  }

  @override
  void dispose() {
    super.dispose();
    nextButNode.dispose();
    // number.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  number,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'HammerHead',
                      color: Colors.red),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: otpInput,
                        autofocus: true,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(nextButNode),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'OTP Is Mandatory';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter Your OTP here',
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Resend OTP',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            Navigator.pushReplacementNamed(context, '/mainApp');
                          }
                        },
                        child: Card(
                          elevation: 1,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  'NEXT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'HammerHead',
                                      fontSize: 20),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
