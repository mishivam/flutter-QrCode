import 'package:flutter/material.dart';
import 'package:qrs/modules/user.dart';


class ProfilePage extends StatefulWidget {
  final User uName;
  ProfilePage({this.uName});
  // final String time=DateTime.now().toString();
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      backgroundColor: Colors.cyan,
      body: Stack(children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).size.height * 0.08,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
            elevation: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(widget.uName.userInfo.email),
                // Text(widget.time),
                
              ],
            ),
            
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            radius: 80.0,
            backgroundColor: Colors.green[300],
            child: Icon(Icons.perm_identity),
          ),
        )


      ],),
      
    );
  }
}