class PrivateChatListResponseModel {
  String? message;
  ReceiverDetails? receiverDetails;
  List<String>? receiverSenderId;
  bool? seen;
  bool? seen_actual;
  SenderDetails? senderDetails;
  String? receiverId;
  String? senderId;
  int? time;

  PrivateChatListResponseModel(
      {this.message,
      this.receiverDetails,
      this.receiverSenderId,
      this.seen,
      this.senderDetails,
      this.receiverId,
      this.senderId,
      this.seen_actual,
      this.time});

  PrivateChatListResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    receiverDetails = json['receiver_details'] != null
        ? ReceiverDetails.fromJson(json['receiver_details'])
        : null;
    receiverSenderId = json['receiver_sender_id'] is String
        ? null
        : json['receiver_sender_id']?.map<String>((x) => x.toString()).toList();
    seen = json['seen'];
    seen_actual = json['seen_actual'];
    senderDetails = json['sender_details'] != null
        ? SenderDetails.fromJson(json['sender_details'])
        : null;
    receiverId = json['receiver_id'];
    senderId = json['sender_id'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (receiverDetails != null) {
      data['receiver_details'] = receiverDetails!.toJson();
    }
    if (receiverSenderId != null) {
      data['receiver_sender_id'] = receiverSenderId!;
    }
    data['seen'] = seen;
    if (senderDetails != null) {
      data['sender_details'] = senderDetails!.toJson();
    }
    data['receiver_id'] = receiverId;
    data['sender_id'] = senderId;
    data['time'] = time;
    return data;
  }
}

class ReceiverDetails {
  String? receiverName;
  String? receiverProfilePicture;
  String? receiverUsername;

  ReceiverDetails(
      {this.receiverName, this.receiverProfilePicture, this.receiverUsername});

  ReceiverDetails.fromJson(Map<String, dynamic> json) {
    receiverName = json['receiver_name'];
    receiverProfilePicture = json['receiver_profile_picture'];
    receiverUsername = json['receiver_username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receiver_name'] = receiverName;
    data['receiver_profile_picture'] = receiverProfilePicture;
    data['receiver_username'] = receiverUsername;
    return data;
  }
}

class SenderDetails {
  String? senderName;
  String? senderProfilePicture;
  String? senderUsername;

  SenderDetails(
      {this.senderName, this.senderProfilePicture, this.senderUsername});

  SenderDetails.fromJson(Map<String, dynamic> json) {
    senderName = json['sender_name'];
    senderProfilePicture = json['sender_profile_picture'];
    senderUsername = json['sender_username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_name'] = senderName;
    data['sender_profile_picture'] = senderProfilePicture;
    data['sender_username'] = senderUsername;
    return data;
  }
}
