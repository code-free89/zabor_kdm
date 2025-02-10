import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:kds/constants/api_constants.dart';
import 'package:kds/helpers/app_utils.dart';
import 'package:kds/helpers/k3webservice.dart';
import 'package:kds/helpers/resBloc.dart';
import 'package:kds/models/login_response_model.dart';
import 'package:kds/models/order_detail_response_model.dart';
import 'package:provider/provider.dart';

import 'homescreen.dart';
import 'loginscreen.dart';
import 'order_detail_screen.dart';

BuildContext? mainContext;

var isPlayContinous = false;
Timer? ringtoneTimmer;

class SplashScreen extends StatefulWidget {
  static const String routeName = "/";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  ResBloc? _resBloc;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) iOSPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data != null) {
        showNotificationAlert(
          message.data['aps']['alert']['title'],
          message.data['aps']['alert']['body'],
        );
      } else {
        printFirstData(message.data);
        // String aStrBody = message['notification']['body'];
        // String aStr = aStrBody.replaceAll(new RegExp(r'[^0-9]'), '');
        // print(int.parse(aStr));
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(orderId: int.parse(aStr), fromNoti:true)));
        showNotificationAlert(message.data['notification']['title'],
            message.data['notification']['body']);
      }

      FlutterRingtonePlayer player = FlutterRingtonePlayer();
      player.play(
        android: AndroidSounds.notification,
        ios: IosSounds.bell,
        looping: true, // Android only - API >= 28
        volume: 1, // Android only - API >= 28
        asAlarm: false, // Android only - all APIs
      );
      isPlayContinous = true;
      ringtoneTimmer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (isPlayContinous) {
          player.play(
            android: AndroidSounds.notification,
            ios: IosSounds.bell,
            looping: true, // Android only - API >= 28
            volume: 1, // Android only - API >= 28
            asAlarm: false, // Android only - all APIs
          );
        }
      });
    });

    print("firbase inint function");
    FirebaseMessaging.instance.getToken().then((token) {
      print('Firebase Token >>> ' + token!);
      AppUtils.saveFirebaseDeviceToken(token);
    });

    Future.delayed(Duration(milliseconds: 3000), () async {
      bool isUserLoggedin = await AppUtils.isUserLoggedIn();
      if (isUserLoggedin) {
        User? user = await AppUtils.getUser();
        _resBloc = Provider.of(context, listen: false);
        _resBloc?.selectRes = user?.resId ?? 0;
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    });
  }

  printFirstData(Map<String, dynamic> message) async {
    String aStrBody = message['notification']['body'];
    String aStr = aStrBody.replaceAll(new RegExp(r'[^0-9]'), '');

    User? user = await AppUtils.getUser();
    String? token = await AppUtils.getToken();

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'content-type': 'application/json',
      'Client-User-ID': user!.id.toString()
    };
    ApiResponse<OrderDetailRepsonseModel> apiResponse =
        await K3Webservice.postMethod(
      Apis.orderDetail,
      jsonEncode({
        // "loggedInUser_Id": user.id,
        "orderid": int.parse(aStr)
      }),
      headers,
      null,
    );

    print(["apiResponse:", apiResponse.data!.toJson()]);
    printSecondData(apiResponse.data!.data!, allValue: true);
  }

  printSecondData(OrderDetailData _orderDetailData,
      {bool allValue = false}) async {
    List<Cart> _arrCart = [];
    print(["_orderDetailData.cart:", _orderDetailData.cart]);
    final cart = json.decode(_orderDetailData.cart ?? '');
    _arrCart = [];
    for (int j = 0; j < cart.length; j++) {
      _arrCart.add(cartModelfromJson(cart[j]));
    }

    String textStr = "";
    textStr += "------------------------------------------------------\n";
    textStr += "\n";
    textStr += "                Order #${_orderDetailData.id}\n";
    textStr += "\n";
    textStr += "------------------------------------------------------\n";
    textStr += "\n";

    _arrCart.forEach((element) {
      textStr += "${element.quantity.toString()}x  " +
          "${element.itemName}   " +
          "\$${element.itemPrice}\n";
    });
    textStr += "------------------------------------------------------\n";
    textStr += "\n";

    textStr +=
        "Total                                    \$${(_orderDetailData.subtotal - _orderDetailData.foodTax - _orderDetailData.drinkTax).toStringAsFixed(2)}\n";
    textStr +=
        "+Food Tax                                \$${_orderDetailData.foodTax.toStringAsFixed(2)}\n";
    textStr +=
        "+Drink Tax                               \$${_orderDetailData.drinkTax.toStringAsFixed(2)}\n";
    textStr +=
        "+Grand Tax                               \$${_orderDetailData.tax.toStringAsFixed(2)}\n";
    textStr += "\n";
    textStr += "------------------------------------------------------\n";
    textStr += "------------------------------------------------------\n";
    print(textStr);
    print(textStr.length);

    var dio = Dio();
    List<String>? strPrinters = await AppUtils.getPrinters();
    if (strPrinters == null) return;

    for (var i = 0; i < strPrinters.length; i++) {
      if (strPrinters[i].length == 0) continue;
      var data = {};
      if (strPrinters[i].split(".").length == 4) {
        data = {"image": "", "text": textStr, "printerIP": strPrinters[i]};
      } else {
        data = {
          "image": "",
          "text": textStr,
          "printerName": strPrinters[i],
          "printerType": 2
        };
      }
      print(["data:", data]);
      try {
        var response = await dio.post("http://localhost:7200", data: data);
        print(response);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  cartModelfromJson(Map<String, dynamic> json) => Cart(
        itemId: json["itemId"],
        itemName: json["itemName"],
        itemPrice:
            json["itemPrice"] == null ? null : json["itemPrice"].toDouble(),
        customization: json["customization"] == null
            ? null
            : List<CartCustomization>.from(
                json["customization"].map((x) => CartCustomization.fromJson(x)),
              ),
        quantity: json["quantity"],
        taxtype: json["taxtype"],
        taxvalue: json["taxvalue"] == null ? null : json["taxvalue"].toDouble(),
        note: json["note"],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CupertinoActivityIndicator()),
    );
  }

  void iOSPermission() {
    FirebaseMessaging.instance.requestPermission();
  }

  showNotificationAlert(String title, String body) async {
    await showDialog(
      barrierDismissible: false,
      context: mainContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text('$body'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                isPlayContinous = false;
                if (ringtoneTimmer != null) {
                  ringtoneTimmer!.cancel();
                }
                // FlutterRingtonePlayer.stop();
                String aStr = body.replaceAll(new RegExp(r'[^0-9]'), '');
                print(int.parse(aStr));
                Navigator.of(context).pop();
                Navigator.pushNamed(context, OrderDetailScreen.routeName,
                    arguments: int.parse(aStr));
              },
            ),
          ],
        );
      },
    );
  }
}
