import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:kds/models/order_list_response_model.dart';
import 'package:kds/screens/order_detail_screen.dart';

class OrderListItemMobile extends StatelessWidget {
  final OrderListDatum order_item;
  final dynamic calUpdateStatusApi;

  const OrderListItemMobile({super.key, required this.order_item, required this.calUpdateStatusApi});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, OrderDetailScreen.routeName,
              arguments: order_item.orderid);
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Order ID: #${order_item.orderid}'),
                    Text('Customer Name: ${order_item.username}'),
                    Text('Restaurant Name: ${order_item.resName}'),
                    Text('Order Price: \$${order_item.orderTotal}'),
                    Text('Order Status: ${order_item.status}'),
                    Text(
                      'Date: ${DateFormat('dd-MM-yyyy').format(order_item.createdAt!)}',
                    )
                  ],
                ),
              ),
              order_item.status == 'received'
                  ? ElevatedButton(
                      child: Text('Ready'),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () => calUpdateStatusApi(order_item.orderid!),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
