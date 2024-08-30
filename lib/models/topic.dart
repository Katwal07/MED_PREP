class Topic {
  String? id;
  String? name; // required (between 3-40)
  String? description;
  TopicCreator? creator;

  String? priority;

  Topic({
    this.id,
    this.name,
    this.description,
    this.priority,
    this.creator,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      creator: TopicCreator.fromJson(json['creator']),
      priority: json['priority'],
    );
  }
}

class TopicList {
  List<Topic> topics;

  TopicList(this.topics);

  factory TopicList.fromJson(List<dynamic> json) {
    List<Topic> topicList;

    topicList = json
        .where((element) => element != null)
        .toList()
        .map((x) => Topic.fromJson(x))
        .toList();

    return TopicList(topicList);
  }
}

class TopicCreator {
  String? id;
  String? name;
  String? photoUrl;

  TopicCreator({
    this.id,
    this.name,
    this.photoUrl,
  });

  factory TopicCreator.fromJson(Map<String, dynamic> json) {
    return TopicCreator(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'],
    );
  }
}
