connect(BuildContext context) async {
  final url = Uri.parse('ws://192.168.1.10:8000/ws/wc/');
  final channel = WebSocketChannel.connect(url);
  await channel.ready;
  channel.stream.listen((event) {
    final Map<String, dynamic> data = jsonDecode(event);
    try {
      if (data.containsKey('payload')) {
        Notifications noti = Notifications(
            created_at: DateTime.now(),
            id: 21,
            title: "Websocket message",
            subTitle: "Connected to websocket channel");

        NotificationHandler.showNotification(noti, context);
      } else {
        Notifications noti = Notifications(
            created_at: DateTime.parse(data['created_at']),
            id: data['id'],
            title: data['title'],
            subTitle: data['subTitle']);

        NotificationHandler.showNotification(noti, context);
        print("ee");
      }
    } catch (e) {
      Utils.printMessage("Exception:$e");
    }
  });
}
