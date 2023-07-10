class AllUsersResponseModel {
  String? status;
  List<Data>? data;

  AllUsersResponseModel({this.status, this.data});

  AllUsersResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? followers;
  int? following;
  int? streak;
  String? profilePicture;

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
    following = json['following'];
    followers = json['followers'];
    profilePicture = json["profile_picture"];
    username = json['username'];
    name = json['name'];
    level = json['level'];
    streak = json['streak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['following'] = following;
    data['followers'] = followers;
    data['username'] = username;
    data['profile_picture'] = profilePicture;
    data['name'] = name;
    data['level'] = level;
    data['streak'] = streak;
    return data;
  }
}
