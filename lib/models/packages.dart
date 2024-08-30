class Package {
  String? name;
  int? duration;
  int? price;
  String? id;
  String? createdAt;
  String? updatedAt;

  Package(
      {
      // this.user,
      this.name,
      this.duration,
      this.price,
      this.id,
      this.createdAt,
      this.updatedAt});

  factory Package.fromJson(Map<String, dynamic> json) {
    //
    return Package(
        id: json['id'],
        name: json['name'],
        duration: json['duration'],
        price: json['price'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}

class PackageList {
  List<Package> packages;

  PackageList(this.packages);

  factory PackageList.fromJson(List<dynamic> json) {
    List<Package> paymentList = json
        .where((element) => element != null)
        .toList()
        .map((i) => Package.fromJson(i))
        .toList();

    return PackageList(paymentList);
  }
}
