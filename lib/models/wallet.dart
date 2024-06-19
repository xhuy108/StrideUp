class Wallet {
  String code;
  String publicAddress;
  String? privateAddress;
  int bnbCoin;
  int zCoin;
  static const String COLLECTION_NAME = "wallet";
  Wallet({
    required this.code,
    required this.publicAddress,
    this.privateAddress,
    required this.bnbCoin,
    required this.zCoin,
  });

  // Tạo phương thức toJson để chuyển đổi đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'publicAddress': publicAddress,
      'privateAddress': privateAddress,
      'bnbCoin': bnbCoin,
      'zCoin': zCoin,
    };
  }

  // Tạo phương thức fromJson để chuyển đổi JSON thành đối tượng
  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      code: json['code'],
      publicAddress: json['publicAddress'],
      bnbCoin: (json['bnbCoin'] as num).toInt(),
      zCoin: (json['zCoin'] as num).toInt(),
    );
  }
}