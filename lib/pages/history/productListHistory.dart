// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:qrs/modules/serialNum.dart';
import 'package:qrs/pages/history/productList.dart';
import 'package:provider/provider.dart';
import 'package:qrs/services/databaseService.dart';
import 'package:qrs/modules/product.dart';
import 'package:qrs/modules/user.dart';
// import 'package:qrs/modules/serialNum.dart';

// final serialnumber = Provider.of<List<SerialNumber>>() ?? [];

class ShowProductListHistory extends StatefulWidget {
  final SerialNumber serialNumber;
  ShowProductListHistory({this.serialNumber});
  @override
  _ShowProductListHistoryState createState() => _ShowProductListHistoryState();
}

class _ShowProductListHistoryState extends State<ShowProductListHistory> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // print("ShowProductListHistory:${widget.serialNumber.serialnumber}");
    return StreamProvider<List<Product>>.value(
      value: Database(uid: user, serialnumber: widget.serialNumber).qrCodes,
      child: ProductList(),
    );
  }
}
