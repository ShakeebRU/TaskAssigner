class UserModel {
  UserModel({
    required this.token,
    required this.expiration,
    required this.userID,
    required this.username,
    required this.email,
    required this.description,
    required this.employeeId,
    required this.accountStatus,
    required this.status,
    required this.message,
  });
  late final String token;
  late final String expiration;
  late final int userID;
  late final String username;
  late final String email;
  late final String description;
  late final int employeeId;
  late final String accountStatus;
  late final bool status;
  late final String message;

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
    userID = json['userID'];
    username = json['username'];
    email = json['email'];
    description = json['description'];
    employeeId = json['employeeId'];
    accountStatus = json['accountStatus'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['expiration'] = expiration;
    _data['userID'] = userID;
    _data['username'] = username;
    _data['email'] = email;
    _data['description'] = description;
    _data['employeeId'] = employeeId;
    _data['accountStatus'] = accountStatus;
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}
