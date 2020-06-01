import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrs/pages/screen/notifications.dart';
// import 'package:qrs/pages/AddProduct/showgenqr.dart';
import 'package:qrs/services/databaseService.dart';
// import 'package:qrs/constant/formdecoration.dart';
import 'package:provider/provider.dart';
// import 'package:qrs/modules/serialNum.dart';
import 'package:qrs/modules/user.dart';
// import 'package:qrs/modules/product.dart';

class FormToAdd extends StatefulWidget {
  @override
  _FormToAddState createState() => _FormToAddState();
}

class _FormToAddState extends State<FormToAdd> {
  GlobalKey globalKey = GlobalKey();
  final _formkey = GlobalKey<FormState>();
  // print(${widget.serialnum})
  // final String serialofqr=widget.serialnum.toString();
  String _productName;
  String _serialNum;
  String _dateofInstallation;
  String _partsServiced;
  String _nextServiceDate;
  String useremail;
  final _productNameKey = GlobalKey<FormFieldState>();
  final _productNoKey = GlobalKey<FormFieldState>();
  final _currentServiceDate = GlobalKey<FormFieldState>();
  final _currentServiceData = GlobalKey<FormFieldState>();
  final _nextService = GlobalKey<FormFieldState>();

  FocusNode productNo;
  FocusNode currentDate;
  FocusNode currentData;
  FocusNode nextDate;
  FocusNode submitButton;

  @override
  void initState() {
    super.initState();
    productNo = FocusNode();
    currentDate = FocusNode();
    currentData = FocusNode();
    nextDate = FocusNode();
    submitButton = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // print(widget.serialnum.serialnumber);
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                  key: _productNameKey,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      prefixIcon: Icon(Icons.note, color: Colors.blue[900]),
                      labelText: 'Enter Product Name'),
                  onFieldSubmitted: (_) {
                    if (_productNameKey.currentState.validate()) {
                      FocusScope.of(context).requestFocus(productNo);
                    }
                  },
                  validator: (val) => val.isEmpty ? 'Product Name' : null,
                  onChanged: (val) => setState(() => _productName = val)),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  focusNode: productNo,
                  key: _productNoKey,
                  onFieldSubmitted: (_) {
                    if (_productNoKey.currentState.validate()) {
                      FocusScope.of(context).requestFocus(currentDate);
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.add,
                        color: Colors.blue[900],
                      ),
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      labelText: 'Product No.'),
                  validator: (val) => val.isEmpty ? 'Enter Product No.' : null,
                  onChanged: (val) => setState(() => _serialNum = val)),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  key: _currentServiceDate,
                  focusNode: currentDate,
                  keyboardType: TextInputType.datetime,
                  onFieldSubmitted: (_) {
                    if (_currentServiceDate.currentState.validate()) {
                      FocusScope.of(context).requestFocus(currentData);
                    }
                  },
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.blue[900],
                      ),
                      labelText: 'Current Service Date'),
                  validator: (val) => val.isEmpty ? 'Enter Date' : null,
                  onChanged: (val) =>
                      setState(() => _dateofInstallation = val)),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Container(
                  height: 80.0,
                  child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 100,
                      key: _currentServiceData,
                      focusNode: currentData,
                      onFieldSubmitted: (_) {
                        if (_currentServiceData.currentState.validate()) {
                          FocusScope.of(context).requestFocus(nextDate);
                        }
                      },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.blue[900]),
                          prefixIcon: Icon(
                            Icons.note_add,
                            color: Colors.blue[900],
                          ),
                          labelText: 'Current Service Details'),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter Service Data';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) => setState(() => _partsServiced = val)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  key: _nextService,
                  keyboardType: TextInputType.datetime,
                  focusNode: nextDate,
                  onFieldSubmitted: (_) {
                    if (_nextService.currentState.validate()) {
                      FocusScope.of(context).requestFocus(submitButton);
                    }
                  },
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.blue[900],
                      ),
                      labelText: 'Enter Product\'s Next Service Date '),
                  validator: (val) =>
                      val.isEmpty ? 'Please Enter Next Service Date ' : null,
                  onChanged: (val) => setState(() => _nextServiceDate = val)),
              Container(
                height: 20,
                child: MessageGiver(
                  uid: user,
                ),
              ),
              InkWell(
                  onTap: () async {
                    // print(products);
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        content: Container(
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
                          child: QrImage(
                            data: "SKANET$_serialNum",
                            size: 0.5 * 600,
                            onError: (ex) {
                              print("[QR] ERROR - $ex");
                              setState(() {
                                Text("there is an error");
                              });
                            },
                          ),
                        ),
                      ),
                    );
                    try {
                      // print(DateTime.now().toString());
                      Database(uid: user).addSerialNumForQrCode(_serialNum);
                      // print("${widget.serialnum}");

                      Database(
                        uid: user,
                      ).updateUserProductData(
                          _productName,
                          _serialNum,
                          _dateofInstallation,
                          _partsServiced,
                          _nextServiceDate);
                      // ageRoute(builder: (context)=>Showgenqr(productName:_productName,serialNum: _serialNum,dateofInstallation:_dateofInstallation ,partsServiced:_partsServiced ,nextServiceDate:_nextServiceDate ,)));
                    } catch (e) {
                      print(e.toString());
                      Navigator.pop(context);
                      // _genQR();
                      return Text("Something went Wrong!!");
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        color: Colors.blue[900],
                        child: Center(
                            child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'SUBMIT FORM',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ))),
                  ))
            ],
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    productNo.dispose();
    currentDate.dispose();
    currentData.dispose();
    nextDate.dispose();
    submitButton.dispose();
  }
}
