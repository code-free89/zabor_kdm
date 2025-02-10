import 'package:flutter/material.dart';
import 'package:kds/constants/api_constants.dart';
import 'package:kds/constants/color_constants.dart';
import 'package:kds/constants/string_constants.dart';
import 'package:kds/helpers/app_utils.dart';
import 'package:kds/helpers/helper_methods.dart';
import 'package:kds/helpers/k3webservice.dart';
import 'package:kds/models/item_group_response_model.dart';
import 'package:kds/models/login_response_model.dart';
import 'package:kds/screens/restaurant_list.dart';

import 'item_list_screen.dart';
import 'loginscreen.dart';

class MenuTab extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const MenuTab({Key? key, this.scaffoldKey}) : super(key: key);
  @override
  _MenuTabState createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  bool _isLoading = false;
  GlobalKey<ScaffoldState>? get _scaffoldKey => widget.scaffoldKey;
  List<GroupDatum>? _arrGroupData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callItemGroupListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _isLoading
            ? LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColor.lightGreenColor,
                ),
              )
            : Container(),
        Expanded(
          child: ListView.builder(
            itemCount: _arrGroupData?.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.pushNamed(context, ItemListScreen.routeName,
                    arguments: _arrGroupData?[index].id);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Text(_arrGroupData?[index].groupName ?? ''),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  callItemGroupListApi() async {
    if (selectedResId == -1) {
      HelperMethods.showSnackBar(
          context,
          'Please go to restaurant tab and select the restaurant first.',
          _scaffoldKey,
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
    ApiResponse<ItemGroupRepsonseModel> apiResponse =
        await K3Webservice.getMethod(
            Apis.itemGroupApi +
                // '?resid=$selectedResId&loggedInUser_Id=${user.id}',
                '?resid=$selectedResId',
            headers);
    setState(() {
      _isLoading = false;
    });

    if (apiResponse.error ?? false) {
      HelperMethods.showSnackBar(
          context, apiResponse.message!, _scaffoldKey, null);
      await Future.delayed(Duration(seconds: 1));
      if (apiResponse.message == StringConstant.sessionExpiredText) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        return;
      }
      return;
    }
    setState(() {
      _arrGroupData = apiResponse.data?.data;
    });
  }
}
