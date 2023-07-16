class BuzzFeedResponseModel {
  String? status;
  List<Data>? data;

  BuzzFeedResponseModel({this.status, this.data});

  BuzzFeedResponseModel.fromJson(Map<String, dynamic> json) {
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
  UserId? userId;
  String? caption;
  int? likes;
  int? comments;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.userId,
      this.caption,
      this.likes,
      this.comments,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId =
        json['user_id'] != null ? UserId.fromJson(json['user_id']) : null;
    caption = json['caption'];
    likes = json['likes'];
    comments = json['comments'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (userId != null) {
      data['user_id'] = userId!.toJson();
    }
    data['caption'] = caption;
    data['likes'] = likes;
    data['comments'] = comments;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class UserId {
  String? sId;
  String? username;
  String? name;
  int? level;
  int? streak;
  String? profilePicture;
  int? followers;
  int? following;

  UserId(
      {this.sId,
      this.username,
      this.name,
      this.level,
      this.streak,
      this.profilePicture,
      this.followers,
      this.following});

  UserId.fromJson(Map<String, dynamic> json) {
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