class OrderListRepsonseModel {
    OrderListRepsonseModel({
        this.status,
        this.msg,
        this.data,
        this.recordsTotal,
        this.recordsFiltered
    });

    int? status;
    int? recordsTotal;
    int? recordsFiltered;
    String? msg;
    List<OrderListDatum>? data;


    factory OrderListRepsonseModel.fromJson(Map<String, dynamic> json)=>
        OrderListRepsonseModel(
        status: json["status"] == null ? null : json["status"],
        recordsTotal: json["recordsTotal"] == null ? 0 : json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"] ==
        null ? 0 : json["recordsFiltered"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
        ? null
            : List<OrderListDatum>.from(
        json["data"].map((x) => OrderListDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "recordsTotal": recordsTotal,
        "recordsFiltered":recordsFiltered,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class OrderListDatum {
    OrderListDatum({
        this.createdAt,
        this.orderTotal,
        this.deliveryMode,
        this.username,
        this.resId,
        this.resName,
        this.orderid,
        this.status,
        this.detail,
    });

    DateTime? createdAt;
    double? orderTotal;
    int? deliveryMode;
    String? username;
    int? resId;
    String? resName;
    int? orderid;
    String? status;
    Detail? detail;

    factory OrderListDatum.fromJson(Map<String, dynamic> json) => OrderListDatum(
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        orderTotal: json["order_total"] == null ? null : json["order_total"].toDouble(),
        deliveryMode: json["delivery_mode"] == null ? null : json["delivery_mode"],
        username: json["username"] == null ? null : json["username"],
        resId: json["res_id"] == null ? null : json["res_id"],
        resName: json["res_name"] == null ? null : json["res_name"],
        orderid: json["orderid"] == null ? null : json["orderid"],
        status: json["status"] == null ? null : json["status"],
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"])
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt == null ? null : "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "order_total": orderTotal == null ? null : orderTotal,
        "delivery_mode": deliveryMode == null ? null : deliveryMode,
        "username": username == null ? null : username,
        "res_id": resId == null ? null : resId,
        "res_name": resName == null ? null : resName,
        "orderid": orderid == null ? null : orderid,
        "status": status == null ? null : status,
        "detail": detail == null ? null : detail!.toJson()
    };
}

enum ResName { ASDF_A }

final resNameValues = EnumValues({
    "asdf a": ResName.ASDF_A
});


class TypesFilters {
    TypesFilters({
        this.received,
        this.preparing,
        this.ready,
        this.pickup,
        this.delivered,
        this.cancelled,
    });

    double? received;
    double? preparing;
    int? ready;
    int? pickup;
    double? delivered;
    int? cancelled;

    factory TypesFilters.fromJson(Map<String, dynamic> json) => TypesFilters(
        received: json["received"] == null ? null : json["received"].toDouble(),
        preparing: json["preparing"] == null ? null : json["preparing"].toDouble(),
        ready: json["ready"] == null ? null : json["ready"],
        pickup: json["pickup"] == null ? null : json["pickup"],
        delivered: json["delivered"] == null ? null : json["delivered"].toDouble(),
        cancelled: json["cancelled"] == null ? null : json["cancelled"],
    );

    Map<String, dynamic> toJson() => {
        "received": received == null ? null : received,
        "preparing": preparing == null ? null : preparing,
        "ready": ready == null ? null : ready,
        "pickup": pickup == null ? null : pickup,
        "delivered": delivered == null ? null : delivered,
        "cancelled": cancelled == null ? null : cancelled,
    };
}

class EnumValues<T> {
    late Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        return reverseMap;
    }
}

class Detail {
    int? id;
    int? userId;
    int? resId;
    int? cartId;
    String? orderHash;
    String? cart;
    double? foodTax;
    double? drinkTax;
    double? subtotal;
    double? tax;
    double? deliveryCharge;
    double? total;
    int? discount;
    double? withoutDiscount;
    String? delieverydate;
    String? timeSlots;
    int? orderCode;
    int? codeVerified;
    int? deliveryMode;
    String? deliveredBy;
    int? paymentMode;
    String? status;
    int? paymentStatus;
    String? paymentData;
    String? orderBy;
    String? cookingTime;
    String? orderissue;
    String? cancelledBy;
    String? createdDate;
    int? tbNum;
    int? orderId;
    String? firstname;
    String? lastname;
    String? email;
    String? phone;
    String? address;
    String? city;
    int? pincode;
    String? houseno;
    int? lat;
    int? lng;
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

    Detail(
        {this.id,
            this.userId,
            this.resId,
            this.cartId,
            this.orderHash,
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
            this.cancelledBy,
            this.createdDate,
            this.tbNum,
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
            this.rContact});

    Detail.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        userId = json['user_id'];
        resId = json['res_id'];
        cartId = json['cart_id'];
        orderHash = json['order_hash'];
        cart = json['cart'];
        // foodTax = json['food_tax'];
        // drinkTax = json['drink_tax'];
        // subtotal = json['subtotal'];
        // tax = json['tax'];
        // deliveryCharge = json['delivery_charge'];
        // total = json['total'];
        // discount = json['discount'];
        // withoutDiscount = json['without_discount'];
        // delieverydate = json['delieverydate'];
        // timeSlots = json['timeSlots'];
        // orderCode = json['order_code'];
        // codeVerified = json['code_verified'];
        // deliveryMode = json['delivery_mode'];
        // deliveredBy = json['delivered_by'];
        // paymentMode = json['payment_mode'];
        // status = json['status'];
        // paymentStatus = json['payment_status'];
        // paymentData = json['payment_data'];
        // orderBy = json['order_by'];
        // cookingTime = json['cooking_time'];
        // orderissue = json['orderissue'];
        // cancelledBy = json['cancelled_by'];
        // createdDate = json['created_date'];
        // tbNum = json['tb_num'];
        // orderId = json['order_id'];
        // firstname = json['firstname'];
        // lastname = json['lastname'];
        // email = json['email'];
        // phone = json['phone'];
        // address = json['address'];
        // city = json['city'];
        // pincode = json['pincode'];
        // houseno = json['houseno'];
        // lat = json['lat'];
        // lng = json['lng'];
        // formattedAddress = json['formattedAddress'];
        // username = json['username'];
        // useremail = json['useremail'];
        // profilepic = json['profilepic'];
        // userphone = json['userphone'];
        // rName = json['r_name'];
        // rEmail = json['r_email'];
        // rAddress = json['r_address'];
        // rCity = json['r_city'];
        // rContact = json['r_contact'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['user_id'] = this.userId;
        data['res_id'] = this.resId;
        data['cart_id'] = this.cartId;
        data['order_hash'] = this.orderHash;
        data['cart'] = this.cart;
        // data['food_tax'] = this.foodTax;
        // data['drink_tax'] = this.drinkTax;
        // data['subtotal'] = this.subtotal;
        // data['tax'] = this.tax;
        // data['delivery_charge'] = this.deliveryCharge;
        // data['total'] = this.total;
        // data['discount'] = this.discount;
        // data['without_discount'] = this.withoutDiscount;
        // data['delieverydate'] = this.delieverydate;
        // data['timeSlots'] = this.timeSlots;
        // data['order_code'] = this.orderCode;
        // data['code_verified'] = this.codeVerified;
        // data['delivery_mode'] = this.deliveryMode;
        // data['delivered_by'] = this.deliveredBy;
        // data['payment_mode'] = this.paymentMode;
        // data['status'] = this.status;
        // data['payment_status'] = this.paymentStatus;
        // data['payment_data'] = this.paymentData;
        // data['order_by'] = this.orderBy;
        // data['cooking_time'] = this.cookingTime;
        // data['orderissue'] = this.orderissue;
        // data['cancelled_by'] = this.cancelledBy;
        // data['created_date'] = this.createdDate;
        // data['tb_num'] = this.tbNum;
        // data['order_id'] = this.orderId;
        // data['firstname'] = this.firstname;
        // data['lastname'] = this.lastname;
        // data['email'] = this.email;
        // data['phone'] = this.phone;
        // data['address'] = this.address;
        // data['city'] = this.city;
        // data['pincode'] = this.pincode;
        // data['houseno'] = this.houseno;
        // data['lat'] = this.lat;
        // data['lng'] = this.lng;
        // data['formattedAddress'] = this.formattedAddress;
        // data['username'] = this.username;
        // data['useremail'] = this.useremail;
        // data['profilepic'] = this.profilepic;
        // data['userphone'] = this.userphone;
        // data['r_name'] = this.rName;
        // data['r_email'] = this.rEmail;
        // data['r_address'] = this.rAddress;
        // data['r_city'] = this.rCity;
        // data['r_contact'] = this.rContact;
        return data;
    }
}
