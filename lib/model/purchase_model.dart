import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseModel{

  String? PurchaseId;
  String? ProductId;
  Timestamp PurchaseDate;
  num PurchaseQuantity;
  num PurchasePrice;

  PurchaseModel({this.PurchaseId, this.ProductId,required this.PurchaseDate,
     required this.PurchaseQuantity,required this.PurchasePrice});

  Map<String,dynamic> toMap(){

    var map = <String,dynamic>{
     'PurchaseId': PurchaseId,
      'ProductId': ProductId,
      'PurchaseDate':PurchaseDate,
      'PurchaseQuantity':PurchaseQuantity,
      'PurchasePrice':PurchasePrice
    };
    return map;
  }
  factory PurchaseModel.formMap(Map<String,dynamic> map)=>PurchaseModel(
    PurchaseId: map['PurchaseId'],
      ProductId: map['ProductId'],
      PurchaseDate: map['PurchaseDate'],
      PurchaseQuantity: map['PurchaseQuantity'],
      PurchasePrice: map['PurchasePrice']
  );
}