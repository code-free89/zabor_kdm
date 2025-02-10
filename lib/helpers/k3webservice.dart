import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kds/constants/string_constants.dart';
import 'package:kds/models/item_group_response_model.dart';
import 'package:kds/models/item_list_response_model.dart';
import 'package:kds/models/login_response_model.dart';
import 'package:kds/models/order_detail_response_model.dart';
import 'package:kds/models/order_list_response_model.dart';
import 'package:kds/models/restauant_list_response_model.dart';

class K3Webservice {
  static Future<ApiResponse<T>> postMethod<T>(
      String url, dynamic data, dynamic headers, dynamic files) async {
    print('hitting url: ' + url);
    print('with parameter: ' + data.toString());
    print('with headers: ' + headers.toString());
    print('with files: ' + files.toString());

    if (files == null) {
      try {
        print(headers);
        var response =
            await http.post(Uri.parse(url), headers: headers, body: data);
        print(response.body);
        if (jsonDecode(response.body)["message"] == "Auth failed" ||
            jsonDecode(response.body)["msg"] == "Auth failed") {
          return ApiResponse(
              error: true, message: StringConstant.sessionExpiredText);
        }
        if (response.statusCode == 200) {
          if (jsonDecode(response.body)["status"] == false) {
            return ApiResponse<T>(
                error: true, message: jsonDecode(response.body)["msg"]);
          }
          return ApiResponse<T>(
            data: fromJson<T>(jsonDecode(response.body)),
            message: jsonDecode(response.body)["msg"],
          );
        } else if (response.statusCode == 422) {
          return ApiResponse<T>(error: true, message: "Something went wrong");
        } else {
          return ApiResponse<T>(error: true, message: "Something went wrong");
        }
      } catch (e) {
        print(e.toString());
        return ApiResponse<T>(error: true, message: "Something went wrong");
      }
    } else {
      try {
        var uri = Uri.parse(url);
        var request, response;
        request = http.MultipartRequest("POST", uri);

        // Add headers
        if (headers != null) {
          request.headers.addAll(headers);
        }

        // Add fields
        jsonDecode(data).forEach((key, value) => {
              if (key == 'items')
                {
                  request.fields[key] = value,
                }
              else
                {request.fields[key] = value.toString()}
            });

        // Add file
        if (files != null) {
          var key = "", path = "";
          files.forEach((key, value) => {
                key = key,
                path = value,
              });
          File file = File(path);
          request.files.add(await http.MultipartFile.fromPath(
            key,
            file.path,
          ));
        }

        final streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);

        if (jsonDecode(response.body)["message"] == "Auth failed" ||
            jsonDecode(response.body)["msg"] == "Auth failed") {
          return ApiResponse(
            error: true,
            message: StringConstant.sessionExpiredText,
          );
        }
        if (response.statusCode == 200) {
          if (jsonDecode(response.body)["status"] == false) {
            return ApiResponse<T>(
                error: true, message: jsonDecode(response.body)["msg"]);
          }
          return ApiResponse<T>(
            data: fromJson<T>(jsonDecode(response.body)),
            message: jsonDecode(response.body)["msg"],
          );
        } else if (response.statusCode == 422) {
          return ApiResponse<T>(error: true, message: "Something went wrong");
        } else {
          return ApiResponse<T>(error: true, message: "Something went wrong");
        }
      } catch (e) {
        print(e.toString());
        return ApiResponse<T>(error: true, message: "Something went wrong");
      }
    }
  }

  static Future<ApiResponse<T>> getMethod<T>(
      String url, dynamic headers) async {
    print('hitting url: ' + url);
    print('with headers: ' + headers.toString());
    var response = await http.get(Uri.parse(url), headers: headers);
    print(response.body);
    if (jsonDecode(response.body)["message"] == "Auth failed" ||
        jsonDecode(response.body)["msg"] == "Auth failed") {
      return ApiResponse(
          error: true, message: StringConstant.sessionExpiredText);
    }
    if (response.statusCode == 200) {
      return ApiResponse<T>(data: fromJson<T>(jsonDecode(response.body)));
    } else if (response.statusCode == 422) {
      return ApiResponse<T>(error: true, message: "Something went wrong");
    } else {
      return ApiResponse<T>(error: true, message: "Something went wrong");
    }
  }

  static T fromJson<T>(dynamic json) {
    if (T == CommonResponseModel) {
      return CommonResponseModel.fromJson(json) as T;
    } else if (T == LoginRepsonseModel) {
      return LoginRepsonseModel.fromJson(json) as T;
    } else if (T == RestaurantListRepsonseModel) {
      return RestaurantListRepsonseModel.fromJson(json) as T;
    } else if (T == OrderListRepsonseModel) {
      return OrderListRepsonseModel.fromJson(json) as T;
    } else if (T == OrderDetailRepsonseModel) {
      return OrderDetailRepsonseModel.fromJson(json) as T;
    } else if (T == ItemGroupRepsonseModel) {
      return ItemGroupRepsonseModel.fromJson(json) as T;
    } else if (T == ItemListRepsonseModel) {
      return ItemListRepsonseModel.fromJson(json) as T;
    } else {
      return ItemListRepsonseModel.fromJson(json) as T;
      //throw Exception("Unknown class");
    }
  }
}

class ApiResponse<T> {
  T? data;
  String? message;
  bool? error;
  ApiResponse({this.data, this.error = false, this.message});
}

class CommonResponseModel {
  bool? status;
  String? msg;

  CommonResponseModel({
    this.status,
    this.msg,
  });

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) =>
      CommonResponseModel(
        status: json["status"] == null ? null : json["status"],
        msg: json["msg"] == null ? null : json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
      };
}
