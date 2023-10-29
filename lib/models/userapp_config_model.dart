class UserAppConfigModel {
  int? status;
  String? message;
  int? count;
  List<Response>? response;

  UserAppConfigModel({this.status, this.message, this.count, this.response});

  UserAppConfigModel.fromJson(Map<String, dynamic> json) {
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
}

class Response {
  String? perPage;
  String? multiFilter;
  String? multiFilterJoinString;
  String? email1;
  String? email2;
  String? mobile1;
  String? mobile2;
  String? whatsappNumber;
  String? address;
  String? referralUser;
  String? paymnetMod;
  String? paymnetKey;
  String? clientSecret;
  String? clientIdentifier;
  List<SidebarMenu>? sidebarMenu;
  List<MaintenanceScreen>? maintenanceScreen;
  // List<Null>? popupScreen;
  // List<Null>? appScreen;

  Response({
    this.perPage,
    this.multiFilter,
    this.multiFilterJoinString,
    this.email1,
    this.email2,
    this.mobile1,
    this.mobile2,
    this.whatsappNumber,
    this.address,
    this.referralUser,
    this.paymnetMod,
    this.paymnetKey,
    this.clientSecret,
    this.clientIdentifier,
    this.sidebarMenu,
    this.maintenanceScreen,
    // this.popupScreen,
    // this.appScreen
  });

  Response.fromJson(Map<String, dynamic> json) {
    perPage = json['per_page'];
    multiFilter = json['multi_filter'];
    multiFilterJoinString = json['multi_filter_join_string'];
    email1 = json['email1'];
    email2 = json['email2'];
    mobile1 = json['mobile1'];
    mobile2 = json['mobile2'];
    whatsappNumber = json['whatsapp_number'];
    address = json['address'];
    referralUser = json['referral_user'];
    paymnetMod = json['paymnet_mod'];
    paymnetKey = json['paymnet_key'];
    clientSecret = json['client_secret'];
    clientIdentifier = json['client_identifier'];
    if (json['sidebar_menu'] != null) {
      sidebarMenu = <SidebarMenu>[];
      json['sidebar_menu'].forEach((v) {
        sidebarMenu!.add(new SidebarMenu.fromJson(v));
      });
    }
    if (json['maintenance_screen'] != null) {
      maintenanceScreen = <MaintenanceScreen>[];
      json['maintenance_screen'].forEach((v) {
        maintenanceScreen!.add(new MaintenanceScreen.fromJson(v));
      });
    }
    // if (json['popup_screen'] != null) {
    //   popupScreen = <Null>[];
    //   json['popup_screen'].forEach((v) {
    //     popupScreen!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['app_screen'] != null) {
    //   appScreen = <Null>[];
    //   json['app_screen'].forEach((v) {
    //     // appScreen!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['per_page'] = this.perPage;
    data['multi_filter'] = this.multiFilter;
    data['multi_filter_join_string'] = this.multiFilterJoinString;
    data['email1'] = this.email1;
    data['email2'] = this.email2;
    data['mobile1'] = this.mobile1;
    data['mobile2'] = this.mobile2;
    data['whatsapp_number'] = this.whatsappNumber;
    data['address'] = this.address;
    data['referral_user'] = this.referralUser;
    data['paymnet_mod'] = this.paymnetMod;
    data['paymnet_key'] = this.paymnetKey;
    data['client_secret'] = this.clientSecret;
    data['client_identifier'] = this.clientIdentifier;
    if (this.sidebarMenu != null) {
      data['sidebar_menu'] = this.sidebarMenu!.map((v) => v.toJson()).toList();
    }
    if (this.maintenanceScreen != null) {
      data['maintenance_screen'] =
          this.maintenanceScreen!.map((v) => v.toJson()).toList();
    }
    // if (this.popupScreen != null) {
    //   data['popup_screen'] = this.popupScreen!.map((v) => v.toJson()).toList();
    // }
    // if (this.appScreen != null) {
    //   data['app_screen'] = this.appScreen!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class SidebarMenu {
  String? show;
  String? showOn;
  String? title;
  String? img;
  String? link;

  SidebarMenu({this.show, this.showOn, this.title, this.img, this.link});

  SidebarMenu.fromJson(Map<String, dynamic> json) {
    show = json['show'];
    showOn = json['show_on'];
    title = json['title'];
    img = json['img'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show'] = this.show;
    data['show_on'] = this.showOn;
    data['title'] = this.title;
    data['img'] = this.img;
    data['link'] = this.link;
    return data;
  }
}

class MaintenanceScreen {
  String? show;
  String? img;
  String? message;

  MaintenanceScreen({this.show, this.img, this.message});

  MaintenanceScreen.fromJson(Map<String, dynamic> json) {
    show = json['show'];
    img = json['img'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show'] = this.show;
    data['img'] = this.img;
    data['message'] = this.message;
    return data;
  }
}
