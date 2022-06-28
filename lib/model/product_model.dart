class ProductModel{

  String? ProductId;
  String ProductName;
  String Category;
  num SaleProduct;
  String? ProductDescription;
  String? ImageUrl;
  bool isAvaiable;

  ProductModel({this.ProductId,required this.ProductName,required this.Category,
      required this.SaleProduct, this.ProductDescription, this.ImageUrl,this.isAvaiable=true});

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
       'ProductId': ProductId,
      'ProductName': ProductName,
      'Category': Category,
      'SaleProduct': SaleProduct,
      'ProductDescription': ProductDescription,
      'ImageUrl': ImageUrl,
      'isAvaiable':isAvaiable
    };
    return map;
  }
  factory ProductModel.fromMap(Map<String,dynamic> map)=>ProductModel(
    ProductName: map['ProductName'],
    ProductId: map['ProductId'],
    Category: map['Category'],
    SaleProduct: map['SaleProduct'],
    ProductDescription: map['ProductDescription'],
    ImageUrl: map['ImageUrl'],
      isAvaiable:map['isAvaiable']
  );
}