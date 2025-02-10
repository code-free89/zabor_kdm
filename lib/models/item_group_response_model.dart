class ItemGroupRepsonseModel {
  ItemGroupRepsonseModel({
    this.status,
    this.msg,
    this.data,
  });

  int? status;
  String? msg;
  List<GroupDatum>? data;

  factory ItemGroupRepsonseModel.fromJson(Map<String, dynamic> json) =>
      ItemGroupRepsonseModel(
        status: json["status"] == null ? null : json["status"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : List<GroupDatum>.from(
                json["data"].map((x) => GroupDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GroupDatum {
  GroupDatum({
    this.id,
    this.groupName,
    this.groupImage,
    this.monopen_time,
    this.monclose_time,
    this.tueopen_time,
    this.tueclose_time,
    this.wedopen_time,
    this.wedclose_time,
    this.thuopen_time,
    this.thuclose_time,
    this.friopen_time,
    this.friclose_time,
    this.satopen_time,
    this.satclose_time,
    this.sunopen_time,
    this.sunclose_time,
  });

  int? id;
  String? groupName;
  String? groupImage;
  String? monopen_time;
  String? monclose_time;
  String? tueopen_time;
  String? tueclose_time;
  String? wedopen_time;
  String? wedclose_time;
  String? thuopen_time;
  String? thuclose_time;
  String? friopen_time;
  String? friclose_time;
  String? satopen_time;
  String? satclose_time;
  String? sunopen_time;
  String? sunclose_time;

  factory GroupDatum.fromJson(Map<String, dynamic> json) => GroupDatum(
        id: json["id"] == null ? null : json["id"],
        groupName: json["group_name"] == null ? null : json["group_name"],
        groupImage: json["group_image"],
        monopen_time: json["monopen_time"],
        monclose_time: json["monclose_time"],
        tueopen_time: json["tueopen_time"],
        tueclose_time: json["tueclose_time"],
        wedopen_time: json["wedopen_time"],
        wedclose_time: json["wedclose_time"],
        thuopen_time: json["thuopen_time"],
        thuclose_time: json["thuclose_time"],
        friopen_time: json["friopen_time"],
        friclose_time: json["friclose_time"],
        satopen_time: json["satopen_time"],
        satclose_time: json["satclose_time"],
        sunopen_time: json["sunopen_time"],
        sunclose_time: json["sunclose_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "group_name": groupName,
        "group_image": groupImage,
        "monopen_time": monopen_time,
        "monclose_time": monclose_time,
        "tueopen_time": tueopen_time,
        "tueclose_time": tueclose_time,
        "wedopen_time": wedopen_time,
        "wedclose_time": wedclose_time,
        "thuopen_time": thuopen_time,
        "thuclose_time": thuclose_time,
        "friopen_time": friopen_time,
        "friclose_time": friclose_time,
        "satopen_time": satopen_time,
        "satclose_time": satclose_time,
        "sunopen_time": sunopen_time,
        "sunclose_time": sunclose_time,
      };
}
