class Payment {
  String? user;
  String? description;
  String? packageType;
  String? id;
  String? paymentStatus;
  String? image;
  String? paidVia;
  String? dateFrom;
  String? dateTo;
  String? createdAt;
  String? updatedAt;

  Payment(
      {
      // this.user,
      this.description,
      this.paidVia,
      this.dateTo,
      this.dateFrom,
      this.createdAt,
      this.id,
      this.paymentStatus,
      this.image,
      this.packageType,
      this.updatedAt});

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
        id: json['id'],
        // user: json['user']['name'],
        description: json['description'],
        paymentStatus: json['paymentStatus'],
        paidVia: json['paidVia'],
        packageType: json['packageType']['name'],
        dateTo: json['dateTo'],
        dateFrom: json['dateFrom'],
        createdAt: json['createdAt'],
        image: json['image'] ?? '',
        updatedAt: json['updatedAt']);
  }
}

class PaymentList {
  List<Payment> payments;

  PaymentList(this.payments);

  factory PaymentList.fromJson(List<dynamic> json) {
    List<Payment> paymentList = json
        .where((element) => element != null)
        .toList()
        .map((i) => Payment.fromJson(i))
        .toList();

    return PaymentList(paymentList);
  }
}
