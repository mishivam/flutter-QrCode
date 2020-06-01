import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// import 'package:flutter/material.dart';
import 'package:qrs/pages/history/productListHistory.dart';
import 'package:provider/provider.dart';
import 'package:qrs/services/databaseService.dart';
// import 'package:qrs/modules/product.dart';
import 'package:qrs/modules/user.dart';
import 'package:qrs/modules/serialNum.dart';

class GetSerialNumber extends StatefulWidget {
  @override
  _GetSerialNumberState createState() => _GetSerialNumberState();
}

class _GetSerialNumberState extends State<GetSerialNumber> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<SerialNumber>>.value(
      value: Database(uid: user).serialNumber,
      child: Scaffold(
        body: ShowSerialNumberList() ?? Text("No products to show!!"),
      ),
    );
  }
}

class ShowSerialNumberList extends StatefulWidget {
  @override
  _ShowSerialNumberListState createState() => _ShowSerialNumberListState();
}

class _ShowSerialNumberListState extends State<ShowSerialNumberList> {
  @override
  Widget build(BuildContext context) {
    final serialnumber = Provider.of<List<SerialNumber>>(context) ?? [];
    print("serialnumber:$serialnumber");
    return ListView.builder(
        itemCount: serialnumber.length,
        itemBuilder: (context, index) {
          print(
              "ShowSerialNumberListState : serialNumber : ${serialnumber[index].serialnumber}");
          return ShowSerialNumberTile(
            productSerialNum: serialnumber[index],
          );
        });
  }
}

class ShowSerialNumberTile extends StatefulWidget {
  final SerialNumber productSerialNum;
  ShowSerialNumberTile({this.productSerialNum});
  @override
  _ShowSerialNumberTileState createState() => _ShowSerialNumberTileState();
}

class _ShowSerialNumberTileState extends State<ShowSerialNumberTile> {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String dataset = "${widget.productSerialNum}";
    return Card(
        margin: EdgeInsets.only(top: 10),
        child: ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShowProductListHistory(serialNumber: widget.productSerialNum,))),
          title: Text("$dataset"),
          leading: SizedBox(
            child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                    data: dataset,
                    size: 60,
                    onError: (ex) {
                      print("[QR] ERROR - $ex");
                      setState(() {
                        Text("there is an error");
                      });
                    })),
          ),
        ));
  }
}
