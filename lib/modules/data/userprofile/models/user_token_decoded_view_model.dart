// class UserTokenDecodedResponseModel {
//   String? id;
//   String? sId;
//   String? email;
//   String? name;
//   String? username;
//   String? profilePicture;

//   int? iat;

//   UserTokenDecodedResponseModel(
//       {this.id,
//       this.sId,
//       this.email,
//       this.name,
//       this.username,
//       this.profilePicture,
//       this.iat});

//   UserTokenDecodedResponseModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     sId = json['_id'];
//     email = json['email'];
//     name = json['name'];
//     username = json['username'];
//     profilePicture = json['profile_picture'];

//     iat = json['iat'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['_id'] = sId;
//     data['email'] = email;
//     data['name'] = name;
//     data['username'] = username;
//     data['profile_picture'] = profilePicture;

//     data['iat'] = iat;
//     return data;
//   }
// }
