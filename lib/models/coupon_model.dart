class CouponModel {
  final String promoCode, message, validTill;
  final int limit, benifitValue;

  CouponModel(
      {this.benifitValue,
      this.limit,
      this.message,
      this.promoCode,
      this.validTill});

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      limit: json['limit'],
      benifitValue: json['benifitValue'],
      message: json['message'],
      promoCode: json['promoCode'],
      validTill: json['validTill'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'benifitValue': benifitValue,
      'message': message,
      'promoCode': promoCode,
      'validTill': validTill
    };
  }
}
