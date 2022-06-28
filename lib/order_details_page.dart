import 'package:baby_shop/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatefulWidget {
  static const String routeName='/OrderDetailsPage';

  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  String? orderId;
  late OrderProvider _orderProvider;

  @override
  void didChangeDependencies() {
    orderId =ModalRoute.of(context)!.settings.arguments as String;
    _orderProvider =Provider.of<OrderProvider>(context);
    _orderProvider.getOrderDetailsProductList(orderId!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
            title: Text('Details',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black))),
      body: ListView.builder(
        itemCount: _orderProvider.orderDetailsList.length,
          itemBuilder:(context, index) {
          final details =_orderProvider.orderDetailsList[index];
          return Card(
            elevation: 2,
            child: ListTile(
              title: Text('Product Name = ${details.productName}'),
            ),
          );
          })
    );
  }
}
