import 'package:flutter/material.dart';

class OrderConstantModel{

  num deliveryCharge;
  num discount;
  num vat;

  OrderConstantModel({this.deliveryCharge=0, this.discount=0, this.vat=0});

  factory OrderConstantModel.fromMap(Map<String,dynamic> map)=>OrderConstantModel(
    deliveryCharge: map['deliveryCharge'],
    discount: map['discount'],
    vat: map['vat']
  );

  String toString(){
    return 'OderConstantsModel{deliveryCharge: $deliveryCharge, discount: $discount, vat: $vat}';
  }
}