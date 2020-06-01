import 'package:flutter/material.dart';
import 'package:qrs/pages/AddProduct/generate_qr_code.dart';
import 'package:qrs/pages/AddProduct/genrate_Barcode.dart';
// import 'package:provider/provider.dart';
// import 'package:qrs/modules/product.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<List<Product>>(context) ?? [];

    return Scaffold(
        // appBar: AppBar(
        //   title:Text("Add Product")
        // ),
        // backgroundColor: Colors.lightBlue[200],
        appBar: AppBar(
          title: Text(
            'Add Product',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue[900],
          bottom: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: [
                Tab(
                  text: 'GENERATE QR CODE',
                ),
                Tab(
                  text: 'GENERATE BAR CODE',
                )
              ]),
        ),
        body: Center(
          child: TabBarView(controller: _tabController, children: <Widget>[
            FormToAdd(),
            BarcodeGen(),
          ]),
        ));
  }
}
