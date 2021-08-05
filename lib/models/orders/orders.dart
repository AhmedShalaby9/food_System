class Orders {
  final String id;
  final String group;
  final String member_name;
  final String datetime;
  final String order_status;
  final String order_name;
  // final String sugar;
  final String url;
  final String quantity;
  final String date;
  final String price;
  var time;
  var addtions;
  Orders({
    this.time,
    this.date,
    this.price,
    this.url,
    this.group,
    this.quantity,
    // this.sugar,
    this.addtions,
    this.id,
    this.member_name,
    this.datetime,
    this.order_name,
    this.order_status,
  });
}
