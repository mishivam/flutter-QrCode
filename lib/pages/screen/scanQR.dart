import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:qrs/constant/loading.dart';
import 'package:qrs/pages/screen/notifications.dart';
import 'package:qrs/pages/screen/scanresul.dart';
import 'package:qrs/services/databaseService.dart';
import 'package:qrs/modules/user.dart';
import 'package:provider/provider.dart';
import 'package:qrs/services/authBase.dart';

class ScanQr extends StatefulWidget {
  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  String barcode = '';
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("appBar"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () async {
                      setState(() async {
                        loading = true;
                        _auth.signOut();
                      });
                    },
                    child: Text("sign out"))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          splashColor: Colors.blueGrey,
                          onPressed: () => scan(user),
                          child: const Text('START CAMERA SCAN')),
                    ),
                    Container(
                      height: 100,
                      child: MessageGiver(
                        uid: user,
                      ),
                    )
                  ],
                ),
              ),
              // ));
            ));
  }

  Future scan(User user) async {
    try {
      String barcode = await BarcodeScanner.scan();

      // setState(() async {

      if (barcode.substring(0, 6) == "SKANET") {
        this.barcode = barcode;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ShowResult(barcode)));
        await Database(uid: user).addScannerResult(barcode);
      } else {
        showDialog(
            context: context,
            child: AlertDialog(
              actions: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text(
                      "WARNING : This QR Code is Not Generated By Our Company! This app Cant scan this Code."),
                )
              ],
            ));
      }
      // }
      // });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
