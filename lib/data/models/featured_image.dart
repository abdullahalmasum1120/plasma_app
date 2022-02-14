class FeatureImage {
  String? id;
  String? image;
  String? username;
  String? uid;

  FeatureImage({
    this.id,
    this.image,
    this.username,
    this.uid,
  });

  FeatureImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    username = json['username'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['username'] = username;
    data['uid'] = uid;
    return data;
  }
}
