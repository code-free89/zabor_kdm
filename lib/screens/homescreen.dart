import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kds/constants/color_constants.dart';
import 'package:kds/helpers/app_utils.dart';
import 'package:kds/helpers/resBloc.dart';
import 'package:kds/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'loginscreen.dart';
import 'menu_tab.dart';
import 'orders_list_tab.dart';
import 'restaurant_list.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/homescreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  ResBloc? _resBloc;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    _resBloc = Provider.of<ResBloc>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainContext = context;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('HOME'),
        actions: <Widget>[
          IconButton(
              icon: FaIcon(FontAwesomeIcons.signOutAlt),
              onPressed: () {
                AppUtils.logout();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              })
        ],
        bottom: TabBar(
          unselectedLabelColor: AppColor.darkGreyColor,
          labelColor: AppColor.whiteColor,
          tabs: [
            new Tab(
              icon: FaIcon(FontAwesomeIcons.listAlt),
              text: 'Orders',
            ),
            new Tab(
              icon: FaIcon(FontAwesomeIcons.conciergeBell),
              text: 'My Restaurants',
            ),
            new Tab(
              icon: FaIcon(FontAwesomeIcons.utensils),
              text: 'Menu',
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: [
          OrdersTab(
            scaffoldKey: _scaffoldkey,
          ),
          MyRestaurantTab(
            scaffoldKey: _scaffoldkey,
          ),
          MenuTab(scaffoldKey: null,),
        ],
        controller: _tabController,
      ),
    );
  }
}
