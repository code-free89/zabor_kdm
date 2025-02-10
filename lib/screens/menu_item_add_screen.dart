import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kds/components/new_menu_item.dart';
import 'package:kds/constants/api_constants.dart';
import 'package:kds/constants/color_constants.dart';
import 'package:kds/constants/string_constants.dart';
import 'package:kds/helpers/app_utils.dart';
import 'package:kds/helpers/helper_methods.dart';
import 'package:kds/helpers/k3webservice.dart';
import 'package:kds/models/item_group_response_model.dart';
import 'package:kds/models/item_list_response_model.dart';
import 'package:kds/models/login_response_model.dart';
import 'package:kds/screens/item_list_screen.dart';
import 'package:kds/screens/loginscreen.dart';

class MenuItemAddScreen extends StatefulWidget {
  final GroupDatum group;
  final List<Menuitem> menuItems;
  final int selectedResId;
  const MenuItemAddScreen({
    super.key,
    required this.group,
    required this.menuItems,
    required this.selectedResId,
  });

  @override
  State<MenuItemAddScreen> createState() => _MenuItemAddScreenState();
}

class _MenuItemAddScreenState extends State<MenuItemAddScreen> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final List<Menuitem> newMenuItems = [Menuitem(itemName: 'New item 1')];
  final List<GlobalKey<FormBuilderState>> fbKeys = [
    GlobalKey<FormBuilderState>()
  ];
  int get _selectedResId => widget.selectedResId;
  GroupDatum get _group => widget.group;
  List<Menuitem> get _originalItems => widget.menuItems;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add item'),
        actions: [
          TextButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              fbKeys.forEach((fbKey) {
                if (fbKey.currentState!.saveAndValidate()) {
                  Menuitem item = Menuitem.fromJson(fbKey.currentState!.value);
                  _originalItems.add(item);
                }
              });
              List<Map<String, dynamic>> newItems =
                  _originalItems.map((item) => item.toNewItemJson()).toList();
              Map<String, dynamic> data = {};
              data.addAll(_group.toJson());
              data.remove('id');
              data.remove('group_name');
              data['groupId'] = _group.id;
              data['resid'] = _selectedResId;
              data['groupname'] = _group.groupName;
              data['items'] = jsonEncode(newItems);
              callAddNewItemApi(data);
            },
            child: Text('Save'),
          )
        ],
      ),
      body: Column(
        children: [
          _isLoading
              ? LinearProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColor.lightGreenColor),
                )
              : Container(),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: newMenuItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewMenuItem(
                    menuItem: newMenuItems[index],
                    fbKey: fbKeys[index],
                  );
                },
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                setState(() {
                  fbKeys.add(GlobalKey<FormBuilderState>());
                  newMenuItems.add(
                    Menuitem(
                      itemName: 'New item ${newMenuItems.length + 1}',
                      id: newMenuItems.length,
                    ),
                  );
                });
              },
              child: Text('Add more'),
            ),
          )
        ],
      ),
    );
  }

  callAddNewItemApi(data) async {
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
      Apis.createGroupItemApi + '?&loggedInUser_Id=${user.id}',
      jsonEncode(data),
      headers,
      null,
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
    } else {
      Navigator.pushReplacementNamed(
        context,
        ItemListScreen.routeName,
        arguments: _group.id,
      );
    }
  }
}
