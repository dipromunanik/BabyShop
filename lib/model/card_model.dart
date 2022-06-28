class CardModel{

  String productId;
  String productName;
  num price;
  int qty;

  CardModel(
  {required this.productId,
      required this.productName,
      required this.price,
      this.qty =1});

  Map<String,dynamic> toMap(){

    var map =<String,dynamic>{

      'productId':productId,
      'productName':productName,
      'price':price,
      'qty':qty
    };
    return map;
  }
  factory CardModel.fromMap(Map<String,dynamic> map)=>CardModel(
      productId: map['productId'],
      productName:map['productName'],
      price:map['price'],
      qty: map['qty']
  );
}