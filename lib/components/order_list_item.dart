import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:kds/screens/order_detail_screen.dart';
import 'package:kds/models/order_list_response_model.dart';

class OrderListItem extends StatefulWidget {
  final OrderListDatum order_item;
  final dynamic calUpdateStatusApi;
  final int numberOfColumns;

  const OrderListItem({
    super.key,
    required this.order_item,
    required this.calUpdateStatusApi,
    this.numberOfColumns = 2,
  });

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  @override
  Widget build(BuildContext context) {
    double sysWidth = MediaQuery.of(context).size.width;
    double sysHeight = MediaQuery.of(context).size.height;

    List<dynamic> lstCart =
        json.decode(this.widget.order_item.detail?.cart ?? '');

    return Container(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            OrderDetailScreen.routeName,
            arguments: this.widget.order_item.orderid,
          );
        },
        child: Container(
          width: sysWidth / this.widget.numberOfColumns - 30,
          height: (sysHeight - 300) / 2,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'ID: #${this.widget.order_item.orderid}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            child: Text(
                              this.widget.order_item.status.toString(),
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    this.widget.order_item.status == 'received'
                        ? ElevatedButton(
                            child: Text('Ready'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.all(0),
                            ),
                            onPressed: () => this.widget.calUpdateStatusApi(
                                this.widget.order_item.orderid!),
                          )
                        : Container()
                  ],
                ),
              ),
              Container(
                height: (sysHeight - 300) / 2 - 80,
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          'Customer Name: ${this.widget.order_item.username}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          'Restaurant Name: ${this.widget.order_item.resName}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          'Order Price: \$${this.widget.order_item.orderTotal}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          'Order Status: ${this.widget.order_item.status}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          'Date: ${DateFormat('dd-MM-yyyy').format(this.widget.order_item.createdAt!)}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          'Detail',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      ...lstCart
                          .asMap()
                          .map((key, value) => MapEntry(
                              key,
                              Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey),
                                            child:
                                                Text("${value["quantity"]}x")),
                                        SizedBox(width: 5),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("${value["itemName"]}"),
                                              Text("\$${value["itemPrice"]}")
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ))))
                          .values
                          .toList(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
