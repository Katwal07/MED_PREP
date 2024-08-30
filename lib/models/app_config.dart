class AppConfig {
  String? depricatedVersion;
  String? currentVersion;
  bool? displayRatingPopup;
  bool? forceUpdate;
  String? androidUrl;
  String? iosUrl;
  bool? paymentViaEsewa;
  bool? paymentViaKhalti;
  bool? paymentViaManually;
  bool? showQuestionOfDay;
  bool? showTreasures;

  AppConfig(
      {this.depricatedVersion,
      this.currentVersion,
      this.displayRatingPopup,
      this.forceUpdate,
      this.androidUrl,
      this.iosUrl,
      this.paymentViaEsewa = false,
      this.paymentViaKhalti = false,
      this.paymentViaManually = false,
      this.showQuestionOfDay = false,
      this.showTreasures = false});

  factory AppConfig.fromJson(json) {
    return AppConfig(
      depricatedVersion: json['depricated_version'],
      currentVersion: json['current_version'],
      displayRatingPopup:
          json['display_rating_popup'] ?? false,
      forceUpdate: json['force_update'] ?? false,
      androidUrl: json['android_url'],
      iosUrl: json['ios_url'],
      paymentViaEsewa: json['payment_via_esewa'] ?? false,
      paymentViaKhalti: json['payment_via_khalti'] ?? false,
      paymentViaManually:
          json['payment_via_manually'] ?? false,
      showQuestionOfDay:
          json['show_question_of_day'] ?? false,
      showTreasures: json['show_treasures'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "depricated_version": this.depricatedVersion,
      "current_version": this.currentVersion,
      "display_rating_popup": this.displayRatingPopup,
      "force_update": this.forceUpdate,
      "android_url": this.androidUrl,
      "ios_url": this.iosUrl,
      "payment_via_esewa": this.paymentViaEsewa,
      "payment_via_khalti": this.paymentViaKhalti,
      "payment_via_manually": this.paymentViaManually,
      'show_question_of_day': this.showQuestionOfDay,
      "show_treasures": this.showTreasures
    };
  }
}
