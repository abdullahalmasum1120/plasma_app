class MyUser {
  String? username;
  String? bloodGroup;
  String? city;
  String? thana;
  String? phone;
  String? uid;
  String? image;
  int? requested;
  int? donated;
  bool? isAvailable;

  MyUser({
    this.username,
    this.bloodGroup,
    this.city,
    this.thana,
    this.phone,
    this.uid,
    this.image,
    this.requested,
    this.donated,
    this.isAvailable,
  });

  MyUser.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    bloodGroup = json['bloodGroup'];
    city = json['city'];
    thana = json['thana'];
    phone = json['phone'];
    uid = json['id'];
    image = json['image'];
    requested = json['requested'];
    donated = json['donated'];
    isAvailable = json["isAvailable"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['bloodGroup'] = bloodGroup;
    data['city'] = city;
    data['thana'] = thana;
    data['phone'] = phone;
    data['id'] = uid;
    data['image'] = image;
    data['requested'] = requested;
    data['donated'] = donated;
    data['isAvailable'] = isAvailable;
    return data;
  }
}
