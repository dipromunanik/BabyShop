import 'dart:io';

import 'package:baby_shop/customwidgets/product_details_cart.dart';
import 'package:baby_shop/model/product_model.dart';
import 'package:baby_shop/provider/card_provider.dart';
import 'package:baby_shop/provider/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'customwidgets/product_item.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = '/product_details';

  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? productId;
  late ProductProvider _productProvider;
  var imageSource = ImageSource.camera;
  late CardProvider _cardProvider;

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    productId = ModalRoute.of(context)!.settings.arguments as String;
    _productProvider.getProductByProductId(productId!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title:const Text('ProductDetails',style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share,size: 25,color: Colors.black,))
        ],
      ),
      body: Center(
        child: _productProvider.productModel == null
            ? CircularProgressIndicator()
            : ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  Card(
                      elevation: 5,
                      child: _productProvider.productModel!.ImageUrl == null
                          ? Image.asset('images/imagenot.jpg',
                              width: double.maxFinite, height: 250)
                          : FadeInImage.assetNetwork(
                              fadeOutCurve: Curves.bounceInOut,
                              fadeInDuration: const Duration(seconds: 5),
                              placeholder: 'images/imagenot.jpg',
                              image: _productProvider.productModel!.ImageUrl!,
                              height: 250,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                            )),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text('${_productProvider.productModel!.ProductName}',
                        style: TextStyle(color: Colors.black,fontSize: 20),),
                      subtitle: Text('Category: ${_productProvider.productModel!.Category}',
                        style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                          'Sale Price: ${_productProvider.productModel!.SaleProduct}',style: TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold
                      ),),
                      trailing:
                          TextButton(onPressed: () {}, child: Text('CHANGE',
                          style: TextStyle(color: Colors.deepOrange),
                          )),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(
                        'Product Description: ${_productProvider.productModel!.ProductDescription}',style: TextStyle(
                          fontSize: 18
                      ),),
                    ),
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding:const EdgeInsets.only(left: 5),
                    child: InkWell(
                      onTap: (){
                      },
                      child: Container(
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 9,
                              color: Colors.grey,
                              spreadRadius: 1
                          ),
                        ],
                        gradient: LinearGradient(colors: [Colors.pinkAccent,Colors.lightBlueAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight
                        ),
                      ),
                      child:Align(
                        alignment: Alignment.center,
                          child: Text('Add to Cart',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                      ),
                    ),
                  ),
                 Column(
                   children:[

                   ]
                 )
                ],
              ),
      ),
    );
  }
}
