import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kds/screens/homescreen.dart';
import 'package:kds/screens/item_list_screen.dart';
import 'package:kds/screens/loginscreen.dart';
import 'package:kds/screens/order_detail_screen.dart';
import 'package:kds/screens/splash_screen.dart';

import 'constants/color_constants.dart';
import 'package:provider/provider.dart';
import 'package:kds/helpers/resBloc.dart';

import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ResBloc>(
          create: (context) => ResBloc(), lazy: false),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: AppColor.goldColor,
          // backgroundColor: AppColor.goldColor,
          scaffoldBackgroundColor: AppColor.goldColor,
          appBarTheme: AppBarTheme(color: AppColor.goldColor)),
      home: SplashScreen(),
      onGenerateRoute: routes,
    );
  }

  Route routes(RouteSettings settings) {
    var page;
    String routeName = settings.name!;
    switch (routeName) {
      case LoginScreen.routeName:
        page = LoginScreen();
        break;
      case HomeScreen.routeName:
        page = HomeScreen();
        break;
      case OrderDetailScreen.routeName:
        page = OrderDetailScreen(
          orderId: settings.arguments as int,
        );
        break;
      // case PrinterScreen.routeName:
      // page = PrinterScreen();
      // break;
      case ItemListScreen.routeName:
        page = ItemListScreen(
          groupID: settings.arguments as int,
        );
        break;
    }
    return CupertinoPageRoute(builder: (context) => page);
  }
}
