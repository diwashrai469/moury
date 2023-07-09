class UserConfigResponseModel {
  String? status;
  Data? data;

  UserConfigResponseModel({this.status, this.data});

  UserConfigResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  
  int? following;
  String? sId;
  String? username;
  String? email;
  String? name;
  int? level;
  int? honeyDrops;
  int? streak;
  bool? active;
  String? createdAt;
  int? iV;
  String? profilePicture;
  int? followers;
  int? buzzs;

  Data(
      {
      this.following,
      this.sId,
      this.username,
      this.email,
      this.name,
      this.level,
      this.honeyDrops,
      this.streak,
      this.active,
      this.createdAt,
      this.iV,
      this.profilePicture,
      this.followers,
      this.buzzs});

  Data.fromJson(Map<String, dynamic> json) {
  
    following = json['following'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    level = json['level'];
    honeyDrops = json['honey_drops'];
    streak = json['streak'];
    active = json['active'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    profilePicture = json['profile_picture'];
    followers = json['followers'];
    buzzs = json['buzzs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
  
    data['following'] = following;
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['name'] = name;
    data['level'] = level;
    data['honey_drops'] = honeyDrops;
    data['streak'] = streak;
    data['active'] = active;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['profile_picture'] = profilePicture;
    data['followers'] = followers;
    data['buzzs'] = buzzs;
    return data;
  }
}