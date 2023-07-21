class CheckFriendResponseModel {
  String? status;
  String? friendshipStatus;
  bool? areFriends;

  CheckFriendResponseModel({this.status, this.friendshipStatus, this.areFriends});

  CheckFriendResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    friendshipStatus = json['friendship_status'];
    areFriends = json['are_friends'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['friendship_status'] = friendshipStatus;
    data['are_friends'] = areFriends;
    return data;
  }
}