// {
// "title": "",
// "body": "",
// "time": "",
// "date": "",
// "docId": "",
// "senderUid": "",
// "receiverUid": ""
// }

class Notification {
  String? title;
  String? body;
  String? time;
  String? date;
  String? docId;
  String? senderUid;
  String? receiverUid;

  Notification(
      {this.title,
        this.body,
        this.time,
        this.date,
        this.docId,
        this.senderUid,
        this.receiverUid});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    time = json['time'];
    date = json['date'];
    docId = json['docId'];
    senderUid = json['senderUid'];
    receiverUid = json['receiverUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['time'] = time;
    data['date'] = date;
    data['docId'] = docId;
    data['senderUid'] = senderUid;
    data['receiverUid'] = receiverUid;
    return data;
  }
}