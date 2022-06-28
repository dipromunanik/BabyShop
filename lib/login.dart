import 'package:baby_shop/auth/auth_service.dart';
import 'package:baby_shop/provider/user_provier.dart';
import 'package:baby_shop/view_product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'db/db_helper.dart';
import 'model/user_model.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _password = '';
  String _email = '';
  bool _isLogin=true;
  bool _isVisible = true;
  String _errorMessage = '';
  final _formKey = GlobalKey<FormState>();
  late UserProvider _userProvider;

  @override
  void didChangeDependencies() {
    _userProvider =Provider.of<UserProvider>(context,listen: false);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset('images/applogo.png',
                      height: 100, width: 300),
                ),
                Column(
                  children: const [
                    Text(
                      'Find, Discover, Choose and Buy',
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald'
                      ),
                    ),
                    Text(
                      'anything from Online',
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald'
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/user.png',height: 80,width: 80,),
                    const SizedBox(width: 10),
                    const Text('Login',style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oswald'
                    ),)
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'This field can not be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.deepOrange))),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: _isVisible,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'This field can not be empty';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: _isVisible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.deepOrange))),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('Forget Password',style: TextStyle(
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold
                  ),),
                ),
                const SizedBox(height: 15),
                InkWell(
              onTap: (){
                _isLogin =true;
                _userLogin();
              },
              child: Container(
                height: 50,
                width: 380,
                decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.grey,
                          spreadRadius: 2,
                          offset: Offset(0, 9)),
                    ],
                    gradient: const LinearGradient(
                        colors: [Colors.deepOrange, Colors.pinkAccent])),
                child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                        child: Text('Login',
                          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                        ))),
              ),
            ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     const Text("Don't have an account?",
                        style: TextStyle(fontSize: 18,color: Colors.black,fontFamily:'Oswald' )),
                     const SizedBox(width: 5),
                    InkWell(
                      onTap: (){
                        _isLogin =false;
                        _userLogin();
                      },
                        child: Text('SignUp',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold))),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:   [
                    Text('Login With : ',style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oswald'
                    ),
                    ),
                    InkWell(
                      onTap: (){
                        signInGoogle();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(180),
                          color: Colors.white,
                          border: Border.all(color: Colors.black,width: 2),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 1,
                                color: Colors.grey,
                                spreadRadius: 2,
                                offset: Offset(0, 1)),
                          ],
                        ),
                        child: Padding(
                            padding:EdgeInsets.all(10)
                            ,child: Image.asset('images/google.png',width: 100,height: 100)),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(180),
                        color: Colors.white,
                        border: Border.all(color: Colors.black,width: 2),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 1,
                              color: Colors.grey,
                              spreadRadius: 2,
                              offset: Offset(0, 1)),
                        ],
                      ),
                      child: Padding(
                          padding:EdgeInsets.all(10)
                          ,child: Image.asset('images/facebook.png',width: 60,height: 60)),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(180),
                        color: Colors.white,
                        border: Border.all(color: Colors.black,width: 2),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 1,
                              color: Colors.grey,
                              spreadRadius: 2,
                              offset: Offset(0, 1)),
                        ],
                      ),
                      child: Padding(
                          padding:EdgeInsets.all(10)
                          ,child: Image.asset('images/twitter.png',width: 100,height: 100)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _userLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        String? uid;
        if(_isLogin){
          uid = await AuthService.login(_email, _password);
        }else{
          uid = await AuthService.registerUser(_email, _password);
        }
        if (uid != null) {
          if(!_isLogin)
          {
            final user =UserModel(Uid: uid, email: AuthService.currentUser!.email!);
            _userProvider.addUser(user).then((value) =>  Navigator.pushReplacementNamed(context, ViewProduct.routeName));
          }
          Navigator.pushReplacementNamed(context, ViewProduct.routeName);
        }
      } on FirebaseAuthException catch (error) {
        setState(() {
          _errorMessage = error.message!;
        });
      }
    }
  }

  Future<UserCredential> signInGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}



