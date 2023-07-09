class ExploreResponseModel {
  String? status;
  List<Data>? data;

  ExploreResponseModel({this.status, this.data});

  ExploreResponseModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.sId, this.username, this.name, this.level, this.streak});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    name = json['name'];
    level = json['level'];
    streak = json['streak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['name'] = name;
    data['level'] = level;
    data['streak'] = streak;
    return data;
  }
}