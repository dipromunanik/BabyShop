class UserModel{
  String Uid;
  String? name;
  String email;
  String? phone;
  String? picturer;
  String? deliveryAddress;

  UserModel({required this.Uid, this.name,required this.email, this.phone, this.picturer,
      this.deliveryAddress});

  Map<String,dynamic> toMap(){

    var map=<String,dynamic>{

      'Uid':Uid,
      'name':name,
      'email':email,
      'phone':phone,
      'picturer':picturer,
      'deliveryAddress':deliveryAddress
    };
    return map;
  }
  factory UserModel.fromMap(Map<String,dynamic> map)=>UserModel(
      Uid: map['Uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      picturer: map['picturer'],
      deliveryAddress: map['deliveryAddress'],
  );
}