import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kds/components/menu_item.dart';
import 'package:kds/constants/api_constants.dart';
import 'package:kds/constants/color_constants.dart';
import 'package:kds/constants/string_constants.dart';
import 'package:kds/helpers/app_utils.dart';
import 'package:kds/helpers/helper_methods.dart';
import 'package:kds/helpers/k3webservice.dart';
import 'package:kds/models/item_group_response_model.dart';
import 'package:kds/models/item_list_response_model.dart';
import 'package:kds/models/login_response_model.dart';
import 'package:kds/screens/menu_item_add_screen.dart';
import 'package:kds/screens/restaurant_list.dart';

import 'loginscreen.dart';

class ItemListScreen extends StatefulWidget {
  static const String routeName = "/itemListScreen";
  final int groupID;
  const ItemListScreen({Key? key, required this.groupID});

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  List<Menuitem> _arrMenuItems = [];
  late GroupDatum _group;

  @override
  void initState() {
    super.initState();
    callItemListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => MenuItemAddScreen(
                    group: _group,
                    menuItems: _arrMenuItems,
                    selectedResId: selectedResId,
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          _isLoading
              ? LinearProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColor.lightGreenColor),
                )
              : Container(),
          Expanded(
            child: ListView.builder(
              itemCount: _arrMenuItems.length,
              itemBuilder: (context, index) {
                return MenuListItem(
                  menuItem: _arrMenuItems[index],
                  selectedResId: selectedResId,
                  updateMenuitem: (value, imagePath) => {
                    updateMenuitem(value, imagePath, index),
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  updateMenuitem(data, imagePath, index) {
    Map<String, dynamic> newItem = _arrMenuItems[index].toJson();
    data.forEach((key, value) => {
          if (newItem.containsKey(key)) {newItem[key] = value}
        });
    _arrMenuItems[index] = Menuitem.fromJson(newItem);
    List<Map<String, dynamic>> newItems =
        _arrMenuItems.map((item) => item.toNewItemJson()).toList();
    Map<String, dynamic> request_data = {};
    request_data.addAll(_group.toJson());
    request_data.remove('id');
    request_data.remove('group_name');
    request_data['groupId'] = _group.id;
    request_data['resid'] = selectedResId;
    request_data['groupname'] = _group.groupName;

    var picIndex = 0;
    newItems.forEach((item) {
      if (item['itempic'] != "" && index != picIndex) {
        request_data['itemPic_$picIndex'] = item['itempic'];
      } else if (index == picIndex && imagePath != "") {
        print('here1');
        newItems[index]['itempic'] = {};
        newItems[index]['pic'] = imagePath;
      }
      picIndex++;
    });
    request_data['items'] = jsonEncode(newItems);

    Map<String, dynamic> files = {};
    if (imagePath != "") {
      files = {"itemPic_$index": imagePath};
      callUpdateItemApi(request_data, files);
    } else {
      callUpdateItemApi(request_data, null);
    }
  }

  callItemListApi() async {
    if (selectedResId == -1) {
      HelperMethods.showSnackBar(
          context,
          'Please go to restaurant tab and select the restaurant first.',
          _scaffoldkey,
          null);
      return;
    }
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
    ApiResponse<ItemListRepsonseModel> apiResponse =
        await K3Webservice.getMethod(
      Apis.itemListApi +
          '?resid=$selectedResId&groupid=${widget.groupID}&loggedInUser_Id=${user.id}',
      // '?resid=$selectedResId&groupid=${widget.groupID}',
      headers,
    );
    setState(() {
      _isLoading = false;
    });
    if (apiResponse.error ?? false) {
      HelperMethods.showSnackBar(
        context,
        apiResponse.message ?? '',
        _scaffoldkey,
        null,
      );
      await Future.delayed(Duration(seconds: 1));
      if (apiResponse.message == StringConstant.sessionExpiredText) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        return;
      }
      return;
    }

    setState(() {
      _arrMenuItems = apiResponse.data?.menuitems ?? [];
      _group = apiResponse.data?.group ?? new GroupDatum();
    });
  }

  callUpdateItemApi(data, files) async {
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
    ApiResponse<dynamic> apiResponse = await K3Webservice.postMethod(
      Apis.createGroupItemApi + '?loggedInUser_Id=${user.id}',
      jsonEncode(data),
      headers,
      files,
    );
    setState(() {
      _isLoading = false;
    });
    HelperMethods.showSnackBar(
      context,
      apiResponse.message ?? '',
      _scaffoldkey,
      null,
    );
    await Future.delayed(Duration(seconds: 1));
    if (apiResponse.error ?? false) {
      if (apiResponse.message == StringConstant.sessionExpiredText) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        return;
      }
    }
  }
}
