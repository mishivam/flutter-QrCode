import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qrs/modules/notification.dart';
import 'package:qrs/modules/serialNum.dart';
// import 'package:flutter/cupertino.dart';
import 'package:qrs/modules/product.dart';
import 'package:qrs/modules/scanHistory.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:qrs/modules/user.dart';
// import 'package:qrs/not%20used/generateqr.dart';

class Database {
  final User uid;
  final SerialNumber serialnumber;
  // final String genTime;
  final DateTime time = DateTime.now();
  Database({this.uid, this.serialnumber});

  // String userEmail=uid.userInfo.email;
  final CollectionReference qrCode = Firestore.instance.collection('qrCodes');
  final CollectionReference scansResult =
      Firestore.instance.collection('scanResult');
  final CollectionReference upTime = Firestore.instance.collection("Time");
  final CollectionReference notify = Firestore.instance.collection("users");
  final CollectionReference emp = Firestore.instance.collection("Employee");
  final CollectionReference serNum =
      Firestore.instance.collection("QrSerialNumber");

  Future updateUserProductData(
      String productName,
      String serialNum,
      String dateofInstallation,
      String partsServiced,
      String nextServiceDate) async {
    print("updateUserProductData:$serialNum");
    return await qrCode
        .document(uid.emailId)
        .collection(serialNum)
        // .document(serialNum)
        // .document("HistoryByTime")
        .document(time.toString())
        .setData(
      {
        'productName': productName,
        'serialNum': serialNum,
        'dateofInstallation': dateofInstallation,
        'partsServiced': partsServiced,
        'nextServiceDate': nextServiceDate,
        'Date': time.toString().substring(0, 10),
        'Time': time.toString().substring(11),
        'CurrentDateTime': time.toString(),
      },
    );
  }

  //stream snapshots of products ...

  Stream<List<Product>> get qrCodes {
    // print("qrCodes Recieved:${serialnumber.serialnumber}");
    return qrCode
        .document(uid.emailId)
        .collection(serialnumber.serialnumber)
        .snapshots()
        .map(_productListFromSnapshots);
  }

  List<Product> _productListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Product(
        productName: doc.data['productName'] ?? '',
        serialNum: doc.data['serialNum'] ?? '',
        dateofInstallation: doc.data['dateofInstallation'] ?? null,
        partsServiced: doc.data['partsServiced'] ?? '',
        nextServiceDate: doc.data['nextServiceDate'] ?? null,
      );
    }).toList();
  }

  Future addSerialNumForQrCode(String serialNum) async {
    print("addSerialNumForQrCode:$serialNum");
    return await serNum
        .document(uid.emailId)
        .collection("time")
        .document(time.toString())
        .setData({
      'serialNumber': serialNum,
    });
  }

  List<SerialNumber> _getSerialNumber(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return SerialNumber(serialnumber: doc.data['serialNumber']);
    }).toList();
  }

  //fetch serailnUm for qrCode...
  Stream<List<SerialNumber>> get serialNumber {
    return serNum
        .document(uid.emailId)
        .collection("time")
        .snapshots()
        .map(_getSerialNumber);
  }

  // Future addEmpId(String eid, String phoneNo) async {
  //   return await emp.document('employeeID').setData({"eid": eid});
  // }

  Future<bool> checkEid(String eid) {
    return emp.document(eid).get().then((doc) {
      if (!doc.exists) {
        return false;
      } else {
        return true;
      }
    });
  }

  Future<String> getNumber(String eid) {
    return emp.document(eid).get().then((doc) {
      return doc['phone'];
    });
  }

  Future addNotifications(String token, message) async {
    return await notify
        .document(uid.emailId)
        .collection('TokensByTime')
        .document(time.toString())
        .updateData({
      'userToken': token,
      'createdAt': time.toString(),
      // 'title ': title,
      'message ': message,
    });
  }

  //scanner result will store in scanResult Database....
  Future addScannerResult(String result) async {
    return await scansResult
        .document(uid.emailId)
        .collection("History")
        .document(time.toString())
        .setData({
      'ScannerResult': result,
    });
  }

  //List of all scannedresult ..
  List<ScanResultHistory> _scanResultFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ScanResultHistory(
        scanResult: doc.data['ScannerResult'] ?? 'No Result',
      );
    }).toList();
  }

  //Stream for ScannedResult..
  Stream<List<ScanResultHistory>> get resultFromScan {
    return scansResult
        .document(uid.emailId)
        .collection("History")
        .snapshots()
        .map(_scanResultFromSnapshot);
  }

  List<Notifications> _notificationfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Notifications(
        token: doc.data['userToken'],
        time: doc.data["createdAt"] ?? null,
        // title: doc.data['title'],
        message: doc.data['message'],
      );
    }).toList();
  }

  Stream<List<Notifications>> get notification {
    return notify
        .document(uid.emailId)
        .collection('TokensByTime')
        .snapshots()
        .map(_notificationfromsnapshot);
  }
}
