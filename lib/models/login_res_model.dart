// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginResModel {
  LoginResModel({
    required this.status,
    required this.message,
    required this.count,
    required this.response,
  });
  late final int status;
  late final String message;
  late final int count;
  late final List<UserModel> response;

  LoginResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    response =
        List.from(json['response']).map((e) => UserModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['count'] = count;
    _data['response'] = response.map((e) => e.toJson()).toList();
    return _data;
  }
}

class UserModel {
  UserModel(
      {this.deliveryUserId,
      this.username,
      this.fname,
      this.lname,
      this.adminApproved,
      this.adminMessage,
      this.updateLocation,
      this.mobile});
  late final String? deliveryUserId;
  late final String? username;
  late final String? updateLocation;
  late final String? fname;
  late final String? lname;
  late final String? adminApproved;
  late final String? adminMessage;
  late final String? mobile;

  UserModel.fromJson(Map<String, dynamic> json) {
    deliveryUserId = json['delivery_user_id'];
    username = json['username'];
    fname = json['fname'];
    lname = json['lname'];
    adminApproved = json['admin_approved'];
    adminMessage = json['admin_message'];
    updateLocation = json['update_location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['delivery_user_id'] = deliveryUserId;
    _data['username'] = username;
    _data['fname'] = fname;
    _data['lname'] = lname;
    _data['admin_approved'] = adminApproved;
    _data['admin_message'] = adminMessage;
    return _data;
  }

  UserModel copyWith({
    String? deliveryUserId,
    String? username,
    String? fname,
    String? lname,
    String? adminApproved,
    String? adminMessage,
    String? mobile,
  }) {
    return UserModel(
        deliveryUserId: deliveryUserId ?? this.deliveryUserId,
        username: username ?? this.username,
        fname: fname ?? this.fname,
        lname: lname ?? this.lname,
        adminApproved: adminApproved ?? this.adminApproved,
        adminMessage: adminMessage ?? this.adminMessage,
        mobile: mobile ?? this.mobile,
        updateLocation: updateLocation ?? this.updateLocation);
  }
}
