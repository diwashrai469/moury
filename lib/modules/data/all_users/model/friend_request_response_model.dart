// ignore_for_file: prefer_collection_literals

class FriendRequestResponseModel {
  String? status;
  String? data;

  FriendRequestResponseModel({this.status, this.data});

  FriendRequestResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['data'] = this.data;
    return data;
  }
}