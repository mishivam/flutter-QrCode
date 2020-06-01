import 'package:qrs/pages/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrs/modules/user.dart';
import 'package:qrs/pages/screen/home.dart';
// import 'package:qrs/constant/loading.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // print(user.emailId);
    if (user == null) {
      return Authenticate();
    } else {
      return ScanScreen();
    }
  }
}
