class AllCommunityResponseModel {
  String? status;
  List<Data>? data;

  AllCommunityResponseModel({this.status, this.data});

  AllCommunityResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  Admin? admin;
  // List<String>? moderators;
  // List<Null>? mutedUsers;
  // List<Null>? bannedUsers;
  String? description;
  String? communityType;
  int? members;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.name,
      this.admin,
      // this.moderators,
      // this.mutedUsers,
      // this.bannedUsers,
      this.description,
      this.communityType,
      this.members,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
    // if (json['moderators'] != null) {
    //   moderators = <Null>[];
    //   json['moderators'].forEach((v) {
    //     moderators!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['muted_users'] != null) {
    //   mutedUsers = <Null>[];
    //   json['muted_users'].forEach((v) {
    //     mutedUsers!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['banned_users'] != null) {
    //   bannedUsers = <Null>[];
    //   json['banned_users'].forEach((v) {
    //     bannedUsers!.add(new Null.fromJson(v));
    //   });
    // }
    description = json['description'];
    communityType = json['community_type'];
    members = json['members'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    if (admin != null) {
      data['admin'] = admin!.toJson();
    }
    // if (moderators != null) {
    //   data['moderators'] = moderators!.map((v) => v.toJson()).toList();
    // }
    // if (mutedUsers != null) {
    //   data['muted_users'] = mutedUsers!.map((v) => v.toJson()).toList();
    // }
    // if (bannedUsers != null) {
    //   data['banned_users'] = bannedUsers!.map((v) => v.toJson()).toList();
    // }
    data['description'] = description;
    data['community_type'] = communityType;
    data['members'] = members;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Admin {
  String? sId;
  String? username;
  String? name;

  Admin({this.sId, this.username, this.name});

  Admin.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['name'] = name;
    return data;
  }
}