import 'package:kds/models/item_group_response_model.dart';

class ItemListRepsonseModel {
  ItemListRepsonseModel({
    this.status,
    this.msg,
    this.group,
    this.menuitems,
    this.cus,
  });

  int? status;
  String? msg;
  GroupDatum? group;
  List<Menuitem>? menuitems;
  List<Cus>? cus;

  factory ItemListRepsonseModel.fromJson(Map<String, dynamic> json) =>
      ItemListRepsonseModel(
        status: json["status"] == null ? null : json["status"],
        msg: json["msg"] == null ? null : json["msg"],
        group:
            json["group"] == null ? null : GroupDatum.fromJson(json["group"]),
        menuitems: json["menuitems"] == null
            ? null
            : List<Menuitem>.from(
                json["menuitems"].map((x) => Menuitem.fromJson(x))),
        cus: json["cus"] == null
            ? null
            : List<Cus>.from(json["cus"].map((x) => Cus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "group": group == null ? null : group?.toJson(),
        "menuitems": menuitems == null
            ? null
            : List<dynamic>.from(menuitems!.map((x) => x.toJson())),
        "cus": cus == null
            ? null
            : List<dynamic>.from(cus!.map((x) => x.toJson())),
      };
}

class Cus {
  Cus({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Cus.fromJson(Map<String, dynamic> json) => Cus(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class Group {
  Group({
    this.id,
    this.groupName,
  });

  int? id;
  String? groupName;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"] == null ? null : json["id"],
        groupName: json["group_name"] == null ? null : json["group_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "group_name": groupName == null ? null : groupName,
      };
}

class Menuitem {
  Menuitem({
    this.id,
    this.groupId,
    this.isShow,
    this.isNote,
    this.itemName,
    this.itemDes,
    this.itemPrice,
    this.itemQuantity,
    this.itemPic,
    this.customizations,
    this.taxtype,
    this.upcNo,
    this.updatedAt,
    this.isCity,
    this.isFood,
    this.isState,
    this.printer_2,
    this.printer_3,
    this.printer_4,
    this.printer_5,
    this.printer_6,
    this.printer_7,
    this.discount_type,
    this.discount_amount,
  });

  int? id;
  int? groupId;
  int? isShow;
  int? isNote;
  String? itemName;
  String? itemDes;
  dynamic itemPrice;
  dynamic itemQuantity;
  String? itemPic;
  String? customizations;
  String? taxtype;
  String? upcNo;
  DateTime? updatedAt;
  int? isCity;
  int? isFood;
  int? isState;
  int? printer_2;
  int? printer_3;
  int? printer_4;
  int? printer_5;
  int? printer_6;
  int? printer_7;
  String? discount_type;
  int? discount_amount;

  factory Menuitem.fromJson(Map<String, dynamic> json) => Menuitem(
        id: json["id"],
        groupId: json["group_id"],
        isShow: json["is_show"] is bool
            ? json["is_show"]
                ? 1
                : 0
            : json["is_show"],
        isNote: json["is_note"] is bool
            ? json["is_note"]
                ? 1
                : 0
            : json["is_note"],
        itemName: json["item_name"],
        itemDes: json["item_des"],
        itemPrice: json["item_price"] == null ? 0 : json["item_price"],
        itemQuantity: json["item_quantity"] == null ? 0 : json["item_quantity"],
        itemPic: json["item_pic"],
        customizations: json["customizations"],
        taxtype: json["taxtype"],
        upcNo: json["upc_no"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isCity: json["is_city"] is bool
            ? json["is_city"]
                ? 1
                : 0
            : json["is_city"],
        isFood: json["is_food"] is bool
            ? json["is_food"]
                ? 1
                : 0
            : json["is_food"],
        isState: json["is_state"] is bool
            ? json["is_state"]
                ? 1
                : 0
            : json["is_state"],
        printer_2: json["printer_2"] is bool
            ? json["printer_2"]
                ? 1
                : 0
            : json["printer_2"],
        printer_3: json["printer_3"] is bool
            ? json["printer_3"]
                ? 1
                : 0
            : json["printer_3"],
        printer_4: json["printer_4"] is bool
            ? json["printer_4"]
                ? 1
                : 0
            : json["printer_4"],
        printer_5: json["printer_5"] is bool
            ? json["printer_5"]
                ? 1
                : 0
            : json["printer_5"],
        printer_6: json["printer_6"] is bool
            ? json["printer_6"]
                ? 1
                : 0
            : json["printer_6"],
        printer_7: json["printer_7"] is bool
            ? json["printer_7"]
                ? 1
                : 0
            : json["printer_7"],
        discount_type: json["discount_type"],
        discount_amount: json["discount_amount"] == null
            ? 0
            : json["discount_amount"] is String
                ? int.parse(json["discount_amount"])
                : json["discount_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "is_show": isShow,
        "is_note": isNote,
        "item_name": itemName,
        "item_des": itemDes,
        "item_price": itemPrice,
        "item_quantity": itemQuantity,
        "item_pic": itemPic,
        "customizations": customizations,
        "taxtype": taxtype,
        "upc_no": upcNo,
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "is_city": isCity,
        "is_food": isFood,
        "is_state": isState,
        "printer_2": printer_2,
        "printer_3": printer_3,
        "printer_4": printer_4,
        "printer_5": printer_5,
        "printer_6": printer_6,
        "printer_7": printer_7,
        "discount_type": discount_type,
        "discount_amount": discount_amount,
      };

  Map<String, dynamic> toNewItemJson() => {
        "item_id": id,
        "name": itemName,
        "price": itemPrice,
        "itempic": itemPic,
        "pic": itemPic,
        "cus": customizations,
        "taxtype": taxtype,
        "quantity": itemQuantity,
        "upc_no": upcNo,
        "item_des": itemDes,
        "is_show": isShow,
        "is_city": isCity,
        "is_food": isFood,
        "is_state": isState,
        "is_note": isNote == null ? 0 : isNote,
        "printer_2": printer_2,
        "printer_3": printer_3,
        "printer_4": printer_4,
        "printer_5": printer_5,
        "printer_6": printer_6,
        "printer_7": printer_7,
        "discount_type": discount_type,
        "discount_amount": discount_amount,
        "is_new": id == null ? true : false,
      };
}
