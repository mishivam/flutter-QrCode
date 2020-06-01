import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
import 'package:provider/provider.dart';
import 'package:qrs/modules/user.dart';
import 'package:qrs/services/databaseService.dart';
import 'package:qrs/modules/notification.dart';
import 'package:qrs/pages/notification/shownotificationlist.dart';

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<Notifications>>.value(
            value: Database(uid: user).notification,
            child: Scaffold(
              appBar: AppBar(title: Text("notifications")),
              body: ShowNotificationList(),
            )) ??
        Center(
          child: Text(
            "Notification Is Empty!!",
            style: TextStyle(color: Colors.grey[200]),
          ),
        );
  }
}
