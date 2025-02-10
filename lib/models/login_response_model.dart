class LoginRepsonseModel {
  LoginRepsonseModel({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  LoginData? data;

  factory LoginRepsonseModel.fromJson(Map<String, dynamic> json) =>
      LoginRepsonseModel(
        status: json["status"] == null ? null : json["status"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data!.toJson(),
      };
}

class LoginData {
  LoginData({
    this.user,
    this.token,
    this.resId,
  });

  User? user;
  String? token;
  int? resId;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      token: json["token"] == null ? null : json["token"],
      resId: json["resId"] == null ? null : (json["resId"]));

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
        "token": token == null ? null : token,
        "resId": resId == null ? null : resId
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.profileimage,
    this.address,
    this.city,
    this.latitude,
    this.longitude,
    this.dob,
    this.about,
    this.phone,
    this.role,
    this.status,
    this.prefLang,
    this.fbToken,
    this.googleToken,
    this.instragramToken,
    this.twitterToken,
    this.token,
    this.resetToken,
    this.platform,
    this.resId,
    this.deviceToken,
    this.createdDate,
  });

  int? id;
  String? name;
  String? email;
  String? profileimage;
  String? address;
  String? city;
  dynamic latitude;
  dynamic longitude;
  DateTime? dob;
  String? about;
  String? phone;
  String? role;
  int? status;
  String? prefLang;
  dynamic fbToken;
  dynamic googleToken;
  dynamic instragramToken;
  dynamic twitterToken;
  dynamic token;
  String? resetToken;
  dynamic platform;
  dynamic deviceToken;
  DateTime? createdDate;
  int? resId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        profileimage:
            json["profileimage"] == null ? null : json["profileimage"],
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        about: json["about"] == null ? null : json["about"],
        phone: json["phone"] == null ? null : json["phone"],
        role: json["role"] == null ? null : json["role"],
        status: json["status"] == null ? null : json["status"],
        prefLang: json["pref_lang"] == null ? null : json["pref_lang"],
        fbToken: json["fb_token"],
        googleToken: json["google_token"],
        instragramToken: json["instragram_token"],
        resId: json["resId"] == null ? null : json["resId"],
        twitterToken: json["twitter_token"],
        token: json["token"],
        resetToken: json["reset_token"] == null ? null : json["reset_token"],
        platform: json["platform"],
        deviceToken: json["device_token"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "profileimage": profileimage == null ? null : profileimage,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "latitude": latitude,
        "longitude": longitude,
        "dob": dob == null ? null : dob!.toIso8601String(),
        "about": about == null ? null : about,
        "phone": phone == null ? null : phone,
        "role": role == null ? null : role,
        "status": status == null ? null : status,
        "pref_lang": prefLang == null ? null : prefLang,
        "fb_token": fbToken,
        "google_token": googleToken,
        "instragram_token": instragramToken,
        "resId": resId,
        "twitter_token": twitterToken,
        "token": token,
        "reset_token": resetToken == null ? null : resetToken,
        "platform": platform,
        "device_token": deviceToken,
        "created_date":
            createdDate == null ? null : createdDate!.toIso8601String(),
      };
}
