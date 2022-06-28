import 'package:baby_shop/auth/auth_service.dart';
import 'package:baby_shop/model/order_model.dart';
import 'package:baby_shop/order_page.dart';
import 'package:baby_shop/provider/card_provider.dart';
import 'package:baby_shop/provider/order_provider.dart';
import 'package:baby_shop/utlits/constant.dart';
import 'package:baby_shop/view_product_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CheckPage extends StatefulWidget {
  static const String routeName = '/check_page';

  const CheckPage({Key? key}) : super(key: key);

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  late CardProvider _cardProvider;
  late OrderProvider _orderProvider;
  final String taka = '৳';
  String radioGroupValue = Payment.cod;
  final _addressController = TextEditingController();

  @override
  void didChangeDependencies() {
    _cardProvider = Provider.of<CardProvider>(context);
    _orderProvider = Provider.of<OrderProvider>(context);
    _orderProvider.getOrderConstants();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Padding(
                padding:const EdgeInsets.only(left: 20,right: 20),
                child: ListView(
            children: [
                const Center(
                    child: Text(
                  'YOUR ITEMS',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
                const SizedBox(height: 2),
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _cardProvider.cardList
                        .map((cardModel) => ListTile(
                              title: Text(cardModel.productName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                              trailing: Text('${cardModel.qty} * ${cardModel.price} ',style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  )),
                            ))
                        .toList()),
                const SizedBox(height: 20),
                const Text('ODER SUMMERY', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Divider(height: 1, color: Colors.black),
                const SizedBox(height: 10),
                Padding(
                  padding:const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Card Total',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('$taka ${_cardProvider.cardItemsTotalPrice}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery Charge',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                              '$taka ${_orderProvider.orderConstantModel.deliveryCharge}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Discount(${_orderProvider.orderConstantModel.discount}%)',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                              '$taka ${_orderProvider.getdiscountAmount(_cardProvider.cardItemsTotalPrice)}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Vat(${_orderProvider.orderConstantModel.vat}%)',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                              '$taka ${_orderProvider.getTotalVatAmmoun(_cardProvider.cardItemsTotalPrice)}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Amount',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Chip(
                              elevation: 5,
                              backgroundColor: Colors.deepOrange,
                              label: Text(
                                  '$taka ${_orderProvider.getGrandTotal(_cardProvider.cardItemsTotalPrice)}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))),
                        ],
                      ),
                      SizedBox(height: 10),
                      const Text('Set Delivery Address',
                          style:
                              TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                      const Divider(height: 1, color: Colors.black),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          controller: _addressController,
                          decoration: InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                      const Text('Select Payment Method',
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const Divider(height: 1, color: Colors.black),
                      Row(
                        children: [
                          Radio<String>(
                            value: Payment.cod,
                            groupValue: radioGroupValue,
                            onChanged: (value) {
                              setState(() {
                                radioGroupValue = value!;
                              });
                            },
                          ),
                          const Text(Payment.cod,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: Payment.online,
                            groupValue: radioGroupValue,
                            onChanged: (value) {
                              setState(() {
                                radioGroupValue = value!;
                              });
                            },
                          ),
                          const Text(Payment.online,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                )
            ],
          ),
              )),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.grey;
                }
                return Colors.deepOrange;
              }), textStyle: MaterialStateProperty.resolveWith((states) {
                // If the button is pressed, return size 40, otherwise 20
                if (states.contains(MaterialState.pressed)) {
                  return  TextStyle(fontSize: 40,color: Colors.green);
                }
                return TextStyle(fontSize: 20);
              })),
              onPressed: _saveOrder,
              child: const Text(
                'PLACE ORDER',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _saveOrder() {
    if(_addressController.text.isEmpty){
      Fluttertoast.showToast(msg: 'Please provide a delivery address',gravity: ToastGravity.CENTER);
      return;
    }
    final orderModel =OrderModel(
        timestamp: Timestamp.now(),
        UserId: AuthService.currentUser!.uid,
        grandTotal: _orderProvider.getGrandTotal(_cardProvider.cardItemsTotalPrice),
        discount: _orderProvider.orderConstantModel.discount,
        deliveryCharge: _orderProvider.orderConstantModel.deliveryCharge,
        vat: _orderProvider.orderConstantModel.vat,
        orderStatus: OrderStatus.pending,
        paymentMethod: radioGroupValue,
        deliveryAddress: _addressController.text
    );
    _orderProvider.saveOrder(orderModel, _cardProvider.cardList).then((value) async{
    await _cardProvider.clearCardItem();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OrderPage()),ModalRoute.withName(ViewProduct.routeName));

    });
  }
}
