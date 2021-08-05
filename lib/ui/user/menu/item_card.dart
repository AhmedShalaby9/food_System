import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:garson_app/controller/api_controller.dart';

class ItemCard extends StatefulWidget {
  final String name;
  final String url;
  ItemCard({this.name, this.url});
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
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

    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Container(
            decoration: BoxDecoration(),
            height: _height * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: widget.url,
                  fit: BoxFit.fitHeight,
                  width: _width * 0.4,
                  alignment: Alignment.topRight,
                  height: _height * 0.15,
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
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0))),
                  height: _height * 0.2,
                  width: 10.0,
                ),
              ],
            )));
  }
}
