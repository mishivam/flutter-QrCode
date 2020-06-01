import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowQr extends StatefulWidget {

  final String productSerialNumber;

  ShowQr(this.productSerialNumber);

  @override
  _ShowQrState createState() => _ShowQrState();
}

class _ShowQrState extends State<ShowQr> {
  final GlobalKey globalKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: EdgeInsets.only(top:25),
      child: _genQrCode(),   
    );
  }

  _genQrCode(){
    return RepaintBoundary(
            key: globalKey,
            child: QrImage(
              data:widget.productSerialNumber,
              size: 0.5 * 400,
              onError: (ex) {
                print("[QR] ERROR - $ex");
                setState((){
                  Text("there is an error");
                });
              },
            ),
          );
  }

}