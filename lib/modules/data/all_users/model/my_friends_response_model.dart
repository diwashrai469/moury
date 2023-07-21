class MyFriendsResponseModel {
  String? status;
  List<Data>? data;

  MyFriendsResponseModel({this.status, this.data});

  MyFriendsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? username;
  String? name;
  int? level;
  int? streak;
  String? profilePicture;
  int? followers;
  int? following;

  Data(
      {this.sId,
      this.username,
      this.name,
      this.level,
      this.streak,
      this.profilePicture,
      this.followers,
      this.following});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    name = json['name'];
    level = json['level'];
    streak = json['streak'];
    profilePicture = json['profile_picture'];
    followers = json['followers'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['name'] = name;
    data['level'] = level;
    data['streak'] = streak;
    data['profile_picture'] = profilePicture;
    data['followers'] = followers;
    data['following'] = following;
    return data;
  }
}