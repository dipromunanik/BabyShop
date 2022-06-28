import 'package:baby_shop/view_product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  static const String routeName = '/order_page';

  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text('OrderPage',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        body: Padding(
          padding:const EdgeInsets.only(top: 10,left: 10,right: 10),
          child: Center(
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('Order successfully complete',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, ViewProduct.routeName);
                      },
                      child:const Text(
                        'Continue to Shopping',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
