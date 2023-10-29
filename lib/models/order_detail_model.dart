class OrderDetailModel {
  OrderDetailModel({
    required this.status,
    required this.message,
    required this.count,
    required this.response,
  });
  late final int status;
  late final String message;
  late final int count;
  late final List<Order> response;

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    response =
        List.from(json['response']).map((e) => Order.fromJson(e)).toList();
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

class Order {
  Order({
    required this.orderNo,
    required this.paymentMethod,
    required this.paymentSource,
    required this.orderDateTime,
    required this.orderTotalAmount,
    required this.collectAmount,
    required this.orderCompleted,
    required this.orderStatus,
    required this.bgColor,
    required this.color,
    required this.item,
    required this.userMapShow,
    required this.userAddressShow,
    required this.orderUserAddress,
    required this.vendorMapShow,
    required this.vendorAddressShow,
    required this.orderVendorAddress,
    required this.showTrackDataShow,
    required this.showTrackDataTitle,
    required this.showTrackData,
    required this.showTrackDataHtml,
    required this.showAllBtn,
    required this.showOrderPickupBtn,
    required this.showOrderInTransitBtn,
    required this.showOutOfDeliveryBtn,
    required this.showDeliveredBtn,
    required this.orderDetails,
  });
  late final String orderNo;
  late final String paymentMethod;
  late final String paymentSource;
  late final String orderDateTime;
  late final String orderTotalAmount;
  late final String collectAmount;
  late final String orderCompleted;
  late final String orderStatus;
  late final String bgColor;
  late final String color;
  late final String item;
  late final String userMapShow;
  late final String userAddressShow;
  late final List<OrderUserAddress> orderUserAddress;
  late final String vendorMapShow;
  late final String vendorAddressShow;
  late final List<OrderVendorAddress> orderVendorAddress;
  late final String showTrackDataShow;
  late final String showTrackDataTitle;
  late final List<ShowTrackData> showTrackData;
  late final String showTrackDataHtml;
  late final String showAllBtn;
  late final String showOrderPickupBtn;
  late final String showOrderInTransitBtn;
  late final String showOutOfDeliveryBtn;
  late final String showDeliveredBtn;
  late final List<OrderDetails> orderDetails;

  Order.fromJson(Map<String, dynamic> json) {
    orderNo = json['order_no'];
    paymentMethod = json['payment_method'];
    paymentSource = json['payment_source'];
    orderDateTime = json['order_date_time'];
    orderTotalAmount = json['order_total_amount'];
    collectAmount = json['collect_amount'];
    orderCompleted = json['order_completed'];
    orderStatus = json['order_status'];
    bgColor = json['bg_color'];
    color = json['color'];
    item = json['item'];
    userMapShow = json['user_map_show'];
    userAddressShow = json['user_address_show'];
    orderUserAddress = List.from(json['order_user_address'])
        .map((e) => OrderUserAddress.fromJson(e))
        .toList();
    vendorMapShow = json['vendor_map_show'];
    vendorAddressShow = json['vendor_address_show'];
    orderVendorAddress = List.from(json['order_vendor_address'])
        .map((e) => OrderVendorAddress.fromJson(e))
        .toList();
    showTrackDataShow = json['show_track_data_show'];
    showTrackDataTitle = json['show_track_data_title'];
    showTrackData = List.from(json['show_track_data'])
        .map((e) => ShowTrackData.fromJson(e))
        .toList();
    showTrackDataHtml = json['show_track_data_html'];
    showAllBtn = json['show_all_btn'];
    showOrderPickupBtn = json['show_order_pickup_btn'];
    showOrderInTransitBtn = json['show_order_in_transit_btn'];
    showOutOfDeliveryBtn = json['show_out_of_delivery_btn'];
    showDeliveredBtn = json['show_delivered_btn'];
    orderDetails = List.from(json['order_details'])
        .map((e) => OrderDetails.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_no'] = orderNo;
    _data['payment_method'] = paymentMethod;
    _data['payment_source'] = paymentSource;
    _data['order_date_time'] = orderDateTime;
    _data['order_total_amount'] = orderTotalAmount;
    _data['collect_amount'] = collectAmount;
    _data['order_completed'] = orderCompleted;
    _data['order_status'] = orderStatus;
    _data['bg_color'] = bgColor;
    _data['color'] = color;
    _data['item'] = item;
    _data['user_map_show'] = userMapShow;
    _data['user_address_show'] = userAddressShow;
    _data['order_user_address'] =
        orderUserAddress.map((e) => e.toJson()).toList();
    _data['vendor_map_show'] = vendorMapShow;
    _data['vendor_address_show'] = vendorAddressShow;
    _data['order_vendor_address'] =
        orderVendorAddress.map((e) => e.toJson()).toList();
    _data['show_track_data_show'] = showTrackDataShow;
    _data['show_track_data_title'] = showTrackDataTitle;
    _data['show_track_data'] = showTrackData.map((e) => e.toJson()).toList();
    _data['show_track_data_html'] = showTrackDataHtml;
    _data['show_all_btn'] = showAllBtn;
    _data['show_order_pickup_btn'] = showOrderPickupBtn;
    _data['show_order_in_transit_btn'] = showOrderInTransitBtn;
    _data['show_out_of_delivery_btn'] = showOutOfDeliveryBtn;
    _data['show_delivered_btn'] = showDeliveredBtn;
    _data['order_details'] = orderDetails.map((e) => e.toJson()).toList();
    return _data;
  }
}

class OrderUserAddress {
  OrderUserAddress({
    required this.userName,
    required this.email,
    required this.mobile,
    required this.address1,
    required this.address2,
    required this.countries,
    required this.state,
    required this.city,
    required this.pincode,
    required this.latitudes,
    required this.longitude,
  });
  late final String userName;
  late final String email;
  late final String mobile;
  late final String address1;
  late final String address2;
  late final String countries;
  late final String state;
  late final String city;
  late final String pincode;
  late final String latitudes;
  late final String longitude;

  OrderUserAddress.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    email = json['email'];
    mobile = json['mobile'];
    address1 = json['address1'];
    address2 = json['address2'];
    countries = json['countries'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    latitudes = json['latitudes'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_name'] = userName;
    _data['email'] = email;
    _data['mobile'] = mobile;
    _data['address1'] = address1;
    _data['address2'] = address2;
    _data['countries'] = countries;
    _data['state'] = state;
    _data['city'] = city;
    _data['pincode'] = pincode;
    _data['latitudes'] = latitudes;
    _data['longitude'] = longitude;
    return _data;
  }
}

class OrderVendorAddress {
  OrderVendorAddress({
    required this.vendorName,
    required this.mobile,
    required this.address,
    required this.countries,
    required this.state,
    required this.city,
    required this.pincode,
    required this.latitudes,
    required this.longitude,
    required this.companyName,
    required this.companyPhoneNo,
  });
  late final String vendorName;
  late final String mobile;
  late final String address;
  late final String countries;
  late final String state;
  late final String city;
  late final String pincode;
  late final String latitudes;
  late final String longitude;
  late final String companyName;
  late final String companyPhoneNo;

  OrderVendorAddress.fromJson(Map<String, dynamic> json) {
    vendorName = json['vendor_name'];
    mobile = json['mobile'];
    address = json['address'];
    countries = json['countries'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    latitudes = json['latitudes'];
    longitude = json['longitude'];
    companyName = json['company_name'];
    companyPhoneNo = json['company_phone_no'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['vendor_name'] = vendorName;
    _data['mobile'] = mobile;
    _data['address'] = address;
    _data['countries'] = countries;
    _data['state'] = state;
    _data['city'] = city;
    _data['pincode'] = pincode;
    _data['latitudes'] = latitudes;
    _data['longitude'] = longitude;
    _data['company_name'] = companyName;
    _data['company_phone_no'] = companyPhoneNo;
    return _data;
  }
}

class ShowTrackData {
  ShowTrackData({
    required this.title,
    required this.body,
    required this.dateTime,
    required this.isActive,
    required this.color,
  });
  late final String title;
  late final String body;
  late final String dateTime;
  late final String isActive;
  late final String color;

  ShowTrackData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    dateTime = json['date_time'];
    isActive = json['is_active'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['body'] = body;
    _data['date_time'] = dateTime;
    _data['is_active'] = isActive;
    _data['color'] = color;
    return _data;
  }
}

class OrderDetails {
  OrderDetails({
    required this.productId,
    required this.productSlug,
    required this.productName,
    required this.productImg,
    required this.productQty,
    required this.productPrice,
    required this.productTotalPrice,
  });
  late final String productId;
  late final String productSlug;
  late final String productName;
  late final String productImg;
  late final String productQty;
  late final String productPrice;
  late final String productTotalPrice;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productSlug = json['product_slug'];
    productName = json['product_name'];
    productImg = json['product_img'];
    productQty = json['product_qty'];
    productPrice = json['product_price'];
    productTotalPrice = json['product_total_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['product_slug'] = productSlug;
    _data['product_name'] = productName;
    _data['product_img'] = productImg;
    _data['product_qty'] = productQty;
    _data['product_price'] = productPrice;
    _data['product_total_price'] = productTotalPrice;
    return _data;
  }
}
