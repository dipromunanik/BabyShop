import 'package:baby_shop/auth/auth_service.dart';
import 'package:baby_shop/login.dart';
import 'package:flutter/material.dart';

class LancherPage extends StatefulWidget {

  static const String routeName ='/lancher';

  const LancherPage({Key? key}) : super(key: key);

  @override
  _LancherPageState createState() => _LancherPageState();
}

class _LancherPageState extends State<LancherPage> {

  @override
  void initState() {
   Future.delayed(const Duration(seconds: 0),(){
     if(AuthService.currentUser !=null){
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
     }
     else{
       Navigator.pushReplacementNamed(context, LoginPage.routeName);
     }
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
