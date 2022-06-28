import 'package:baby_shop/model/product_model.dart';
import 'package:baby_shop/product_details_page.dart';
import 'package:baby_shop/provider/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCartTo extends StatefulWidget {

  final ProductModel product;


  ProductCartTo(this.product);

  @override
  _ProductCartToState createState() => _ProductCartToState();
}

class _ProductCartToState extends State<ProductCartTo> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Consumer<CardProvider>(
            builder:(context,provider,_)=> Padding(
              padding:const EdgeInsets.only(left: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      primary: Colors.deepOrange,
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(180)
                      )
                  ),
                  onPressed: ()
                  {
                    provider.isInCard(widget.product.ProductId!)?
                    provider.removeFromCard(widget.product.ProductId!):
                    provider.addToCard(widget.product);
                  },
                  child:Text(provider.isInCard(widget.product.ProductId!)?'REMOVE':'ADD')),
            ),
          )
        ],
      ),
    );;
  }
}
