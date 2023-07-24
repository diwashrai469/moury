class AllCommunityChatListFromFirebaseModel {
  String? communityId;
  String? communityName;
  String? communityPicture;
  List<String>? seenBy;
  String? senderMessage;
  String? senderName;
  String? senderProfilePicture;
  String? senderUsername;
  int? time;

  AllCommunityChatListFromFirebaseModel(
      {this.communityId,
      this.communityName,
      this.communityPicture,
      this.seenBy,
      this.senderMessage,
      this.senderName,
      this.senderProfilePicture,
      this.senderUsername,
      this.time});

  AllCommunityChatListFromFirebaseModel.fromJson(Map<String, dynamic> json) {
    communityId = json['community_id'];
    communityName = json['community_name'];
    communityPicture = json['community_picture'];
    seenBy = json['seen_by'].cast<String>();
    senderMessage = json['sender_message'];
    senderName = json['sender_name'];
    senderProfilePicture = json['sender_profile_picture'];
    senderUsername = json['sender_username'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['community_id'] = communityId;
    data['community_name'] = communityName;
    data['community_picture'] = communityPicture;
    data['seen_by'] = seenBy;
    data['sender_message'] = senderMessage;
    data['sender_name'] = senderName;
    data['sender_profile_picture'] = senderProfilePicture;
    data['sender_username'] = senderUsername;
    data['time'] = time;
    return data;
  }
}