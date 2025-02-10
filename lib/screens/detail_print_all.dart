// import 'package:flutter/material.dart';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:kds/models/order_detail_response_model.dart';
// import 'package:kds/screens/order_detail_screen.dart';
// import 'dart:convert';
//
// class DetailPrintAll extends StatefulWidget {
//
//   OrderDetailData orderDetailData;
//
//   DetailPrintAll({this.orderDetailData});
//
//   @override
//   _DetailPrintAllState createState() => _DetailPrintAllState();
// }
//
// class _DetailPrintAllState extends State<DetailPrintAll> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCartData();
//   }
//   OrderDetailData _orderDetailData;
//   List<Cart> _arrCart = [];
//
//   getCartData(){
//     _orderDetailData = widget.orderDetailData;
//     final cart = json.decode(_orderDetailData.cart);
//     _arrCart = [];
//     // for (int j = 0; j < _orderDetailData.cart.length; j++) {
//     for (int j = 0; j < cart.length; j++) {
//       _arrCart.add(cartModelfromJson(cart[j]));
//     }
//   }
//
//   cartModelfromJson(Map<String, dynamic> json) => Cart(
//     itemId: json["itemId"] == null ? null : json["itemId"],
//     itemName: json["itemName"] == null ? null : json["itemName"],
//     itemPrice:
//     json["itemPrice"] == null ? null : json["itemPrice"].toDouble(),
//     customization: json["customization"] == null
//         ? null
//         : List<CartCustomization>.from(json["customization"]
//         .map((x) => CartCustomization.fromJson(x))),
//     quantity: json["quantity"] == null ? null : json["quantity"],
//     taxtype: json["taxtype"] == null ? null : json["taxtype"],
//     taxvalue: json["taxvalue"] == null ? null : json["taxvalue"].toDouble(),
//     note: json["note"] == null ? null : json["note"],
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     print(["cart.lrnght:",_arrCart.length]);
//     return Scaffold(
//       appBar: AppBar(title: Text("Detail Print")),
//       body: PdfPreview(
//         build: (format) => _generatePdf(format, "Detail Print"),
//       ),
//     );
//   }
//
//   Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
//     final pdf = pw.Document();
//     final font = await rootBundle.load("assets/fonts/OpenSans.ttf");
//     var ttf = pw.Font.ttf(font);
//
//     pw.TextStyle pwBlack22 = pw.TextStyle(font: ttf,fontSize: 22,color: PdfColor.fromHex("#000000"));
//     pw.TextStyle pwBlack20 = pw.TextStyle(font: ttf,fontSize: 20,color: PdfColor.fromHex("#000000"));
//     pw.TextStyle pwBlack16_900 = pw.TextStyle(font: ttf,fontSize: 19,color: PdfColor.fromHex("#000000"));
//     pw.TextStyle pwBlack16 = pw.TextStyle(font: ttf,fontSize: 16,color: PdfColor.fromHex("#000000"));
//     pw.TextStyle pwBlack15 = pw.TextStyle(font: ttf,fontSize: 15,color: PdfColor.fromHex("#000000"));
//     pw.TextStyle pwWhite20 = pw.TextStyle(font: ttf,fontSize: 20,color: PdfColor.fromHex("#ffffff"));
//
//     pdf.addPage(
//       pw.MultiPage(
//         build: (context)=>[
//          pw.Container(
//             padding: pw.EdgeInsets.all(10.0),
//             child: pw.Column(
//               children: [
//                 pw.Container(
//                   alignment: pw.Alignment.center,
//                   padding: pw.EdgeInsets.only(top: 10,bottom: 10),
//                   child: pw.Text("ORDER #${_orderDetailData.orderId}",style: pwBlack22),
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Container(
//                   width: double.infinity,
//                   padding: pw.EdgeInsets.all(5.0),
//                   decoration: pw.BoxDecoration(
//                     border:pw.Border.all(color: PdfColor.fromHex('#000000'))
//                   ),
//                   child: pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text("BILLING ADDRESS",style: pwBlack22),
//                       pw.SizedBox(height: 5),
//                       pw.Text("First Name:${_orderDetailData.firstname.toString()}",style: pwBlack16),
//                       pw.SizedBox(height: 2),
//                       pw.Text("Last Name:${_orderDetailData.lastname.toString()}",style: pwBlack16),
//                       pw.SizedBox(height: 2),
//                       pw.Text("Email:${_orderDetailData.email}",style: pwBlack16),
//                       pw.SizedBox(height: 2),
//                       pw.Text("Phone:${_orderDetailData.phone}",style: pwBlack16),
//                       pw.SizedBox(height: 2),
//                       pw.Text("Address:${_orderDetailData.address}",style: pwBlack16),
//                       pw.SizedBox(height: 2),
//                       pw.Text("City:${_orderDetailData.city}",style: pwBlack16),
//                     ]
//                   )
//                 ),
//                 pw.SizedBox(height: 10),
//                 pw.Container(
//                     width: double.infinity,
//                     padding: pw.EdgeInsets.all(5.0),
//                     decoration: pw.BoxDecoration(
//                         border:pw.Border.all(color: PdfColor.fromHex('#000000'))
//                     ),
//                     child: pw.Column(
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Text("PAYMENT STATUS",style: pwBlack22),
//                           pw.SizedBox(height: 5),
//                           pw.Text(_orderDetailData.paymentStatus == 0?
//                           "Payment is remaining for this order.":"Payment is received.",style: pwBlack16),
//                           pw.SizedBox(height: 5),
//                           pw.Text("PAYMENT MODE",style: pwBlack22),
//                           pw.SizedBox(height: 5),
//                           pw.Text(_orderDetailData.paymentMode != 2?"Online":"Pay on delivery",style: pwBlack16),
//                           pw.SizedBox(height: 5),
//                           pw.Text("DELIVERY MODE",style: pwBlack22),
//                           pw.SizedBox(height: 5),
//                           pw.Text(_orderDetailData.deliveryMode == 1?"Home Delivery":"Pick up",style: pwBlack16),
//                           pw.SizedBox(height: 5),
//                         ]
//                     )
//                 ),
//                 pw.SizedBox(height: 20),
//               ],
//             )
//           ),
//           pw.Container(
//               padding: pw.EdgeInsets.all(10.0),
//               child: pw.Column(
//                 children: [
//                   pw.Container(
//                     alignment: pw.Alignment.center,
//                     padding: pw.EdgeInsets.only(top: 10,bottom: 10),
//                     child: pw.Text("ORDER DETAIL",style: pwBlack22),
//                   ),
//                   ..._arrCart.asMap().map((key, value)
//                   {
//                     print(["value:",value.toJson()]);
//                     return MapEntry(
//                         key,
//                         pw.Container(
//                             padding: pw.EdgeInsets.only(bottom: 10),
//                             child: pw.Row(children: [
//                               pw.SizedBox(
//                                   width: 60,
//                                   child: pw.Container(
//                                       height: 60,
//                                       width: 60,
//                                       decoration: pw.BoxDecoration(
//                                           borderRadiusEx:
//                                           pw.BorderRadius.circular(5),
//                                           boxShadow: [
//                                             pw.BoxShadow(
//                                               color: PdfColor.fromHex(
//                                                   '#d9e6f2'),
//                                               blurRadius:
//                                               25.0, // soften the shadow
//                                               spreadRadius:
//                                               5.0, //extend the shadow
//                                             ),
//                                           ],
//                                           color:
//                                           PdfColor.fromHex('#2eb82e')),
//                                       alignment: pw.Alignment.center,
//                                       child:
//                                       pw.Text("1x", style: pwWhite20))),
//                               pw.SizedBox(width: 20),
//                               pw.SizedBox(
//                                   child: pw.Container(
//                                       child: pw.Column(
//                                         crossAxisAlignment:
//                                         pw.CrossAxisAlignment.start,
//                                         children: [
//                                           pw.Text(value.itemName, style: pwBlack20),
//                                           pw.Text("\$ ${value.itemPrice}", style: pwBlack15),
//                                           ...value.customization.asMap().map((key, value01) => MapEntry(key, pw.Text("+ ${value01.optionName}",
//                                               style: pwBlack15),)).values.toList()
//                                         ],
//                                       ))),
//                             ])));
//                   }).values.toList(),
//                   pw.SizedBox(height: 10),
//                   pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text("Total",style: pwBlack16_900),
//                         pw.Text("\$${_orderDetailData.total}",style: pwBlack16_900)
//                       ]
//                   ),
//                   pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text("+Food",style: pwBlack15),
//                         pw.Text("\$${_orderDetailData.foodTax}",style: pwBlack15)
//                       ]
//                   ),
//                   pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text("+Drink Tax",style: pwBlack15),
//                         pw.Text("\$${_orderDetailData.drinkTax}",style: pwBlack15)
//                       ]
//                   ),
//                   pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text("+Grand Tax",style: pwBlack15),
//                         pw.Text("\$${_orderDetailData.tax}",style: pwBlack15)
//                       ]
//                   ),
//                   pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text("+Delivery Charge",style: pwBlack15),
//                         pw.Text("\$${_orderDetailData.deliveryCharge}",style: pwBlack15)
//                       ]
//                   ),
//                   pw.SizedBox(height: 20),
//                   pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text("Payable Amount",style: pwBlack16),
//                         pw.Text("\$${_orderDetailData.total}",style: pwBlack16)
//                       ]
//                   ),
//                   pw.SizedBox(height: 20),
//                 ],
//               )
//           )
//         ]
//       ),
//     );
//
//     return pdf.save();
//   }
// }
