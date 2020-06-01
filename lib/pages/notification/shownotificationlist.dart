// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'dart:io';
import 'package:provider/provider.dart';
// import 'package:qrs/modules/user.dart';
// import 'package:qrs/services/databaseService.dart';
import 'package:qrs/modules/notification.dart';

class ShowNotificationList extends StatefulWidget {
  @override
  _ShowNotificationListState createState() => _ShowNotificationListState();
}

class _ShowNotificationListState extends State<ShowNotificationList> {
  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<List<Notifications>>(context) ?? [];
    print(notifications);
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        print(notifications[index].message);
        return NotificationTile(notification: notifications[index]);
      },
    );
  }
}

class NotificationTile extends StatefulWidget {
  final Notifications notification;
  NotificationTile({this.notification});
  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  // GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // print('${widget.notification.title}');
    print('${widget.notification.message}');
    print('Recieved On : ${widget.notification.time.toString()}');
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: ListTile(
            onTap: () {},
            title: Text('Title : ${widget.notification.message}'),
            subtitle:
                Text('Recieved On : ${widget.notification.time.toString()}'),
          )),
    );
  }
}
