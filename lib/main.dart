import 'package:baby_shop/card_page.dart';
import 'package:baby_shop/check_page.dart';
import 'package:baby_shop/lancher.dart';
import 'package:baby_shop/login.dart';
import 'package:baby_shop/model/order_constant_value.dart';
import 'package:baby_shop/model/product_model.dart';
import 'package:baby_shop/order_details_page.dart';
import 'package:baby_shop/order_page.dart';
import 'package:baby_shop/product_details_page.dart';
import 'package:baby_shop/provider/card_provider.dart';
import 'package:baby_shop/provider/order_provider.dart';
import 'package:baby_shop/provider/product_provider.dart';
import 'package:baby_shop/provider/user_provier.dart';
import 'package:baby_shop/splash_screen.dart';
import 'package:baby_shop/user_order_page_list.dart';
import 'package:baby_shop/view_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>ProductProvider()),
        ChangeNotifierProvider(create: (context)=>UserProvider()),
        ChangeNotifierProvider(create: (context)=>CardProvider()),
        ChangeNotifierProvider(create: (context)=>OrderProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          LoginPage.routeName:(context)=>LoginPage(),
          ViewProduct.routeName:(context)=>ViewProduct(),
          LancherPage.routeName:(context)=>LancherPage(),
          ProductDetails.routeName:(context)=>ProductDetails(),
          CardPage.routeName:(context)=>CardPage(),
          CheckPage.routeName:(context)=>CheckPage(),
          OrderPage.routeName:(context)=>OrderPage(),
          OrderList.routeName:(context)=>OrderList(),
          OrderDetailsPage.routeName:(context)=>OrderDetailsPage(),
          SplashScreen.routeName:(context)=> SplashScreen()
        },
      ),
    );
  }
}
