class Notifications {
  final String title;
  final String body;
  final String devicetoken;

  Notifications({this.body, this.devicetoken, this.title});

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
        devicetoken: "<Device FCM token>", title: "test", body: "test");
  }
}
