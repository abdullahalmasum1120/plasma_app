class BloodRequest {
  String? id;
  String? thana;
  String? city;
  String? uid;
  String? hospital;
  String? phone;
  String? bloodGroup;
  String? description;
  String? image;
  String? time;
  String? date;
  String? username;

  BloodRequest({
    this.id,
    this.thana,
    this.city,
    this.uid,
    this.hospital,
    this.phone,
    this.bloodGroup,
    this.description,
    this.image,
    this.time,
    this.date,
    this.username,
  });

  BloodRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thana = json['thana'];
    city = json['city'];
    uid = json['uid'];
    hospital = json['hospital'];
    phone = json['phone'];
    bloodGroup = json['bloodGroup'];
    description = json['description'];
    image = json['image'];
    time = json['time'];
    date = json['date'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['thana'] = thana;
    data['city'] = city;
    data['uid'] = uid;
    data['hospital'] = hospital;
    data['phone'] = phone;
    data['bloodGroup'] = bloodGroup;
    data['description'] = description;
    data['image'] = image;
    data['time'] = time;
    data['date'] = date;
    data['username'] = username;
    return data;
  }
}
