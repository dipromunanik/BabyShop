import 'package:baby_shop/card_page.dart';
import 'package:baby_shop/customwidgets/main_drawer.dart';
import 'package:baby_shop/customwidgets/product_item.dart';
import 'package:baby_shop/product_details_page.dart';
import 'package:baby_shop/provider/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/product_provider.dart';

class ViewProduct extends StatefulWidget {
  static const String routeName ='/view_product';
  const ViewProduct({Key? key}) : super(key: key);

  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {

  late ProductProvider _productProvider;
  late CardProvider _cardProvider;
  bool _isInit = true;

  @override
  void didChangeDependencies() {

    if(_isInit){
      _productProvider = Provider.of<ProductProvider>(context);
      _cardProvider = Provider.of<CardProvider>(context);
      _cardProvider.getAllCardItems();
      _productProvider.getAllProducts();
      _isInit =false;
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text('ViewProduct',style: TextStyle(color: Colors.black),),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.share,color: Colors.black,size: 23,)),
            IconButton(onPressed: (){
              Navigator.pushNamed(context, CardPage.routeName);
            }, icon: const Icon(Icons.shopping_cart,color: Colors.black,size: 23,)),
          ],
        ),
        body: GridView.count(
            crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 0.8,
          children: _productProvider.productList.map((product) => ProductItem(product)).toList()
        )
      ),
    );
  }
}
