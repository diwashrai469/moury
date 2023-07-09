import 'package:cloud_firestore/cloud_firestore.dart';

class PrivateChatListResponseModel {
  String? message;
  ReceiverDetails? receiverDetails;
  SenderDetails? senderDetails;
  String? senderId;
  String? receiverId;
  int? time;

  PrivateChatListResponseModel({
    this.message,
    this.receiverDetails,
    this.senderDetails,
    this.senderId,
    this.receiverId,
    this.time,
  });

  PrivateChatListResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    receiverDetails = json['receiver_details'] != null
        ? ReceiverDetails.fromJson(json['receiver_details'])
        : null;
    senderDetails = json['sender_details'] != null
        ? SenderDetails.fromJson(json['sender_details'])
        : null;
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    final dynamic jsonTime = json['time'];
    time = jsonTime is Timestamp ? jsonTime.seconds : jsonTime;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (receiverDetails != null) {
      data['receiver_details'] = receiverDetails!.toJson();
    }
    if (senderDetails != null) {
      data['sender_details'] = senderDetails!.toJson();
    }
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['time'] = time;

    return data;
  }
}

class ReceiverDetails {
  String? receiverName;
  String? receiverUsername;
  bool? seen;

  ReceiverDetails({
    this.receiverName,
    this.receiverUsername,
    this.seen,
  });

  ReceiverDetails.fromJson(Map<String, dynamic> json) {
    receiverName = json['receiver_name'];
    receiverUsername = json['receiver_username'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receiver_name'] = receiverName;
    data['receiver_username'] = receiverUsername;
    data['seen'] = seen;
    return data;
  }
}

class SenderDetails {
  String? senderName;
  String? senderUsername;
  String? senderProfilePicture;

  SenderDetails({this.senderName, this.senderUsername, this.senderProfilePicture});

  SenderDetails.fromJson(Map<String, dynamic> json) {
    senderName = json['sender_name'];
    senderUsername = json['sender_username'];
    senderProfilePicture = json['sender_profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_name'] = senderName;
    data['sender_username'] = senderUsername;
    data['sender_profile_picture'] = senderProfilePicture;
    return data;
  }
}
