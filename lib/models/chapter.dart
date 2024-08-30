class Chapter {
  String? id; //required
  String? name;

  Chapter({
    this.id,
    this.name,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ChapterList {
  List<Chapter> chapters;
  int total;

  ChapterList(this.chapters, this.total);

  factory ChapterList.fromJson(
      List<dynamic> json, totalData) {
    List<Chapter> chapterList;

    chapterList = json
        .where((element) => element != null)
        .toList()
        .map((x) => Chapter.fromJson(x))
        .toList();

    return ChapterList(chapterList, totalData);
  }
}
