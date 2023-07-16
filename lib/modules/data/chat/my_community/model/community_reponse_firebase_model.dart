class CommunityChatModelOfFirebase {
  String? message;
  bool? seen;
  SenderDetails? senderDetails;
  String? senderId;
  String? sentBy;
  int? time;

  CommunityChatModelOfFirebase(
      {this.message,
      this.seen,
      this.senderDetails,
      this.senderId,
      this.sentBy,
      this.time});

  CommunityChatModelOfFirebase.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    seen = json['seen'];
    senderDetails = json['sender_details'] != null
        ? SenderDetails.fromJson(json['sender_details'])
        : null;
    senderId = json['sender_id'];
    sentBy = json['sent_by'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['seen'] = seen;
    if (senderDetails != null) {
      data['sender_details'] = senderDetails!.toJson();
    }
    data['sender_id'] = senderId;
    data['sent_by'] = sentBy;
    data['time'] = time;
    return data;
  }
}

class SenderDetails {
  String? senderColor;
  String? senderName;
  String? senderUsername;
  String? senderProfilePicture;

  SenderDetails({this.senderColor, this.senderName, this.senderUsername});

  SenderDetails.fromJson(Map<String, dynamic> json) {
    senderColor = json['sender_color'];
    senderName = json['sender_name'];
    senderUsername = json['sender_username'];
    senderProfilePicture = json['sender_profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_color'] = senderColor;
    data['sender_name'] = senderName;
    data['sender_username'] = senderUsername;
    data['sender_profile_picture'] = senderProfilePicture;
    return data;
  }
}
