import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kds/constants/color_constants.dart';
import 'package:kds/models/item_list_response_model.dart';

class NewMenuItem extends StatefulWidget {
  final Menuitem menuItem;
  final GlobalKey<FormBuilderState> fbKey;

  const NewMenuItem({
    super.key,
    required this.menuItem,
    required this.fbKey,
  });

  @override
  State<NewMenuItem> createState() => _NewMenuItemState();
}

class _NewMenuItemState extends State<NewMenuItem> {
  Menuitem get _menuItem => widget.menuItem;
  GlobalKey<FormBuilderState> get _fbKey => widget.fbKey;

  @override
  Widget build(BuildContext context) {
    double sysWidth = MediaQuery.of(context).size.width;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _fbKey,
          initialValue: {
            'name': _menuItem.itemName ?? '',
            'price': _menuItem.itemPrice == null
                ? ''
                : _menuItem.itemPrice.toString(),
            'quantity': _menuItem.itemQuantity == null
                ? ''
                : _menuItem.itemQuantity.toString(),
            'is_show': _menuItem.isShow == 1
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: AppColor.yellowColor,
                ),
                child: ListTile(
                  title: FormBuilderTextField(
                    name: "item_name",
                    decoration: InputDecoration(
                      labelText: "Item Name",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(),
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Divider(color: Colors.transparent),
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
                        // validators: [FormBuilderValidators.numeric()],
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
                        name: "is_show",
                        title: Text('Show'),
                        initialValue: false,
                      ),
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
                    child: FormBuilderRadioGroup(
                      name: "discount_type",
                      options: const [
                        FormBuilderFieldOption(value: "PERCENTAGE"),
                        FormBuilderFieldOption(value: "FIXED"),
                      ],
                      initialValue: "PERCENTAGE",
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
                        initialValue: false,
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
                        initialValue: false,
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
                        initialValue: false,
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
                        initialValue: false,
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
                        initialValue: false,
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
                        initialValue: false,
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
                        initialValue: false,
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
                        initialValue: false,
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
                        initialValue: false,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
