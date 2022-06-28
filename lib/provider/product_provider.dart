import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../model/product_model.dart';
import '../model/purchase_model.dart';

class ProductProvider with ChangeNotifier{

  List<String> categoryList=[];
  List<ProductModel> productList=[];
  List<PurchaseModel> purchaseList=[];
  ProductModel? productModel;

  void getAllProducts(){
    DbHelper.getAllProducts().listen((event) {
      productList =List.generate(event.docs.length, (index) => ProductModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  void getProductByProductId(String productId){
    DbHelper.getProductByProductId(productId).listen((event) {
      if(event.exists){
        productModel =ProductModel.fromMap(event.data()!);
        notifyListeners();
      }
    });
  }

  void getAllCategories(){
    DbHelper.getAllCategories().listen((event) {
      categoryList =List.generate(event.docs.length, (index) => event.docs[index].data()['name']);
      notifyListeners();
    });
  }


}