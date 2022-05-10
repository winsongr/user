class Sellers {
  String? sellerUid;
  String? sellerName;
  String? sellerAvatarUrl;
  String? sellerEmail;

  Sellers(
      {this.sellerUid,
      this.sellerName,
      this.sellerAvatarUrl,
      this.sellerEmail});

  Sellers.fromJson(Map<String, dynamic> json) {
    sellerUid = json["sellerUid"];
    sellerName = json["sellerName"];
    sellerAvatarUrl = json["sellerAvatarUrl"];
    sellerEmail = json["sellerEmail"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["sellerUid"] = sellerUid;
    data["sellerName"] = sellerName;
    data["sellerAvatarUrl"] = sellerAvatarUrl;
    data["sellerEmail"] = sellerEmail;
    return data;
  }
}
