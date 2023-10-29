// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationModel {
  int? status;
  String? message;
  int? count;
  List<Response>? response;

  NotificationModel({this.status, this.message, this.count, this.response});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  NotificationModel copyWith({
    int? status,
    String? message,
    int? count,
    List<Response>? response,
  }) {
    return NotificationModel(
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
      response: response ?? this.response,
    );
  }
}

class Response {
  String? notificationId;
  String? userType;
  String? delivery_user_id;
  String? type;
  String? openPage;
  String? openId;
  String? openSlug;
  String? title;
  String? msg;
  String? img;
  String? datetime;
  String? isSeen;

  Response(
      {this.notificationId,
      this.userType,
      this.delivery_user_id,
      this.type,
      this.openPage,
      this.openId,
      this.openSlug,
      this.title,
      this.msg,
      this.img,
      this.datetime,
      this.isSeen});

  Response.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    userType = json['user_type'];
    delivery_user_id = json['user_id'];
    type = json['type'];
    openPage = json['open_page'];
    openId = json['open_id'];
    openSlug = json['open_slug'];
    title = json['title'];
    msg = json['msg'];
    img = json['img'];
    datetime = json['datetime'];
    isSeen = json['is_seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['user_type'] = this.userType;
    data['user_id'] = this.delivery_user_id;
    data['type'] = this.type;
    data['open_page'] = this.openPage;
    data['open_id'] = this.openId;
    data['open_slug'] = this.openSlug;
    data['title'] = this.title;
    data['msg'] = this.msg;
    data['img'] = this.img;
    data['datetime'] = this.datetime;
    data['is_seen'] = this.isSeen;
    return data;
  }
}
