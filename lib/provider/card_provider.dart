import 'package:baby_shop/auth/auth_service.dart';
import 'package:baby_shop/db/db_helper.dart';
import 'package:baby_shop/model/card_model.dart';
import 'package:baby_shop/model/order_constant_value.dart';
import 'package:baby_shop/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class CardProvider with ChangeNotifier{
  List<CardModel> cardList =[];

  void getAllCardItems(){
    DbHelper.getAllCardItems(AuthService.currentUser!.uid).listen((event) {
      cardList =List.generate(event.docs.length, (index) => CardModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  void addToCard(ProductModel productModel){
    final cardModel = CardModel(
        productId: productModel.ProductId!,
        productName: productModel.ProductName,
        price: productModel.SaleProduct
    );
    DbHelper.addProductToCard(AuthService.currentUser!.uid,cardModel);
  }
  void removeFromCard(String id){
    DbHelper.deleteCardItem(AuthService.currentUser!.uid,id);
  }

  Future<void> clearCardItem(){
    return DbHelper.deleteCardItems(AuthService.currentUser!.uid, cardList);
  }

  bool isInCard(String id){
    bool tag =false;
    for(var model in cardList){
      if(model.productId==id){
        tag =true;
        break;
      }
    };
    return tag;
  }



  num get cardItemsTotalPrice{
    num total =0;
    cardList.forEach((element) {
      total +=element.price * element.qty;
    });
    return total;
  }
  void increaseQty(CardModel cardModel){
    cardModel.qty +=1;
    notifyListeners();
    print(cardModel.qty);
  }
  void decreaseQty(CardModel cardModel)
  {
    if(cardModel.qty>1){
      cardModel.qty -=1;
      notifyListeners();
      print(cardModel.qty);
    }
  }
  int get totalItemsInCards =>cardList.length;

  Future<void> updateQty(){
    return DbHelper.updateCardQty(AuthService.currentUser!.uid,cardList);
  }
}