class RegisterViewResponseModels {
  String? status;
  String? accessToken;

  RegisterViewResponseModels({this.status, this.accessToken});

  RegisterViewResponseModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['accessToken'] = accessToken;
    return data;
  }
}
