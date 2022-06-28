

import 'package:baby_shop/auth/auth_service.dart';
import 'package:baby_shop/db/db_helper.dart';
import 'package:baby_shop/model/card_model.dart';
import 'package:baby_shop/model/order_constant_value.dart';
import 'package:baby_shop/model/order_model.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier{
  OrderConstantModel orderConstantModel = OrderConstantModel();

  List<OrderModel> userOrderList =[];
  List<CardModel> orderDetailsList=[];

  void getOrderConstants() async{

    DbHelper.getOrderConstants().listen((event) {
      if(event.exists){
        orderConstantModel = OrderConstantModel.fromMap(event.data()!);
        notifyListeners();
      }
    });
  }

  void getFormattedDate(){



  }
  void getOrderDetails(String orderId) async{
DbHelper.getOrderByOrderId(orderId).listen((event) {

});
  }
  void getOrderDetailsProductList(String orderId) async{
    DbHelper.getOrderDetails(orderId).listen((event) {
      orderDetailsList =List.generate(event.docs.length, (index) => CardModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  void getAllOrderByUser() async{

    DbHelper.getAllOrderByUser(AuthService.currentUser!.uid).listen((event) {
       userOrderList =List.generate(event.docs.length, (index) => OrderModel.fromMap(event.docs[index].data()));
       notifyListeners();
    });
  }


  Future<void> saveOrder(OrderModel orderModel,List<CardModel> cardModel){
    return DbHelper.saveOrder(orderModel, cardModel);
  }

  num getdiscountAmount(num total){
    return ((total * orderConstantModel.discount)/100).round();
  }
  num getTotalVatAmmoun(num total){
    return ((total * orderConstantModel.vat)/100).round();
  }
  num getGrandTotal(num total){
    return (total + orderConstantModel.deliveryCharge + getTotalVatAmmoun(total)) - getdiscountAmount(total);
  }
}