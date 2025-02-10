import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kds/constants/api_constants.dart';
import 'package:kds/constants/color_constants.dart';
import 'package:kds/helpers/app_utils.dart';
import 'package:kds/helpers/helper_methods.dart';
import 'package:kds/helpers/k3webservice.dart';
import 'package:kds/helpers/resBloc.dart';
import 'package:kds/models/login_response_model.dart';
import 'package:kds/screens/homescreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/loginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ResBloc? _resBloc;

  @override
  Widget build(BuildContext context) {
    _resBloc = Provider.of<ResBloc>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
              ),
              Text(
                'KDM',
                style: TextStyle(fontSize: 50),
              ),
              Text(
                'WELCOME',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 40,
              ),
              getForm(),
              SizedBox(
                height: 20,
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : TextButton(
                      onPressed: () {
                        if (_fbKey.currentState!.saveAndValidate()) {
                          callLoginApi(_fbKey.currentState!.value);
                        }
                      },
                      child: Text('Login'),
                      // shape: StadiumBorder(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilder(
        key: _fbKey,
        child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: AppColor.yellowColor,
                borderRadius: BorderRadius.circular(30)),
            child: ListTile(
              title: FormBuilderTextField(
                name: "email",
                decoration: InputDecoration(
                    labelText: "Email", border: InputBorder.none),
                style: TextStyle(),
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                // validators: [
                //   FormBuilderValidators.email(),
                // ],
              ),
            ),
          ),
          Divider(),
          Container(
            decoration: BoxDecoration(
                color: AppColor.yellowColor,
                borderRadius: BorderRadius.circular(30)),
            child: ListTile(
              title: FormBuilderTextField(
                obscureText: true,
                maxLines: 1,
                name: "password",
                decoration: InputDecoration(
                    labelText: "Password", border: InputBorder.none),
                style: TextStyle(),
                // validators: [FormBuilderValidators.required()],
              ),
            ),
          ),
          Divider(),
          Container(
            decoration: BoxDecoration(
                color: AppColor.yellowColor,
                borderRadius: BorderRadius.circular(30)),
            child: ListTile(
              title: TextField(
                obscureText: true,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "Restaurant id",
                  border: InputBorder.none,
                  hintText: "Restaurant id",
                ),
                style: TextStyle(),
                keyboardType: TextInputType.number,
                onChanged: ((value) {
                  _resBloc?.selectRes = int.parse(value);
                }),
                // validators: [FormBuilderValidators.required()],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void callLoginApi(Map<String, dynamic> value) async {
    Map<String, dynamic> nonConstValue = Map.of(value);
    setState(() {
      _isLoading = true;
    });
    String? deviceToken = await AppUtils.getDeviceToken();
    nonConstValue['device_token'] = deviceToken;
    // nonConstValue["resId"] = _resBloc.selectRes.toString();
    ApiResponse<LoginRepsonseModel> apiResponse =
        await K3Webservice.postMethod(Apis.login, nonConstValue, null, null);
    setState(() {
      _isLoading = false;
    });

    if (apiResponse.error ?? false) {
      HelperMethods.showSnackBar(
          context, apiResponse.message ?? '', _scaffoldKey, null);
      return;
    }

    await Future.delayed(Duration(seconds: 1));
    User? _user = apiResponse.data?.data?.user;
    _user?.resId = apiResponse.data?.data?.resId;
    AppUtils.saveUser(_user!);
    AppUtils.saveToken(apiResponse.data!.data!.token!);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
