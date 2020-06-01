import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import "package:qrs/services/authBase.dart";
import 'package:qrs/pages/AddProduct/addProduct.dart';
// import 'package:qrs/pages/screen/notifications.dart';
import 'package:qrs/pages/notification/notificationlist.dart';
// import 'package:qrs/pages/screen/profilepage.dart';
import 'package:qrs/pages/screen/scanQR.dart';
import 'package:qrs/pages/screen/history.dart';
// import 'package:provider/provider.dart';
// import 'package:qrs/modules/user.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  // final AuthService _auth = AuthService();
  String barcode = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, initialIndex: 0, vsync: this);
  }

  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    return Scaffold(
        // appBar:
        //     new AppBar(title: new Text('Skanet', style: TextStyle(color: Colors.white,)),
        //     backgroundColor: Colors.blue[900],
        //     actions: <Widget>[
        //   // FlatButton.icon(
        //   //   icon: Icon(Icons.account_box),

        //   //   label: Text("Sign Out", style: TextStyle(color: Colors.white)),
        //   //   onPressed: () async {
        //   //     await _auth.signOut();
        //   //   },
        //   // ),
        // InkWell(
        //   onTap: ( )=> Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
        //     return Scaffold(
        //       body: ProfilePage(uName: user,),
        //     );
        //   })),
        //   child: CircleAvatar(
        //     child: Icon(Icons.perm_identity),
        //     backgroundColor: Colors.transparent,
        //   ),
        // )
        // ]),

        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ScanQr(),
            AddProduct(),
            History(),
            NotificationList(),
          ],
        ),
        bottomNavigationBar: TabBar(
          labelColor: Colors.blue[900],
          labelStyle: TextStyle(color: Colors.blue[900], fontSize: 10.0),
          controller: _tabController,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.select_all, size: 20.0),
              text: 'Scan QR',
            ),
            Tab(
              icon: Icon(Icons.add_box, size: 20.0),
              text: 'Add Product',
            ),
            Tab(
              icon: Icon(Icons.history, size: 20.0),
              text: 'History',
            ),
            Tab(
              icon: Icon(Icons.notifications, size: 20.0),
              text: 'Notifications',
            )
          ],
        ));
  }
}
