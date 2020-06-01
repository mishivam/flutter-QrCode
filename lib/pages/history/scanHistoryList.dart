import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrs/modules/scanHistory.dart';

class ScanHistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scannedHistoryList =
        Provider.of<List<ScanResultHistory>>(context) ?? [];
    return ListView.builder(
      itemCount: scannedHistoryList.length,
      itemBuilder: (context, index) {
        return ScanHistoryListTile(scanedHistory: scannedHistoryList[index]);
      },
    );
  }
}

class ScanHistoryListTile extends StatefulWidget {
  final ScanResultHistory scanedHistory;

  ScanHistoryListTile({this.scanedHistory});

  @override
  _ScanHistoryListTileState createState() => _ScanHistoryListTileState();
}

class _ScanHistoryListTileState extends State<ScanHistoryListTile> {
  GlobalKey globalKey = GlobalKey();
  _showDetails(BuildContext ctx, dataset) {
    return showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.translucent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Container(
                      child: RepaintBoundary(
                        child: QrImage(
                          data: dataset,
                          size: 0.5 * 600,
                          onError: (ex) {
                            print("[QR] ERROR - $ex");
                            setState(() {
                              Text("there is an error");
                            });
                          },
                        ),
                      ),
                    ),
                    Card(
                        child: ListTile(
                      title: Text(
                          "Scanned Result: ${widget.scanedHistory.scanResult}"),
                    )),
                  ]),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: ListTile(
              onTap: () =>
                  _showDetails(context, widget.scanedHistory.scanResult),
              title: Text('${widget.scanedHistory.scanResult}'),
              leading: SizedBox(
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImage(
                    data: widget.scanedHistory.scanResult,
                    size: 60,
                    onError: (ex) {
                      print("[QR] ERROR - $ex");
                      setState(() {
                        Text("there is an error");
                      });
                    },
                  ),
                ),
              ))),
    );
  }
}
