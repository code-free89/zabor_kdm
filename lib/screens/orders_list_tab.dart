import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kds/components/order_list_item.dart';
import 'package:kds/components/order_list_item_mobile.dart';
import 'package:kds/constants/api_constants.dart';
import 'package:kds/constants/color_constants.dart';
import 'package:kds/constants/string_constants.dart';
import 'package:kds/helpers/app_utils.dart';
import 'package:kds/helpers/helper_methods.dart';
import 'package:kds/helpers/k3webservice.dart';
import 'package:kds/models/login_response_model.dart';
import 'package:kds/models/order_list_response_model.dart';
import 'package:intl/intl.dart';
import 'loginscreen.dart';
import 'order_detail_screen.dart';
import 'package:kds/helpers/resBloc.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class OrdersTab extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const OrdersTab({Key? key, required this.scaffoldKey}) : super(key: key);
  @override
  _OrdersTabState createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  bool _isLoading = false;
  GlobalKey<ScaffoldState> get _scaffoldKey => widget.scaffoldKey;
  List<OrderListDatum> _arrOrderData = [];
  int selectPage = 1;
  ResBloc? _resBloc;
  int totalCount = 1;
  int pageCount = 1;
  String _viewMode = 'received';
  final List<bool> selectedView = <bool>[true, false];

  @override
  void initState() {
    super.initState();
    _resBloc = Provider.of<ResBloc>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callOrderListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    double sysWidth = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      color: AppColor.lightGreenColor,
      onRefresh: () async {
        // print("refreshed");
        await callOrderListApi();
      },
      child: Column(
        children: <Widget>[
          _isLoading
              ? LinearProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColor.lightGreenColor),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Selected Res: ${_resBloc?.selectResTitle}",
                        style: TextStyle(fontSize: 15))),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _viewMode == 'received'
                        ? null
                        : () {
                            selectPage = 1;
                            // _resBloc.selectRes = -1;
                            _resBloc?.selectResTitle = "All";
                            fetchReceived();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: Text("Received"),
                  ),
                  VerticalDivider(width: 5),
                  ElevatedButton(
                    onPressed: _viewMode == 'ready'
                        ? null
                        : () {
                            selectPage = 1;
                            fetchReady();
                          },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: Text("Ready"),
                  ),
                ],
              ),
              sysWidth < 912
                  ? Container()
                  : Container(
                      width: sysWidth / 2,
                      margin: EdgeInsets.only(top: 10, right: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.black54),
                      child: pageNumberList(),
                    )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              setState(() {
                // The button that is tapped is set to true, and the others to false.
                for (int i = 0; i < selectedView.length; i++) {
                  selectedView[i] = i == index;
                }
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: Colors.grey,
            selectedColor: Colors.black,
            fillColor: Colors.grey,
            color: Colors.black,
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: selectedView,
            children: <Widget>[Text('4 Views'), Text('8 Views')],
          ),
          Expanded(
            child: sysWidth > 992
                ? Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      ..._arrOrderData
                          .asMap()
                          .map((key, value) {
                            return MapEntry(
                              key,
                              OrderListItem(
                                order_item: value,
                                calUpdateStatusApi: calUpdateStatusApi,
                                numberOfColumns:
                                    this.selectedView[0] == true ? 2 : 4,
                              ),
                            );
                          })
                          .values
                          .toList()
                    ],
                  )
                : ListView.builder(
                    itemCount: _arrOrderData.length,
                    itemBuilder: (context, index) => OrderListItemMobile(
                      order_item: _arrOrderData[index],
                      calUpdateStatusApi: calUpdateStatusApi,
                    ),
                  ),
          )
        ],
      ),
    );
  }

  callOrderListApi() async {
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

    var url = (Apis.orderList +
        // '?res_id=${_resBloc.selectRes}&loggedInUser_Id=${user.id}&userid=${user.id}');
        '?res_id=${_resBloc?.selectRes}&userid=${user.id}');
    ApiResponse<OrderListRepsonseModel> apiResponse =
        await K3Webservice.postMethod(
      Apis.orderList + '?res_id=${_resBloc?.selectRes}&userid=${user.id}',
      jsonEncode({
        "draw": 1,
        "columns": [
          {
            "data": "id",
            "name": "",
            "searchable": false,
            "orderable": false,
            "search": {"value": "", "regex": false}
          },
          {
            "data": "orderid",
            "name": "",
            "searchable": true,
            "orderable": true,
            "search": {"value": "", "regex": false}
          }
        ],
        "order": [
          {"column": 1, "dir": "desc"}
        ],
        "start": (selectPage - 1) * 10,
        "length": 10,
        "search": {"value": "", "regex": false},
        "res_id": _resBloc?.selectRes.toString(),
        "status": _viewMode == 'all' ? -1 : _viewMode,
        "ago": "3d",
      }),
      headers,
      null,
    );

    // print(apiResponse.message);
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
    List<OrderListDatum>? orderData = apiResponse.data?.data;

    if (_resBloc?.selectRes != -1) {
      _arrOrderData.clear();
      print(orderData?.length);
      totalCount = orderData?.toList().length ?? 0;

      for (OrderListDatum order in orderData ?? []) {
        if (_resBloc?.selectRes == order.resId)
          _arrOrderData.add(order);
        else
          _arrOrderData = apiResponse.data!.data!;
      }
    }
    setState(() {});
  }

  fetchReceived() {
    _viewMode = 'received';
    callOrderListApi();
  }

  fetchReady() {
    _viewMode = 'ready';
    callOrderListApi();
  }

  calUpdateStatusApi(int orderId) async {
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
        'orderstatus': "ready"
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
    _viewMode = 'ready';
    selectPage = 1;
    callOrderListApi();
  }

  Widget pageNumberList() {
    print(["totalCount:", totalCount, pageCount]);
    pageCount = (totalCount / 10).ceil();
    print(pageCount);
    List<Widget> list = List<Widget>.generate(
        pageCount,
        (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectPage = index + 1;
                  callOrderListApi();
                });
              },
              child: Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: selectPage == (index + 1)
                      ? Colors.grey
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text((index + 1).toString(),
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ),
            ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }
}
