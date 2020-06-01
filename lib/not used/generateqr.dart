import 'package:flutter/material.dart';
import 'package:qrs/modules/product.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
class ShowQrCode extends StatefulWidget {
  @override
  _ShowQrCodeState createState() => _ShowQrCodeState();
}

class _ShowQrCodeState extends State<ShowQrCode> {
  @override
  Widget build(BuildContext context) {
    final products=Provider.of<List<Product>>(context)??[];
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context,index){
        return QrGenerator(products[index]);
      }
    );//product:products[]);
  }
}



class QrGenerator extends StatefulWidget {

  final Product product;

  QrGenerator(this.product);
  

  @override
  _QrGeneratorState createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  final GlobalKey globalKey = new GlobalKey();
  // String _inputErrorText="Error! Maybe your input value is too long?";

  @override
  Widget build(BuildContext context) {
    // final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
      return Padding(
      padding: EdgeInsets.only(top: 20),
      child:_contentWidget(),
    );
  }

  _contentWidget() {
    // final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: const EdgeInsets.only(top:20),
      
        child: RepaintBoundary(
          key: globalKey,
          child: QrImage(
            data:widget.product.serialNum,
            size: 0.5 * 400,
            onError: (ex) {
              print("[QR] ERROR - $ex");
              setState((){
                Text("there is an error");
              });
            },
          ),
        ),
      
    );
  }
}