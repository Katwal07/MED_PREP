class Program {
  String? name;
  String? id;

  Program({this.name, this.id});

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(name: json['name'], id: json['id']);
  }
}

class ProgramList {
  List<Program> programs;

  ProgramList(this.programs);

  factory ProgramList.fromJson(List<dynamic> json) {
    List<Program> programList = json
        .where((element) => element != null)
        .toList()
        .map((i) => Program.fromJson(i))
        .toList();

    return ProgramList(programList);
  }
}
