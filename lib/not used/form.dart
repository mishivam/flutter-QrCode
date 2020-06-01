import 'package:flutter/material.dart';
// import 'package:qrs/pages/genqr.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrs/services/databaseService.dart';
// import 'package:qrs/pages/generateqr.dart';
import 'package:provider/provider.dart';
import 'package:qrs/modules/product.dart';
// import 'package:qr/pages/productList.dart';
// import 'package:qrs/services/databaseService.dart';

class Forms extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  void upanimation(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: DetailForm(),
            behavior: HitTestBehavior.translucent,
          );
        });
  }

  // final _=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
          value:Database().qrCodes,
          child: Scaffold(
          appBar: new AppBar(
            title: new Text('QR Code Generator'),
          ),
          // body: Center(
          //   child: Text('Add a Product'),
          // ),
          
          // body:ShowQrCode()??Text("Add Products by Clicking \'+'"),
          floatingActionButton: FloatingActionButton(
            onPressed: () => upanimation(context),
            child: Icon(
              Icons.add,
            ),
          )
      ),
    );
  }
}

class DetailForm extends StatefulWidget {
  @override
  _DetailFormState createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  final _productName = TextEditingController();
  final _serialNum = TextEditingController();
  final _dateofInstallation = TextEditingController();
  final _partsServiced = TextEditingController();
  final _nextServiceDate = TextEditingController();
  
  GlobalKey globalKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Product Name:',
            ),
            controller: _productName,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Product S/N:',
            ),
            controller: _serialNum,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Date of Installation :',
            ),
            controller: _dateofInstallation,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Parts Serviced:',
            ),
            controller: _partsServiced,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Product\'s Next Service Date:',
            ),
            controller: _nextServiceDate,
          ),
          RaisedButton(
            onPressed: () async {
              try{
                
                // await Database().updateProductData(_productName, _serialNum,
                //     _dateofInstallation, _partsServiced, _nextServiceDate); 
                // Navigator.pop(context);
                // return ShowQr(_serialNum.toString());
                return setState(()=>_genQR());           
              }catch(e){
                
                print(e.toString());
                Navigator.pop(context);
                return Text("Something went Wrong!!");
              }
            },
            child: Text('Save Details!'),
          )
        ],
      ),
    );
  }
  _genQR(){
    return RepaintBoundary(
      key: globalKey,
      child: QrImage(
        version:30 ,
            data:_serialNum.toString(),
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
