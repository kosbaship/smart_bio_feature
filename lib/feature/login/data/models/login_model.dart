class LoginData {
  LoginData({
    required this.token,
    required this.user,
  });
  late final String token;
  late final User user;

  LoginData.fromJson(Map<String, dynamic> json){
    token = json['token'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
  });
  late final int id;
  late final String username;
  late final String password;
  late final String email;
  late final String firstName;
  late final String lastName;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['password'] = password;
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    return _data;
  }
}

