import 'package:flutter/material.dart';
// import 'package:qrs/pages/screen/scanQR.dart';

class ShowResult extends StatelessWidget {
  final String barcode;
  ShowResult(this.barcode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("scanned Result")),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(child: Text("Result is - ${barcode.substring(6)}")),
        ));
  }
}
