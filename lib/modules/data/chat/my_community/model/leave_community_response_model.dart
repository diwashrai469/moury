class LeaveCommunityResponseModel {
  String? status;
  String? data;

  LeaveCommunityResponseModel({this.status, this.data});

  LeaveCommunityResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data;
    return data;
  }
}