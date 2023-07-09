class LoginResponseModel {
  late String status;
  late String message;
  late String accessToken;

  LoginResponseModel(
      {required this.status,
      required this.message,
      required this.accessToken,
    });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    accessToken = json['accessToken'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['accessToken'] = accessToken;
    
    return data;
  }
}