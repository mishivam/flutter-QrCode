// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:provider/provider.dart';
import 'package:qrs/modules/user.dart';
import 'package:qrs/services/databaseService.dart';
// import 'package:qrs/modules/notification.dart';

class MessageGiver extends StatefulWidget {
  final User uid;
  MessageGiver({this.uid});
  @override
  _MessageGiverState createState() => _MessageGiverState();
}

class _MessageGiverState extends State<MessageGiver> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        String _fcmToken = await _fcm.getToken();
        print("onMessage:$message");
        final String _title = message['notification']['title'];
        final String _msg = message['notification']['body'];
        try {
          await Database(uid: widget.uid).addNotifications(_fcmToken, message);
        } catch (e) {
          print(e.toString());
        }

        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(_title),
              subtitle: Text(_msg),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch:$message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onLaunch:$message');
      },
    ));
  }
}
