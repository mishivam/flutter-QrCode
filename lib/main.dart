// import 'dart:js';

import 'package:qrs/pages/wrapper.dart';
import 'package:qrs/services/authBase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrs/modules/user.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        
        // home: MessageHandler(),
        home:Wrapper(), 
      ),
    );
  }
}

// This widget is the root of your application.

// }

