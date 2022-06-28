import 'package:baby_shop/model/card_model.dart';
import 'package:baby_shop/model/product_model.dart';
import 'package:baby_shop/model/purchase_model.dart';
import 'package:baby_shop/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/order_model.dart';


class DbHelper{
  static const String _collectionCategories ='Categories';
  static const String _collectionUsers ='Users';
  static const String _collectionOrders ='Orders';
  static const String _collectionOrderDetails ='OrderDetails';
  static const String _collectionCardItems='CardItems';
  static const String _collectionOrderConstant ='OrderConstants';
  static const String _documentsConstant ='Constant';
  static const String _collectionProducts ='Products';
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addNewUser(UserModel userModel) {
    final doc =_firestore.collection(_collectionUsers).doc(userModel.Uid);
    return doc.set(userModel.toMap());
  }
  static Future<void> addProductToCard(String uid,CardModel cardModel) {
    final doc = _firestore.collection(_collectionUsers).doc(uid)
        .collection(_collectionCardItems).doc(cardModel.productId);
    return doc.set(cardModel.toMap());
  }

  static Future<void> updateCardQty(String uid,List<CardModel> cardModel){
    final writeBatch = _firestore.batch();
    cardModel.forEach((element) {
      final doc = _firestore.collection(_collectionUsers).doc(uid).collection(_collectionCardItems).doc(element.productId);
      writeBatch.update(doc, {'qty' :element.qty});
    });
    return writeBatch.commit();
  }

  static Future<void> saveOrder(OrderModel orderModel,List<CardModel> cardModel){
    final writeBatch = _firestore.batch();
    final orderDoc = _firestore.collection(_collectionOrders).doc();
    orderModel.orderId =orderDoc.id;
    writeBatch.set(orderDoc, orderModel.toMap());
    
    cardModel.forEach((element) {
      final cartDoc = orderDoc.collection(_collectionOrderDetails).doc(element.productId);
      writeBatch.set(cartDoc, element.toMap());
    });
    return writeBatch.commit();
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllProducts()=> _firestore.collection(_collectionProducts)
      .snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllCardItems(String uid)=>
      _firestore.collection(_collectionUsers).doc(uid).collection(_collectionCardItems)
      .snapshots();

  static Stream<DocumentSnapshot<Map<String,dynamic>>> getProductByProductId(String productId)=>
      _firestore.collection(_collectionProducts).doc(productId)
      .snapshots();

  static Stream<DocumentSnapshot<Map<String,dynamic>>> getOrderConstants()=>
      _firestore.collection(_collectionOrderConstant).doc(_documentsConstant)
          .snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllOrderByUser(String uid) =>
    _firestore.collection(_collectionOrders)
        .where('UserId', isEqualTo: uid)
        .snapshots();

  static Stream<DocumentSnapshot<Map<String,dynamic>>> getOrderByOrderId(String orderId)=>
  _firestore.collection(_collectionOrders).doc(orderId).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getOrderDetails(String orderId)=>
      _firestore.collection(_collectionOrders).doc(orderId).collection(_collectionOrderDetails).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllCategories()=> _firestore.collection(_collectionCategories)
      .snapshots();

  static Future<void> updateImage(String productId,String url){
    final docRef = _firestore.collection(_collectionProducts).doc(productId);
    return docRef.update({'imageUrl ':url});
  }
  static Future<void> deleteCardItem(String uid,String productId) async{
    return _firestore.collection(_collectionUsers)
       .doc(uid)
       .collection(_collectionCardItems)
       .doc(productId)
       .delete();
  }
  static Future<void> deleteCardItems(String uid,List<CardModel> cardModel) async{
   final wb = _firestore.batch();
   cardModel.forEach((element) {
     final doc = _firestore.collection(_collectionUsers)
         .doc(uid).collection(_collectionCardItems)
     .doc(element.productId);
     wb.delete(doc);
   });
   return wb.commit();
  }
}