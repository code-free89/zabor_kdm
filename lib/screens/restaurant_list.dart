import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kds/constants/api_constants.dart';
import 'package:kds/constants/color_constants.dart';
import 'package:kds/constants/string_constants.dart';
import 'package:kds/helpers/app_utils.dart';
import 'package:kds/helpers/helper_methods.dart';
import 'package:kds/helpers/k3webservice.dart';
import 'package:kds/models/login_response_model.dart';
import 'package:kds/models/restauant_list_response_model.dart';

import 'loginscreen.dart';
import 'package:kds/helpers/resBloc.dart';
import 'package:provider/provider.dart';

int selectedResId = -1;

class MyRestaurantTab extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MyRestaurantTab({Key? key, required this.scaffoldKey})
      : super(key: key);
  @override
  _MyRestaurantTabState createState() => _MyRestaurantTabState();
}

class _MyRestaurantTabState extends State<MyRestaurantTab> {
  bool _isLoading = false;
  GlobalKey<ScaffoldState> get _scaffoldKey => widget.scaffoldKey;
  List<RestaurantDatum> _arrRestaurantData = [];
  int _selectedIndex = -1;
  ResBloc? _resBloc;

  @override
  void initState() {
    super.initState();

    _resBloc = Provider.of<ResBloc>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callRestarantListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("$selectedResId - ${_resBloc.selectRes}");
    return Column(
      children: <Widget>[
        _isLoading
            ? LinearProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColor.lightGreenColor),
              )
            : Container(),
        Expanded(
          child: ListView.builder(
            itemCount: _arrRestaurantData.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  selectedResId = _arrRestaurantData[index].id ?? 0;
                  _resBloc?.selectRes = selectedResId;
                  _resBloc?.selectResTitle =
                      _arrRestaurantData[index].name ?? '';
                });
              },
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(baseUrl +
                              _arrRestaurantData[index].restaurantpic!))),
                  child: Container(
                    decoration:
                        new BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    child: Stack(
                      children: <Widget>[
                        // _resBloc.selectRes == selectedResId
                        _resBloc?.selectRes == _arrRestaurantData[index].id
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.check_circle,
                                      size: 25,
                                      color: AppColor.goldColor,
                                    )),
                              )
                            : Container(),
                        Center(
                            child: Text(
                          _arrRestaurantData[index].name.toString(),
                          style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ),
        ),
      ],
    );
  }

  callRestarantListApi() async {
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
    ApiResponse<RestaurantListRepsonseModel> apiResponse =
        await K3Webservice.postMethod(
      Apis.restaurantList +
          // '?loggedInUser_Id=${user.id}&userid=${user.id}',
          '?userid=${user.id}',
      jsonEncode({
        "draw": 1,
        "order": [
          {"column": 3, "dir": "desc"}
        ],
        "start": 0,
        "length": 10,
        "search": {"value": "", "regex": false}
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
    _arrRestaurantData = apiResponse.data!.data!;
    for (var i = 0; i < _arrRestaurantData.length; i++) {
      if (_arrRestaurantData[i].id == _resBloc?.selectRes) _selectedIndex = i;
    }
    setState(() {
      // if (_arrRestaurantData.isNotEmpty){
      //   selectedResId = _arrRestaurantData.first.id;
      // }
    });
  }
}
