import 'package:flutter/material.dart';
import 'package:barcode_flutter/barcode_flutter.dart';

class BarCodeInput extends StatefulWidget {

  final String barCodeType;

  BarCodeInput({this.barCodeType});

  @override
  _BarCodeInputState createState() => _BarCodeInputState();
}

class _BarCodeInputState extends State<BarCodeInput> {
  String _inputValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("${widget.barCodeType}"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin:EdgeInsets.symmetric(vertical:30,horizontal:20),
            child:TextField(
              onChanged: (val)=>setState(()=>_inputValue=val),
              decoration: InputDecoration(
                hintText:"Enter Proudct id"
              ),
            ),  
          ),
          RaisedButton(
            onPressed:(){
              print(_inputValue);
              showDialog(
                context: context,
                child: AlertDialog(
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                      child:BarCodeImage(
                        params: Code39BarCodeParams(
                          _inputValue,
                          lineWidth:
                              2.0,
                          barHeight: 90.0,
                          withText: true,
                        ),
                        onError: (error) {
                          print('error = $error');
                        },
                      )
                  )
                )
              );
            } ,
            child: Text(
              "Generate Barcode!"
            ),
          )
        ],
      ),
    );
  }
}