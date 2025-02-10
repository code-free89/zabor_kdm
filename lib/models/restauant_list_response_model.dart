class RestaurantListRepsonseModel {
  RestaurantListRepsonseModel({
    this.status,
    this.msg,
    this.data,
    this.recordsTotal,
    this.recordsFiltered,
  });

  int? status;
  String? msg;
  List<RestaurantDatum>? data;
  int? recordsTotal;
  int? recordsFiltered;

  factory RestaurantListRepsonseModel.fromJson(Map<String, dynamic> json) =>
      RestaurantListRepsonseModel(
        status: json["status"] == null ? null : json["status"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : List<RestaurantDatum>.from(
                json["data"].map((x) => RestaurantDatum.fromJson(x))),
        recordsTotal:
            json["recordsTotal"] == null ? null : json["recordsTotal"],
        recordsFiltered:
            json["recordsFiltered"] == null ? null : json["recordsFiltered"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "recordsTotal": recordsTotal == null ? null : recordsTotal,
        "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
      };
}

class RestaurantDatum {
  RestaurantDatum({
    this.id,
    this.name,
    this.email,
    this.description,
    this.descriptionEs,
    this.status,
    this.category,
    this.subcategory,
    this.createdBy,
    this.restaurantpic,
    this.city,
    this.address,
    this.contact,
    this.website,
    this.latitude,
    this.longitude,
    this.avgCost,
    this.claimed,
    this.minOrderValue,
    this.maxOrderValue,
    this.cod,
    this.stripeAcc,
    this.canEditMenu,
    this.canEditReservation,
    this.canEditOrder,
    this.canEditDiscount,
    this.createdAt,
  });

  int? id;
  String? name;
  String? email;
  String? description;
  String? descriptionEs;
  int? status;
  int? category;
  String? subcategory;
  int? createdBy;
  String? restaurantpic;
  String? city;
  String? address;
  String? contact;
  String? website;
  double? latitude;
  double? longitude;
  int? avgCost;
  int? claimed;
  dynamic minOrderValue;
  dynamic maxOrderValue;
  int? cod;
  dynamic stripeAcc;
  int? canEditMenu;
  int? canEditReservation;
  int? canEditOrder;
  int? canEditDiscount;
  DateTime? createdAt;

  factory RestaurantDatum.fromJson(Map<String, dynamic> json) =>
      RestaurantDatum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        description: json["description"] == null ? null : json["description"],
        descriptionEs:
            json["description_es"] == null ? null : json["description_es"],
        status: json["status"] == null ? null : json["status"],
        category: json["category"] == null ? null : json["category"],
        subcategory: json["subcategory"] == null ? null : json["subcategory"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        restaurantpic:
            json["restaurantpic"] == null ? null : json["restaurantpic"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        contact: json["contact"] == null ? null : json["contact"],
        website: json["website"] == null ? null : json["website"],
        latitude: json["latitude"] == null
            ? null
            : double.parse(json["latitude"] as String),
        longitude:
            json["longitude"] == null ? null : double.parse(json["longitude"]),
        avgCost: json["avg_cost"] == null ? null : json["avg_cost"],
        claimed: json["claimed"] == null ? null : json["claimed"],
        minOrderValue: json["min_order_value"],
        maxOrderValue: json["max_order_value"],
        cod: json["cod"] == null ? null : json["cod"],
        stripeAcc: json["stripe_acc"],
        canEditMenu:
            json["can_edit_menu"] == null ? null : json["can_edit_menu"],
        canEditReservation: json["can_edit_reservation"] == null
            ? null
            : json["can_edit_reservation"],
        canEditOrder:
            json["can_edit_order"] == null ? null : json["can_edit_order"],
        canEditDiscount: json["can_edit_discount"] == null
            ? null
            : json["can_edit_discount"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "description": description == null ? null : description,
        "description_es": descriptionEs == null ? null : descriptionEs,
        "status": status == null ? null : status,
        "category": category == null ? null : category,
        "subcategory": subcategory == null ? null : subcategory,
        "created_by": createdBy == null ? null : createdBy,
        "restaurantpic": restaurantpic == null ? null : restaurantpic,
        "city": city == null ? null : city,
        "address": address == null ? null : address,
        "contact": contact == null ? null : contact,
        "website": website == null ? null : website,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "avg_cost": avgCost == null ? null : avgCost,
        "claimed": claimed == null ? null : claimed,
        "min_order_value": minOrderValue,
        "max_order_value": maxOrderValue,
        "cod": cod == null ? null : cod,
        "stripe_acc": stripeAcc,
        "can_edit_menu": canEditMenu == null ? null : canEditMenu,
        "can_edit_reservation":
            canEditReservation == null ? null : canEditReservation,
        "can_edit_order": canEditOrder == null ? null : canEditOrder,
        "can_edit_discount": canEditDiscount == null ? null : canEditDiscount,
        "created_at": createdAt == null
            ? null
            : "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
      };
}
