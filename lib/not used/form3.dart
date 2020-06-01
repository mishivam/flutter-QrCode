import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrs/services/databaseService.dart';
import 'package:qrs/constant/formdecoration.dart';
import 'package:provider/provider.dart';
import 'package:qrs/modules/user.dart';


class Forms extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  GlobalKey globalKey=GlobalKey();
  final _formkey=GlobalKey<FormState>();
  String _productName;
  String _serialNum;
  String _dateofInstallation ;
  String _partsServiced;
  String _nextServiceDate ;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    
 

    return  Scaffold(
          
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child:SingleChildScrollView(
                        child: Form(
                          key: _formkey,
                          
                          child: Column(
                            children:<Widget>[
                              Text("Enter Product Details!",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:Colors.blue,
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(hintText: 'Enter Product Details'),
                                validator:(val)=>val.isEmpty?'Please Enter Product Name ':null,
                                onChanged:(val)=>setState(()=>_productName=val)
                              ),
                              SizedBox(height: 10,),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(hintText: 'Enter Product Serial Number'),
                                validator:(val)=>val.isEmpty?'Please Enter the required Details ':null,
                                onChanged:(val)=>setState(()=>_serialNum=val)
                              ),
                              SizedBox(height: 10,),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(hintText: 'Enter Product Date of Installtion'),
                                validator:(val)=>val.isEmpty?'Please Enter the required Details ':null,
                                onChanged:(val)=>setState(()=>_dateofInstallation=val)
                              ),
                              SizedBox(height: 10,),
                              TextFormField(
                                decoration:textInputDecoration.copyWith(hintText: 'Enter Product Details'),
                                validator:(val)=>val.isEmpty?'Please Enter the Required Details ':null,
                                onChanged:(val)=>setState(()=>_partsServiced=val)
                              ),
                              SizedBox(height: 10,),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(hintText: 'Enter Product\'s Next Service Date '),
                                validator:(val)=>val.isEmpty?'Please Enter Next Service Date ':null,
                                onChanged:(val)=>setState(()=>_nextServiceDate=val)
                              ),
                              SizedBox(height: 10,),
                              RaisedButton(
                                onPressed: () async {
                                  try{
                                    await Database(uid: user).updateUserProductData(_productName, _serialNum,
                                        _dateofInstallation, _partsServiced, _nextServiceDate); 
                                    Navigator.pop(context);
                                    return null;
                                    // return ShowQr(_serialNum.toString());
                                    
                                  }catch(e){
                                    print(e.toString());
                                    Navigator.pop(context);
                                    // _genQR();
                                    return Text("Something went Wrong!!");
                                  }
                                },
                                child: Text('Generate Qr Code!'),
                                )
            
                            ],
                          )
                        ),
                      )
                    )
                  );
                }
              );
            },
            child: Icon(
              Icons.add,
            ),
          ),
          // body:_genQR(dataset),
          body:Padding(
              padding: EdgeInsets.fromLTRB(55, 25, 15, 0),
              child:_genQR()
            )
     
        );
  }
    _genQR(){
      return Container(
        
        child: RepaintBoundary(
          
          key: globalKey,
          child: QrImage(
                // data :serialnum,
                
                data:"$_productName\n$_serialNum\n$_dateofInstallation\n$_nextServiceDate\n$_partsServiced",
                size: 0.5 * 600,
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