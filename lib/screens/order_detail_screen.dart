import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kds/constants/api_constants.dart';
import 'package:kds/constants/color_constants.dart';
import 'package:kds/constants/string_constants.dart';
import 'package:kds/helpers/app_utils.dart';
import 'package:kds/helpers/helper_methods.dart';
import 'package:kds/helpers/k3webservice.dart';
import 'package:kds/models/login_response_model.dart';
import 'package:kds/models/order_detail_response_model.dart';
import 'package:kds/screens/loginscreen.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:kds/utils/utils.dart';
import 'package:kds/screens/printer_register.dart';

import 'package:kds/screens/printer_screen.dart';
import 'package:kds/screens/detail_print.dart';
import 'package:kds/screens/detail_print_all.dart';
import 'package:kds/helpers/app_utils.dart';
import 'dart:convert';
import 'package:kds/constants/shared_pref_keys.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = "/orderDetails";
  final int orderId;
  bool fromNoti;

  OrderDetailScreen({Key? key, required this.orderId, this.fromNoti = false})
      : super(key: key);
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey globalKitchenKey = GlobalKey();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  bool _isLoading = false;
  OrderDetailData? _orderDetailData;
  int get orderId => widget.orderId;

  String _currentDropDownStatus = '';
  List<Cart> _arrCart = [];
  TextEditingController _cookingTimeTextEditingController =
      TextEditingController();
  double printWidth = 512;
  double sysWidth = 0;

  @override
  void initState() {
    super.initState();
    callOrderDetailApi();
    _cookingTimeTextEditingController.text = '30';
    print(["fromNoti:", widget.fromNoti]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('ORDER DETAILS'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.app_registration, size: 20),
            onPressed: () {
              registerPrinter();
            },
          ),
          IconButton(
              icon: Icon(Icons.print),
              onPressed: () {
                printSecondData(allValue: true);
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => DetailPrintAll(orderDetailData: _orderDetailData,)));
                // Navigator.pushNamed(context, PrinterScreen.routeName);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _isLoading
                    ? LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColor.lightGreenColor),
                      )
                    : Container(),
                _orderDetailData == null
                    ? Container()
                    : Column(children: [
                        Card(
                          color: AppColor.lightGreenColor1,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    'Order Status: ${_orderDetailData?.status}'),
                              )),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Order #${_orderDetailData?.orderId}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '${DateFormat('dd-MM-yyyy').format(_orderDetailData!.createdDate!)}',
                          style: TextStyle(),
                        ),
                        SizedBox(height: 10),
                        buildBillingAddressContainer(context),
                        SizedBox(height: 10),
                        buildPaymentStatusContainer(context),
                        SizedBox(height: 20),
                        buildOrderStatusContainer(context),
                        SizedBox(height: 20),
                        buildItemListContainer(context),
                        SizedBox(height: 20)
                      ]),
              ]),
        ),
      ),
    );
  }

  Widget buildItemListContainer(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            children: <Widget>[
              Column(
                children: getInternalItems(),
              ),
              buildPriceColumn(),
              SizedBox(height: 20)
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            printSecondData();
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => DetailPrint(orderDetailData: _orderDetailData,)));
          },
          child: Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right: 10, top: 10),
            child: Container(
              child: Icon(
                Icons.print,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }

  Container buildOrderStatusContainer(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Status'),
        FormBuilder(
            key: _fbKey,
            initialValue: {
              'orderstatus': _orderDetailData!.status == "recieved"
                  ? "received"
                  : _orderDetailData!.status,
              'accept_terms': false,
              'cookt': '30'
            },
            child: Column(children: <Widget>[
              FormBuilderDropdown(
                name: "orderstatus",
                decoration: InputDecoration(labelText: ""),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    _currentDropDownStatus = value.toString();
                  });
                },
                // initialValue: 'Male',
                // hint: Text('Select Status'),
                // validators: [FormBuilderValidators.required()],
                items: [
                  'received',
                  'preparing',
                  'ready',
                  'delivered',
                  'cancelled'
                ]
                    .map((gender) =>
                        DropdownMenuItem(value: gender, child: Text("$gender")))
                    .toList(),
              ),
              SizedBox(height: 10),
              _currentDropDownStatus == "preparing"
                  ? Row(
                      children: [
                        CookingTimeWidget(
                            title: '30',
                            onTap: () {
                              _cookingTimeTextEditingController.text = '30';
                            }),
                        CookingTimeWidget(
                            title: '45',
                            onTap: () {
                              _cookingTimeTextEditingController.text = '45';
                            }),
                        CookingTimeWidget(
                            title: '60',
                            onTap: () {
                              _cookingTimeTextEditingController.text = '60';
                            }),
                        Expanded(
                          child: FormBuilderTextField(
                            name: "cookt",
                            keyboardType: TextInputType.number,
                            controller: _cookingTimeTextEditingController,
                            maxLines: 1,
                            decoration:
                                InputDecoration(labelText: "Cooking Time"),
                            // validators: [
                            //   FormBuilderValidators.required(),
                            // ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(height: 10),
              _currentDropDownStatus == "cancelled" ||
                      _currentDropDownStatus == "delivered"
                  ? FormBuilderTextField(
                      name: "issue",
                      decoration: InputDecoration(labelText: "Issue(if any)"),
                      // validators: [],
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "order #${_orderDetailData?.orderId}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        if (_fbKey.currentState!.saveAndValidate()) {
                          FocusScope.of(context).unfocus();
                          calUpdateStatusApi(
                              _currentDropDownStatus == 'preparing'
                                  ? _fbKey.currentState!.value['cookt']
                                      .toString()
                                  : null,
                              (_currentDropDownStatus == 'cancelled' ||
                                      _currentDropDownStatus == 'delivered')
                                  ? _fbKey.currentState!.value['cookt']
                                  : null);
                        }
                      },
                      child: Container(child: Text("Ready"))),
                  SizedBox(width: 10),
                  Container(
                    // height: 30,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: _orderDetailData!.deliveryMode == 1
                        ? Text('Home Delivery')
                        : Text('Pick up'),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5)),
                  )
                ],
              )
            ]))
      ],
    ));
  }

  Container buildBillingAddressContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10),
          Text(
            'BILLING ADDRESS ',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            'First Name: ${_orderDetailData?.firstname ?? ''}',
          ),
          Text(
            'Last Name: ${_orderDetailData?.lastname ?? ''}',
          ),
          Text(
            'Email: ${_orderDetailData?.email ?? ''}',
          ),
          Text(
            'Phone: ${_orderDetailData?.phone ?? ''}',
          ),
          Text(
            'Address: ${_orderDetailData?.formattedAddress ?? _orderDetailData?.address ?? ''}',
          ),
          Text(
            'City: ${_orderDetailData?.city ?? ''}',
          ),
        ]),
      ),
    );
  }

  Container buildPaymentStatusContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10),
          Text(
            'PAYMENT STATUS',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          _orderDetailData?.paymentStatus == 0
              ? Text(
                  'Payment is remaining for this order.',
                )
              : Text(
                  'Payment is received.',
                ),
          _orderDetailData?.paymentStatus == 0
              ? TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Did you got the payment?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  calPaymentApi();
                                },
                                child: Text('Yes'),
                              )
                            ],
                          );
                        });
                  },
                  child: Text('Got Payment'),
                )
              : Container(),
          SizedBox(height: 10),
          Divider(),
          Text(
            'PAYMENT MODE',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          _orderDetailData?.paymentMode != 2
              ? Text('Online')
              : Text('Pay on delivery'),
          SizedBox(height: 10),
          // Divider(),
          // Text(
          //   'DELIVERY MODE',
          //   style: TextStyle(fontSize: 20),
          // ),
          // SizedBox(height: 10),
          // _orderDetailData?.deliveryMode == 1
          //     ? Text('Home Delivery')
          //     : Text('Pick up'),
        ]),
      ),
    );
  }

  callOrderDetailApi() async {
    setState(() {
      _isLoading = true;
    });
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
        "orderid": orderId
      }),
      headers,
      null,
    );
    setState(() {
      _isLoading = false;
    });
    if (apiResponse.error ?? false) {
      HelperMethods.showSnackBar(
          context, apiResponse.message ?? '', _scaffoldKey, null);
      await Future.delayed(Duration(seconds: 1));
      if (apiResponse.message == StringConstant.sessionExpiredText) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        return;
      }
      return;
    }

    setState(() {
      _orderDetailData = apiResponse.data?.data;
      final cart = json.decode(_orderDetailData!.cart!);
      _arrCart = [];
      // for (int j = 0; j < _orderDetailData?.cart.length; j++) {
      for (int j = 0; j < cart.length; j++) {
        _arrCart.add(cartModelfromJson(cart[j]));
      }
    });
    if (widget.fromNoti) Future.delayed(Duration(seconds: 1), () {});
  }

  calPaymentApi() async {
    setState(() {
      _isLoading = true;
    });
    User? user = await AppUtils.getUser();
    String? token = await AppUtils.getToken();
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'content-type': 'application/json',
      'Client-User-ID': user!.id.toString()
    };
    ApiResponse<CommonResponseModel> apiResponse =
        await K3Webservice.postMethod(
      Apis.paymentUpdateApi,
      jsonEncode({
        // "loggedInUser_Id": user.id,
        "orderid": orderId
      }),
      headers,
      null,
    );
    setState(() {
      _isLoading = false;
    });
    if (apiResponse.error ?? false) {
      HelperMethods.showSnackBar(
          context, apiResponse.message ?? '', _scaffoldKey, null);
      await Future.delayed(Duration(seconds: 1));
      if (apiResponse.message == StringConstant.sessionExpiredText) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        return;
      }
      return;
    }

    HelperMethods.showSnackBar(
        context, apiResponse.data?.msg ?? '', _scaffoldKey, null);
    callOrderDetailApi();
  }

  calUpdateStatusApi(dynamic cookt, dynamic issue) async {
    if (_currentDropDownStatus == '') return;
    setState(() {
      _isLoading = true;
    });
    User? user = await AppUtils.getUser();
    String? token = await AppUtils.getToken();
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'content-type': 'application/json',
      'Client-User-ID': user!.id.toString()
    };
    ApiResponse<CommonResponseModel> apiResponse =
        await K3Webservice.postMethod(
      Apis.updateStatusApi,
      jsonEncode({
        // "loggedInUser_Id": user.id,
        "orderId": orderId,
        'orderstatus': _currentDropDownStatus,
        'cookt': cookt,
        'issue': issue
      }),
      headers,
      null,
    );
    setState(() {
      _isLoading = false;
    });
    if (apiResponse.error ?? false) {
      HelperMethods.showSnackBar(
          context, apiResponse.message ?? '', _scaffoldKey, null);
      await Future.delayed(Duration(seconds: 1));
      if (apiResponse.message == StringConstant.sessionExpiredText) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        return;
      }
      return;
    }
    HelperMethods.showSnackBar(
        context, apiResponse.data?.msg ?? '', _scaffoldKey, null);
    callOrderDetailApi();
  }

  registerPrinter() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PrinterRegister()));
  }

  printSecondData({bool allValue = false}) async {
    String textStr = "";

    textStr += "                Order #${_orderDetailData?.id}\n";

    if (allValue) {
      textStr += "BILLING ADDRESS:\n";
      textStr += "\n";
      textStr += "First Name:${_orderDetailData?.firstname.toString()}\n";
      textStr += "Last Name:${_orderDetailData?.lastname.toString()}\n";
      textStr += "Email:${_orderDetailData?.email}\n";
      textStr += "Phone:${_orderDetailData?.phone}\n";
      textStr += "Address:${_orderDetailData?.address}\n";
      textStr += "City:${_orderDetailData?.city}\n";
      textStr += "\n";
    }
    // String ip = await Wifi.ip;

    _arrCart.forEach((element) {
      textStr += "${element.quantity.toString()}x  " +
          "${element.itemName}   " +
          "\$${element.itemPrice}\n";
    });

    textStr +=
        "Total                                    \$${(_orderDetailData?.subtotal - _orderDetailData?.foodTax - _orderDetailData?.drinkTax).toStringAsFixed(2)}\n";
    textStr +=
        "+Food Tax                                \$${_orderDetailData?.foodTax.toStringAsFixed(2)}\n";
    textStr +=
        "+Drink Tax                               \$${_orderDetailData?.drinkTax.toStringAsFixed(2)}\n";
    textStr +=
        "+Grand Tax                               \$${_orderDetailData?.tax.toStringAsFixed(2)}\n";
    textStr += "\n";
    textStr +=
        "+Delivery Change                         \$${_orderDetailData?.deliveryCharge.toStringAsFixed(2) ?? 0}\n";
    // print(["ipAddress:",ip]);
    var imageBase64 = "";
    print(textStr);
    print(textStr.length);

    var dio = Dio();
    List<String>? strPrinters = await AppUtils.getPrinters();
    print(["strPrinters:", strPrinters]);
    if (strPrinters == null) return showPrintAlert();
    for (var i = 0; i < strPrinters.length; i++) {
      if (strPrinters[i].length < 11) continue;
      try {
        var response = await dio.post("http://localhost:7200", data: {
          "image": imageBase64,
          "text": textStr,
          "printerIP": strPrinters[i],
          "printerType": 1,
        });
        showSnackBar(_scaffoldKey, "print Success", null, context);
        print(["success", response.data]);
      } catch (e) {
        showSnackBar(_scaffoldKey, "print failed", null, context);
        print(["catch", e.toString()]);
      }
    }
  }

  showPrintAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('You have to register printers'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Yes'),
              )
            ],
          );
        });
  }

  List<Widget> getInternalItems() {
    List<Widget> tempWidget = [];
    for (int i = 0; i < _arrCart.length; i++) {
      tempWidget.add(buildItemCell(i));
    }
    return tempWidget;
  }

  Widget buildItemCell(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 3)
                          ],
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        '${_arrCart[index].quantity ?? ""}x',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${_arrCart[index].itemName ?? ""}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '\$ ${_arrCart[index].itemPrice?.toStringAsFixed(2) ?? ""}',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '${_arrCart[index].note ?? ''}',
                            style: TextStyle(fontSize: 11, color: Colors.red),
                          ),
                          Text(getCustomizationsList(index),
                              style: TextStyle(
                                fontSize: 14,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }

  Widget buildPriceColumn() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${(_orderDetailData?.subtotal - _orderDetailData?.foodTax - _orderDetailData?.drinkTax).toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '+ Food Tax',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '\$${_orderDetailData?.foodTax.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '+ Drink Tax',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '\$${_orderDetailData?.drinkTax.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '+Grand Tax',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '\$${_orderDetailData?.tax.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '+Delivery Charge',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '\$${_orderDetailData?.deliveryCharge.toStringAsFixed(2) ?? 0}',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Payable Amount',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '\$${_orderDetailData?.total.toStringAsFixed(2) ?? 0}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ]),
        ),
      );

  Widget wdPrintKitchenData(OrderDetailData printData) {
    final cart = json.decode(_orderDetailData!.cart!);
    List<Cart> _arrCart = [];
    for (int j = 0; j < cart.length; j++) {
      _arrCart.add(cartModelfromJson(cart[j]));
    }

    return SingleChildScrollView(
        child: RepaintBoundary(
      key: globalKitchenKey,
      child: Container(
        width: printWidth + 65,
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Container(
          color: Colors.white,
          width: printWidth,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              Container(
                width: printWidth - 30,
                child: printDivider(width: printWidth - 30),
              ),
              SizedBox(height: 5),
              Container(
                width: printWidth - 30,
                child: printDivider(width: printWidth - 30),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${DateFormat("MM/dd/yyyy").format(DateTime.now())}",
                        style: TextStyle(fontSize: 20)),
                    Text("${DateFormat("hh:mm:ss a").format(DateTime.now())}",
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: printWidth - 30,
                child: printDivider(width: printWidth - 30),
              ),
              Column(
                children: [
                  ..._arrCart
                      .asMap()
                      .map((key, value) => MapEntry(
                          key,
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 3),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("${value.quantity.toString()}X  ",
                                          style: TextStyle(fontSize: 25)),
                                      Text(value.itemName ?? '',
                                          style: TextStyle(fontSize: 25))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      ...value.customization!
                                          .asMap()
                                          .map((key, value) => MapEntry(
                                              key,
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                child: Text(value.optionName!,
                                                    style: TextStyle(
                                                        fontSize: 22)),
                                              )))
                                          .values
                                          .toList()
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )))
                      .values
                      .toList(),
                  SizedBox(height: 15),
                ],
              ),
              Container(
                width: printWidth - 30,
                child: printDivider(width: printWidth - 30),
              ),
              SizedBox(height: 5),
              Container(
                width: printWidth - 30,
                child: printDivider(width: printWidth - 30),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: Text(
                    "Ticket #: ${_orderDetailData?.orderId == null ? '#' : _orderDetailData?.orderId}",
                    style: TextStyle(fontSize: 30)),
              ),
              Container(
                width: printWidth - 30,
                child: printDivider(width: printWidth - 30),
              ),
              SizedBox(height: 5),
              Container(
                width: printWidth - 30,
                child: printDivider(width: printWidth - 30),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget printDivider({double? width}) {
    sysWidth = MediaQuery.of(context).size.width;
    if (width == null) width = sysWidth;
    final dashCount = (width / (2 * 9)).floor();
    return Flex(
      children: List.generate(dashCount, (_) {
        return SizedBox(
          width: 9,
          height: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey),
          ),
        );
      }),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Axis.horizontal,
    );
  }

  String getCustomizationsList(int index) {
    String string = "";
    for (int i = 0; i < _arrCart[index].customization!.length; i++) {
      CartCustomization cartCustomization = _arrCart[index].customization![i];
      string += "+ ${cartCustomization.optionName}\n";
    }
    return string;
  }

  cartModelfromJson(Map<String, dynamic> json) => Cart(
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
        taxvalue: json["taxvalue"] == null ? null : json["taxvalue"].toDouble(),
        note: json["note"] == null ? null : json["note"],
      );
}

class CookingTimeWidget extends StatelessWidget {
  final Function onTap;
  final String title;
  const CookingTimeWidget({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: AppColor.lightGreenColor,
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: AppColor.whiteColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
