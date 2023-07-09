class MyCommunityResponseModel {
  String? status;
  List<Communities>? communities;

  MyCommunityResponseModel({this.status, this.communities});

  MyCommunityResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['communities'] != null) {
      communities = <Communities>[];
      json['communities'].forEach((v) {
        communities!.add(Communities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (communities != null) {
      data['communities'] = communities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Communities {
  String? sId;
  String? memberId;
  CommunityId? communityId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Communities(
      {this.sId,
      this.memberId,
      this.communityId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Communities.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    memberId = json['member_id'];
    communityId = json['community_id'] != null
        ? CommunityId.fromJson(json['community_id'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['member_id'] = memberId;
    if (communityId != null) {
      data['community_id'] = communityId!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class CommunityId {
  String? sId;
  String? name;
  int? members;

  CommunityId({this.sId, this.name, this.members});

  CommunityId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    members = json['members'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['members'] = members;
    return data;
  }
}