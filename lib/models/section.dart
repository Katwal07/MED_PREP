class Section {
  String? id; //required
  String? name;
  String? slugify;
  String? tag;
  String? photoUrl;

  Section({
    this.id,
    this.name,
    this.tag,
    this.slugify,
    this.photoUrl,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
      slugify: json['slugify'],
      tag: json['tag'],
      photoUrl: json['photoUrl'],
    );
  }
}

class SectionList {
  List<Section> sections;

  SectionList(this.sections);

  factory SectionList.fromJson(List<dynamic> json) {
    List<Section> sectionList;

    sectionList = json
        .where((element) => element != null)
        .toList()
        .map((x) => Section.fromJson(x))
        .toList();

    return SectionList(sectionList);
  }
}
