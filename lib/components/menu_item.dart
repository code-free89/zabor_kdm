import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kds/constants/color_constants.dart';
import 'package:kds/models/item_list_response_model.dart';

class MenuListItem extends StatefulWidget {
  final Menuitem menuItem;
  final int selectedResId;
  final dynamic updateMenuitem;

  const MenuListItem({
    super.key,
    required this.menuItem,
    required this.selectedResId,
    required this.updateMenuitem,
  });

  @override
  State<MenuListItem> createState() => _MenuListItemState();
}

class _MenuListItemState extends State<MenuListItem> {
  Menuitem get _menuItem => widget.menuItem;
  int get _selectedResId => widget.selectedResId;
  bool _isLoading = false;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  String imagePath = "";

  @override
  Widget build(BuildContext context) {
    double sysWidth = MediaQuery.of(context).size.width;
    final ImagePicker _imagePicker = ImagePicker();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_menuItem.itemName ?? ''),
            Divider(color: Colors.transparent),
            FormBuilder(
              key: _fbKey,
              initialValue: {
                'item_price': _menuItem.itemPrice.toString(),
                'item_quantity': _menuItem.itemQuantity == null
                    ? ''
                    : _menuItem.itemQuantity.toString(),
                'discount_type': _menuItem.discount_type ?? "FIXED",
                'discount_amount': _menuItem.discount_amount.toString(),
                'is_show': _menuItem.isShow == 1,
                'is_food': _menuItem.isFood == 1,
                'is_city': _menuItem.isCity == 1,
                'is_state': _menuItem.isState == 1,
                'printer_2': _menuItem.printer_2 == 1,
                'printer_3': _menuItem.printer_3 == 1,
                'printer_4': _menuItem.printer_4 == 1,
                'printer_5': _menuItem.printer_5 == 1,
                'printer_6': _menuItem.printer_6 == 1,
                'printer_7': _menuItem.printer_7 == 1,
              },
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: sysWidth / 3 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderTextField(
                            name: "item_price",
                            decoration: InputDecoration(
                              labelText: "Price",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Container(
                        width: sysWidth / 3 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderTextField(
                            maxLines: 1,
                            name: "item_quantity",
                            decoration: InputDecoration(
                              labelText: "Quantity",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Container(
                        width: sysWidth / 3 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: FormBuilderCheckbox(
                          name: "is_show",
                          title: Text('Show'),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.transparent),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: sysWidth / 3 - 16,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            imagePath != ""
                                ? Image.file(File(imagePath))
                                : Image.network(
                                    "https://api.zaboreats.com/${_menuItem.itemPic}",
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container();
                                    },
                                  ),
                            OutlinedButton(
                              onPressed: () async {
                                final image = await _imagePicker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image != null) {
                                  setState(() {
                                    imagePath = image.path;
                                  });
                                }
                              },
                              child: Text("Select Image"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: sysWidth / 3 - 16,
                        child: FormBuilderRadioGroup(
                          name: "discount_type",
                          options: const [
                            FormBuilderFieldOption(value: "PERCENTAGE"),
                            FormBuilderFieldOption(value: "FIXED"),
                          ],
                          activeColor: AppColor.yellowColor,
                          decoration: InputDecoration(
                            labelText: "Discount Type",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        width: sysWidth / 3 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderTextField(
                            name: "discount_amount",
                            decoration: InputDecoration(
                              labelText: "Discount Amount",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.transparent),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: sysWidth / 3 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderCheckbox(
                            name: "is_food",
                            title: Text('Food Tax'),
                          ),
                        ),
                      ),
                      Container(
                        width: sysWidth / 3 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderCheckbox(
                            name: "is_state",
                            title: Text('State Tax'),
                          ),
                        ),
                      ),
                      Container(
                        width: sysWidth / 3 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderCheckbox(
                            name: "is_city",
                            title: Text('City Tax'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.transparent),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: sysWidth / 6 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderCheckbox(
                            name: "printer_2",
                            title: Text('Printer #2 (Cashier)'),
                          ),
                        ),
                      ),
                      Container(
                        width: sysWidth / 6 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderCheckbox(
                            name: "printer_3",
                            title: Text('Printer #3 (Kitchen)'),
                          ),
                        ),
                      ),
                      Container(
                        width: sysWidth / 6 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderCheckbox(
                            name: "printer_4",
                            title: Text('Printer #4 (Admin)'),
                          ),
                        ),
                      ),
                      Container(
                        width: sysWidth / 6 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderCheckbox(
                            name: "printer_5",
                            title: Text('Printer #5 (Bluetooth)'),
                          ),
                        ),
                      ),
                      Container(
                        width: sysWidth / 6 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderCheckbox(
                            name: "printer_6",
                            title: Text('Printer #6 (Bluetooth)'),
                          ),
                        ),
                      ),
                      Container(
                        width: sysWidth / 6 - 16,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                        ),
                        child: ListTile(
                          title: FormBuilderCheckbox(
                            name: "printer_7",
                            title: Text('Printer #7 (Bluetooth)'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_fbKey.currentState!.saveAndValidate()) {
                        this.widget.updateMenuitem(
                              _fbKey.currentState!.value,
                              imagePath,
                            );
                      }
                    },
                    child: Text('Update'),
                  )
          ],
        ),
      ),
    );
  }
}
