import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrs/modules/scanHistory.dart';
import 'package:qrs/modules/user.dart';
import 'package:qrs/services/databaseService.dart';
import 'package:qrs/pages/history/scanHistoryList.dart';

class ShowAllScannedHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<ScanResultHistory>>.value(
        value: Database(uid: user).resultFromScan,
        child: Scaffold(
            
            body: ScanHistoryList() ?? "No scanned history to show!"));
  }
}
