import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrs/modules/product.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:qr/services/databaseService.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context) ?? [];
    print(products);
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        // print(products[index]);
        return ProductTile(product: products[index]);
      },
    );
  }
}

class ProductTile extends StatefulWidget {
  final Product product;

  ProductTile({this.product});

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
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
                      title:
                          Text("Product Name: ${widget.product.productName}\n"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text(
                          "Product Serial Number:${widget.product.serialNum}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text(
                          "Product Installation Date:${widget.product.dateofInstallation}"),
                    )),
                    Card(
                        child: ListTile(
                      title: Text(
                          "Product's Parts Serviced:${widget.product.partsServiced}"),
                    )),
                    Card(
                        child: ListTile(
                            title: Text(
                                "Product's Next Service Date:${widget.product.nextServiceDate}")))
                  ]),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    String dataset = "${widget.product.serialNum}";
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: ListTile(
              onTap: () => _showDetails(context, dataset),
              title: Text('${widget.product.serialNum}'),
              subtitle: Text(widget.product.productName),
              leading: SizedBox(
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImage(
                    data: dataset,
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
