

import 'chapter.dart';
import 'porgram.dart';
import 'section.dart';

class Treasures {
  String? id; //required
  // List<String> link;
  String? link;
  Program? program;
  Section? section;
  Chapter? chapter;
  bool? active;
  String? name;
  bool? free;
  String? createdAt;
  Treasures(
      {this.id,
      this.link,
      this.name,
      this.program,
      this.section,
      this.chapter,
      this.active,
      this.free,
      this.createdAt});

  factory Treasures.fromJson(Map<String, dynamic> json) {
    //
    return Treasures(
      id: json['id'],
      name: json['name'] ?? '',
      link: json['link'] ?? '',
      // link: List.from(json['link'].map((link) => link.toString())),
      program:
          json['program'] != null ? Program.fromJson(json['program']) : null,
      section:
          json['section'] != null ? Section.fromJson(json['section']) : null,
      chapter:
          json['chapter'] != null ? Chapter.fromJson(json['chapter']) : null,
      active: json['active'] ?? false,
      free: json['free'] ?? false,
      createdAt: json['createdAt'],
    );
  }
}

class TreasuresList {
  List<Treasures> treasures;

  TreasuresList(this.treasures);

  factory TreasuresList.fromJson(List<dynamic> json) {
    final treasuresList = json
        .where((element) => element != null)
        .toList()
        .map((x) => Treasures.fromJson(x))
        .toList();

    return TreasuresList(treasuresList);
  }
}
