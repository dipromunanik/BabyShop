import 'package:baby_shop/auth/auth_service.dart';
import 'package:baby_shop/check_page.dart';
import 'package:baby_shop/customwidgets/custom_button_small.dart';
import 'package:baby_shop/provider/card_provider.dart';
import 'package:baby_shop/view_product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardPage extends StatefulWidget {
  static const String routeName = '/card_page';

  const CardPage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  late CardProvider _cardProvider;

  @override
  void didChangeDependencies() {
    _cardProvider = Provider.of<CardProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title:const Text('CardPage',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          actions: [
           IconButton(onPressed: (){
             _cardProvider.clearCardItem();
           }, icon: const Icon(Icons.delete,color: Colors.black,size: 30))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: _cardProvider.cardList.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Image.asset('images/dustbin.png'),
                            const SizedBox(height: 10),
                            const Text(
                              'Your Cart is Empty!',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Looks like you haven't made order yet",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, ViewProduct.routeName);
                                },
                                child: Text(
                                  'Continue to Shopping',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ))
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _cardProvider.cardList.length,
                        itemBuilder: (context, index) {
                          final model = _cardProvider.cardList[index];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(model.productName),
                              subtitle: Text('${model.price}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SmallButton(
                                    onTap: () {
                                      _cardProvider.decreaseQty(model);
                                    },
                                    icon: Icons.remove,
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text('${model.qty}',
                                          style: TextStyle(fontSize: 20))),
                                  SmallButton(
                                    onTap: () {
                                      _cardProvider.increaseQty(model);
                                    },
                                    icon: Icons.add,
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: ${_cardProvider.cardItemsTotalPrice}',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    TextButton(
                        onPressed: _cardProvider.totalItemsInCards == 0
                            ? null
                            : () {
                                _cardProvider.updateQty().then((value) =>
                                    Navigator.pushNamed(
                                        context, CheckPage.routeName));
                                /*if(!AuthService.isUserVerified()){
                      showEmailVerificationAleart();
                    }else{

                    }*/
                              },
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
                        ))
                  ],
                ),
              ),
            )
          ],
        ));
  }

  void showEmailVerificationAleart() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Unverified!'),
              content: Text(
                  'Your email is not varified yet. Please click send button then below to recive a verification mail'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('CLOSE')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      AuthService.sendVerificationMail()
                          .then((value) => {print('Mail Send')})
                          .catchError((e) {
                        throw e;
                      });
                    },
                    child: Text('SEND'))
              ],
            ));
  }
}
