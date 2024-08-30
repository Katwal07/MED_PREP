class FBNotification {
  final String? id;
  final String? title;
  final String? body;
  final bool? seen;
  final String? createdAt;
  final String? type;

  FBNotification(
      {this.id, this.title, this.body, this.seen, this.createdAt, this.type});

  factory FBNotification.fromJson(Map<String, dynamic> json) {
    return FBNotification(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      seen: json['seen'] ?? false,
      createdAt: json['createdAt'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class NotificationList {
  List<FBNotification> notifications;

  NotificationList(this.notifications);

  factory NotificationList.fromJson(List<dynamic> json) {
    List<FBNotification> notificationList = json
        .where((element) => element != null)
        .toList()
        .map((i) => FBNotification.fromJson(i))
        .toList();

    return NotificationList(notificationList);
  }
}
