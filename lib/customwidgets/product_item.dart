import 'package:baby_shop/model/card_model.dart';
import 'package:baby_shop/model/product_model.dart';
import 'package:baby_shop/product_details_page.dart';
import 'package:baby_shop/provider/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {

  final ProductModel product;


  ProductItem(this.product);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
      onTap: ()=>Navigator.pushNamed(context, ProductDetails.routeName,arguments: widget.product.ProductId),
      child: Padding(
        padding:const EdgeInsets.only(top: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          elevation: 7,
          child: Column(
            children: [
              widget.product.ImageUrl ==null?
                  Expanded(child: Image.asset('images/imagenot.jpg',fit: BoxFit.cover,))
                  :
                  Expanded(child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'image/imagenot.jpg',
                      image: widget.product.ImageUrl!,
                      width: double.infinity,
                      height: double.infinity,
                      fadeInCurve: Curves.bounceInOut,
                      fadeInDuration:const Duration(seconds: 5),
                      fit: BoxFit.cover,
                    ),
                  )
                  ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Text(widget.product.ProductName,style: const TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5),
                    Padding(
                      padding:const EdgeInsets.only(left: 5,right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('TK: ${widget.product.SaleProduct}',style: const TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                          const SizedBox(height: 5),
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
