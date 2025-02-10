class OrderDetailRepsonseModel {
  OrderDetailRepsonseModel({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  OrderDetailData? data;

  factory OrderDetailRepsonseModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailRepsonseModel(
        status: json["status"] == null ? null : json["status"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : OrderDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data?.toJson(),
      };
}

class OrderDetailData {
  OrderDetailData({
    this.id,
    this.userId,
    this.resId,
    this.cartId,
    this.cart,
    this.foodTax,
    this.drinkTax,
    this.subtotal,
    this.tax,
    this.deliveryCharge,
    this.total,
    this.discount,
    this.withoutDiscount,
    this.delieverydate,
    this.timeSlots,
    this.orderCode,
    this.codeVerified,
    this.deliveryMode,
    this.deliveredBy,
    this.paymentMode,
    this.status,
    this.paymentStatus,
    this.paymentData,
    this.orderBy,
    this.cookingTime,
    this.orderissue,
    this.createdDate,
    this.orderId,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.pincode,
    this.houseno,
    this.lat,
    this.lng,
    this.formattedAddress,
    this.username,
    this.useremail,
    this.profilepic,
    this.userphone,
    this.rName,
    this.rEmail,
    this.rAddress,
    this.rCity,
    this.rContact,
  });

  int? id;
  int? userId;
  int? resId;
  int? cartId;
  String? cart;
  dynamic foodTax;
  dynamic drinkTax;
  dynamic subtotal;
  dynamic tax;
  dynamic deliveryCharge;
  dynamic total;
  dynamic discount;
  dynamic withoutDiscount;
  dynamic delieverydate;
  dynamic timeSlots;
  int? orderCode;
  int? codeVerified;
  int? deliveryMode;
  dynamic deliveredBy;
  int? paymentMode;
  String? status;
  int? paymentStatus;
  String? paymentData;
  String? orderBy;
  dynamic cookingTime;
  String? orderissue;
  DateTime? createdDate;
  int? orderId;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? address;
  String? city;
  dynamic pincode;
  String?houseno;
  double? lat;
  double? lng;
  String? formattedAddress;
  String? username;
  String? useremail;
  String? profilepic;
  String? userphone;
  String? rName;
  String? rEmail;
  String? rAddress;
  String? rCity;
  String? rContact;

  factory OrderDetailData.fromJson(Map<String, dynamic> json) =>
      OrderDetailData(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        resId: json["res_id"] == null ? null : json["res_id"],
        cartId: json["cart_id"] == null ? null : json["cart_id"],
        cart: json["cart"] == null ? null : json["cart"],
        foodTax: json["food_tax"] == null ? null : json["food_tax"],
        drinkTax: json["drink_tax"] == null ? null : json["drink_tax"],
        subtotal: json["subtotal"] == null ? null : json["subtotal"],
        tax: json["tax"] == null ? null : json["tax"],
        deliveryCharge:
            json["delivery_charge"] == null ? null : json["delivery_charge"],
        total: json["total"] == null ? null : json["total"].toDouble(),
        discount: json["discount"] == null ? null : json["discount"].toDouble(),
        withoutDiscount:
            json["without_discount"] == null ? null : json["without_discount"],
        delieverydate: json["delieverydate"],
        timeSlots: json["timeSlots"],
        orderCode: json["order_code"] == null ? null : json["order_code"],
        codeVerified:
            json["code_verified"] == null ? null : json["code_verified"],
        deliveryMode:
            json["delivery_mode"] == null ? null : json["delivery_mode"],
        deliveredBy: json["delivered_by"],
        paymentMode: json["payment_mode"] == null ? null : json["payment_mode"],
        status: json["status"] == null ? null : json["status"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
        paymentData: json["payment_data"] == null ? null : json["payment_data"],
        orderBy: json["order_by"] == null ? null : json["order_by"],
        cookingTime: json["cooking_time"],
        orderissue: json["orderissue"] == null ? null : json["orderissue"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        orderId: json["order_id"] == null ? null : json["order_id"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        pincode: json["pincode"],
        houseno: json["houseno"] == null ? null : json["houseno"],
        lat: json["lat"] == null ? null : double.parse(json["lat"]),
        lng: json["lng"] == null ? null : double.parse(json["lng"]),
        formattedAddress:
            json["formattedAddress"] == null ? null : json["formattedAddress"],
        username: json["username"] == null ? null : json["username"],
        useremail: json["useremail"] == null ? null : json["useremail"],
        profilepic: json["profilepic"] == null ? null : json["profilepic"],
        userphone: json["userphone"] == null ? null : json["userphone"],
        rName: json["r_name"] == null ? null : json["r_name"],
        rEmail: json["r_email"] == null ? null : json["r_email"],
        rAddress: json["r_address"] == null ? null : json["r_address"],
        rCity: json["r_city"] == null ? null : json["r_city"],
        rContact: json["r_contact"] == null ? null : json["r_contact"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "res_id": resId == null ? null : resId,
        "cart_id": cartId == null ? null : cartId,
        "cart": cart == null ? null : cart,
        "food_tax": foodTax == null ? null : foodTax,
        "drink_tax": drinkTax == null ? null : drinkTax,
        "subtotal": subtotal == null ? null : subtotal,
        "tax": tax == null ? null : tax,
        "delivery_charge": deliveryCharge == null ? null : deliveryCharge,
        "total": total == null ? null : total,
        "discount": discount == null ? null : discount,
        "without_discount": withoutDiscount == null ? null : withoutDiscount,
        "delieverydate": delieverydate,
        "timeSlots": timeSlots,
        "order_code": orderCode == null ? null : orderCode,
        "code_verified": codeVerified == null ? null : codeVerified,
        "delivery_mode": deliveryMode == null ? null : deliveryMode,
        "delivered_by": deliveredBy,
        "payment_mode": paymentMode == null ? null : paymentMode,
        "status": status == null ? null : status,
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "payment_data": paymentData == null ? null : paymentData,
        "order_by": orderBy == null ? null : orderBy,
        "cooking_time": cookingTime,
        "orderissue": orderissue == null ? null : orderissue,
        "created_date":
            createdDate == null ? null : createdDate?.toIso8601String(),
        "order_id": orderId == null ? null : orderId,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "pincode": pincode,
        "houseno": houseno == null ? null : houseno,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "formattedAddress": formattedAddress == null ? null : formattedAddress,
        "username": username == null ? null : username,
        "useremail": useremail == null ? null : useremail,
        "profilepic": profilepic == null ? null : profilepic,
        "userphone": userphone == null ? null : userphone,
        "r_name": rName == null ? null : rName,
        "r_email": rEmail == null ? null : rEmail,
        "r_address": rAddress == null ? null : rAddress,
        "r_city": rCity == null ? null : rCity,
        "r_contact": rContact == null ? null : rContact,
      };
}

class Cart {
  int? itemId;
  String? itemName;
  double? itemPrice;
  List<CartCustomization>? customization;
  int? quantity;
  String? taxtype;
  String? note;
  double? taxvalue;

  Cart(
      {this.itemId,
      this.itemName,
      this.itemPrice,
      this.customization,
      this.quantity,
      this.taxtype,
      this.taxvalue,
      this.note});

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        itemId: json["itemId"] == null ? null : json["itemId"],
        itemName: json["itemName"] == null ? null : json["itemName"],
        itemPrice:
            json["itemPrice"] == null ? null : json["itemPrice"].toDouble(),
        customization: json["customization"] == null
            ? null
            : List<CartCustomization>.from(json["customization"]
                .map((x) => CartCustomization.fromJson(x))),
        quantity: json["quantity"] == null ? null : json["quantity"],
        taxtype: json["taxtype"] == null ? null : json["taxtype"],
        note: json["note"] == null ? null : json["note"],
        taxvalue: json["taxvalue"] == null ? null : json["taxvalue"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId == null ? null : itemId,
        "itemName": itemName == null ? null : itemName,
        "itemPrice": itemPrice == null ? null : itemPrice,
        "customization": customization == null
            ? null
            : List<dynamic>.from(customization!.map((x) => x.toJson())),
        "quantity": quantity == null ? null : quantity,
        "taxtype": taxtype == null ? null : taxtype,
        "taxvalue": taxvalue == null ? null : taxvalue,
        "note": note == null ? null : note,
      };
}

class CartCustomization {
  int? optionId;
  String? optionName;
  dynamic optionPrice;

  CartCustomization({
    this.optionId,
    this.optionName,
    this.optionPrice,
  });

  factory CartCustomization.fromJson(Map<String, dynamic> json) =>
      CartCustomization(
        optionId: json["option_id"] == null ? null : json["option_id"],
        optionName: json["option_name"] == null ? null : json["option_name"],
        optionPrice: json["option_price"] == null ? null : json["option_price"],
      );

  Map<String, dynamic> toJson() => {
        "option_id": optionId == null ? null : optionId,
        "option_name": optionName == null ? null : optionName,
        "option_price": optionPrice == null ? null : optionPrice,
      };
}
