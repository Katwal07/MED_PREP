import 'question.dart';

class Message {
  String? id; //required
  String? message;
  int? messageType; // default - 0, 1 - (image only), 1 - (question lin only)
  String? img; // defeault - ''
  Question? question; // populated  question or null (based on messageType)
  Sender? sender; // Will have populated user - name and photo

  String? topic; // Topic.

  Message(
      {this.id,
      this.message,
      this.messageType,
      this.img,
      this.question,
      this.sender,
      this.topic});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['messageType'] == 0 ? json['message'] : null,
      messageType: json['messageType'],
      img: json['messageType'] == 1 ? json['img'] : null,
      question:
          json['messageType'] == 2 ? Question.fromJson(json['question']) : null,
      sender: Sender.fromJson(json['sender']),
      topic: json['topic'],
    );
  }
}

class MessageList {
  List<Message> messages;

  MessageList(this.messages);

  factory MessageList.fromJson(List<dynamic> json) {
    List<Message> messageList;

    messageList = json
        .where((element) => element != null)
        .toList()
        .map((x) => Message.fromJson(x))
        .toList();

    return MessageList(messageList);
  }
}

class Sender {
  String? id;
  String? name;
  String? photoUrl;

  Sender({
    this.id,
    this.name,
    this.photoUrl,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'],
    );
  }
}
