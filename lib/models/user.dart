class User {
  String? id;
  String? photoUrl;
  String? name;
  String? email;
  bool? isUserVerified = false;
  String? selectedProgram;
  String? role;
  String? info;
  bool? enableNotification = true;

  User(
      {this.id,
      this.photoUrl,
      this.name,
      this.email,
      this.selectedProgram,
      this.isUserVerified,
      this.role,
      this.info,
      this.enableNotification});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      selectedProgram: json['selectedProgram'],
      photoUrl: json['photoUrl'],
      isUserVerified: json['isUserVerified'],
      role: json['role'],
      info: json['info'],
      enableNotification: json['enableNotification'],
    );
  }

  User.fromResponseObject(Map<String, dynamic> json) {
    id = json['data']['id'];
    name = json['data']['name'];
    email = json['data']['email'];
    selectedProgram = json['data']['selectedProgram'];
    photoUrl = json['data']['photoUrl'];
    isUserVerified = json['data']['isUserVerified'];
    role = json['data']['role'];
    info = json['data']['info'];
    enableNotification = json['data']['enableNotification'];
  }

  User.fromGetMeJson(Map<String, dynamic> json) {
    id = json['data']['id'];
    name = json['data']['name'];
    email = json['data']['email'];
    selectedProgram = json['data']['selectedProgram'];
    photoUrl = json['data']['photoUrl'];
    isUserVerified = json['data']['isUserVerified'];
    role = json['data']['role'];
    info = json['data']['info'];
    enableNotification = json['data']['enableNotification'];
  }
}
