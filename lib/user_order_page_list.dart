import 'package:baby_shop/order_details_page.dart';
import 'package:baby_shop/order_page.dart';
import 'package:baby_shop/provider/order_provider.dart';
import 'package:baby_shop/utlits/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {

  static const String routeName='/Order_List';

  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  late OrderProvider _orderProvider;

  @override
  void didChangeDependencies() {
   _orderProvider =Provider.of<OrderProvider>(context);
   _orderProvider.getAllOrderByUser();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('OrderList',style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: _orderProvider.userOrderList.length,
          itemBuilder: (context,index){
          final order =_orderProvider.userOrderList[index];
          return Card(
            elevation: 2,
            child: ListTile(
              onTap: ()=>Navigator.pushNamed(context, OrderDetailsPage.routeName,arguments: order.orderId),
              title: Text(order.deliveryAddress),
              trailing: Text(order.orderStatus),
            ),
          );
          }),
    );
  }
}
