import 'package:cloud_firestore/cloud_firestore.dart';

final String ORDER_PAYMENT_METHOD ='orderPaymentMethod';
final String ORDER_DELIVERY_METHOD ='orderDeliveryMethod';
final String UserId='UserId';

class OrderModel{

  String? orderId;
  Timestamp timestamp;
  String UserId;
  num grandTotal;
  num discount;
  num deliveryCharge;
  num vat;
  String orderStatus;
  String paymentMethod;
  String deliveryAddress;

  OrderModel(
  {this.orderId,
      required  this.timestamp,
      required this.UserId,
      required this.grandTotal,
      required this.discount,
      required this.deliveryCharge,
      required this.vat,
      required this.orderStatus,
      required this.paymentMethod,
      required this.deliveryAddress});

  Map<String,dynamic> toMap(){

    var map =<String,dynamic>{
      'orderId':orderId,
      'timestamp':timestamp,
      'UserId':UserId,
      'grandTotal':grandTotal,
      'discount':discount,
      'deliveryCharge':deliveryCharge,
      'vat':vat,
      'orderStatus':orderStatus,
      'paymentMethod':paymentMethod,
      'deliveryAddress':deliveryAddress
    };
    return map;
  }

  factory OrderModel.fromMap(Map<String,dynamic> map)=> OrderModel(
      orderId: map['orderId'],
      timestamp: map['timestamp'],
      UserId: map['UserId'],
      grandTotal: map['grandTotal'],
      discount: map['discount'],
      deliveryCharge: map['deliveryCharge'],
      vat: map['vat'],
      orderStatus: map['orderStatus'],
      paymentMethod: map['paymentMethod'],
      deliveryAddress: map['deliveryAddress']
  );

}