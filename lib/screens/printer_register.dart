import 'package:flutter/material.dart';
import 'package:kds/helpers/app_utils.dart';
import 'dart:convert';
import 'package:regexed_validator/regexed_validator.dart';

class PrinterRegister extends StatefulWidget {
  @override
  _PrinterRegisterState createState() => _PrinterRegisterState();
}

class _PrinterRegisterState extends State<PrinterRegister> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _ctrlCash = TextEditingController();
  TextEditingController _ctrlKitchen = TextEditingController();
  TextEditingController _ctrlAdmin = TextEditingController();

  double sysWidth = 0.0;
  double sysHeight = 0.0;

  AppUtils _appUtils = AppUtils();

  getPrinters() async {
    List<String>? strPrinters = await AppUtils.getPrinters();
    print(["strPrinters:", strPrinters]);

    if (strPrinters == null) return;

    _ctrlCash.text = strPrinters[0];
    _ctrlKitchen.text = strPrinters[1];
    _ctrlAdmin.text = strPrinters[2];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrinters();
  }

  @override
  Widget build(BuildContext context) {
    sysWidth = MediaQuery.of(context).size.width;
    sysHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Printer Register",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: (sysWidth - 20) / 2,
                        child: Text("Name", style: TextStyle(fontSize: 25))),
                    Container(
                        width: (sysWidth - 20) / 2,
                        child: Text("IP", style: TextStyle(fontSize: 25)))
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: 100,
                          child: Text(
                            "Cashier Printer",
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                          width: sysWidth - 30 - 100,
                          child: TextFormField(
                            controller: _ctrlCash,
                            validator: (value) {
                              if (validator.ip(value ?? '') || (value?.isEmpty ?? true))
                                return null;
                              else
                                return 'IPAddress Style Error';
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: 100,
                          child: Text(
                            "Kitchen Printer",
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                          width: sysWidth - 30 - 100,
                          child: TextFormField(
                            controller: _ctrlKitchen,
                            validator: (value) {
                              if (validator.ip(value ?? '') || (value?.isEmpty ?? true))
                                return null;
                              else
                                return 'IPAddress Style Error';
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: 100,
                          child: Text(
                            "Admin Printer",
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                          width: sysWidth - 30 - 100,
                          child: TextFormField(
                            controller: _ctrlAdmin,
                            validator: (value) {
                              if (validator.ip(value ?? '') || (value?.isEmpty ?? true))
                                return null;
                              else
                                return 'IPAddress Style Error';
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2.0),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    print(_ctrlCash.text);
                    if (_formKey.currentState!.validate()) {
                      var result;
                      if (_ctrlCash.text == "" &&
                          _ctrlKitchen.text == "" &&
                          _ctrlAdmin.text == "")
                        return;
                      else
                        result = [
                          _ctrlCash.text,
                          _ctrlKitchen.text,
                          _ctrlAdmin.text
                        ];
                      AppUtils.setPrinters(result);
                      return showPrintAlert();
                    }
                  },
                  // padding: EdgeInsets.fromLTRB(30,10,30,10),
                  // color: Colors.green,
                  child: Text("Save",
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showPrintAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Printer was registered successfully'),
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
}
