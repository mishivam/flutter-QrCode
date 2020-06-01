import 'package:flutter/material.dart';
// import 'package:qrs/pages/history/productListHistory.dart';
import 'package:qrs/pages/history/scannedHistory.dart';
import 'package:qrs/pages/history/showSerialNumber.dart';
import 'package:qrs/pages/screen/notifications.dart';
import 'package:provider/provider.dart';
import 'package:qrs/modules/user.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Parts History'),
          bottom: TabBar(
            labelColor: Colors.white,
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: 'Scanned History',
              ),
              Tab(
                text: 'Generated History',
              )
            ],
          ),
        ),
        body: Stack(children: <Widget>[
          TabBarView(
            controller: _tabController,
            children: <Widget>[
              ShowAllScannedHistory(),
              // ShowProductListHistory()
              GetSerialNumber(),
            ],
          ),
          Container(
            height: 0.1,
            child: MessageGiver(
              uid: user,
            ),
          )
        ]));
  }
}
