class UserModel {
  String? uid;
  String? password;
  String? mobile;
  String? email;
  String? name;
  String? profilePicUrl;

  UserModel(
      {this.uid,
      this.password,
      this.mobile,
      this.email,
      this.name,
      this.profilePicUrl});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    password = json["password"];
    mobile = json["mobile"];
    email = json["email"];
    name = json["name"];
    profilePicUrl = json["profilePicUrl"];
  }

  static List<UserModel> fromList(List<dynamic> list) {
    return list.map((map) => UserModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["uid"] = uid;
    _data["password"] = password;
    _data["mobile"] = mobile;
    _data["email"] = email;
    _data["name"] = name;
    _data["profilePicUrl"] = profilePicUrl;
    return _data;
  }

  UserModel copyWith({
    String? uid,
    String? password,
    String? mobile,
    String? email,
    String? name,
    String? profilePicUrl,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        password: password ?? this.password,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email,
        name: name ?? this.name,
        profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      );
}
