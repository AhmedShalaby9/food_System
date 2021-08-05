import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:garson_app/controller/api_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:garson_app/models/products/products.dart';
import 'editProducts_Screen.dart';

class ProductCard extends StatefulWidget {
  final Products products;
  ProductCard({this.products});
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Controller controller = new Controller();
  @override
  void initState() {
    print('object');
    print(controller.getdataList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return Edit(Products(
              id: widget.products.id,
              name: widget.products.name,
              price: widget.products.price,
              qty: widget.products.qty,
              type: widget.products.type,
              url: widget.products.url));
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
            elevation: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: widget.products.url,
                    fit: BoxFit.fitHeight,
                    width: _width * 0.4,
                    alignment: Alignment.topLeft,
                    height: _height * 0.13,
                    placeholder: (context, url) => Center(
                        child: SpinKitThreeBounce(
                      size: 25.0,
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor),
                        );
                      },
                    )),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.products.name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          new Icon(Icons.assignment_rounded),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.products.qty.toString(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: _width * 0.08,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.money)),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              widget.products.price.toString(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
