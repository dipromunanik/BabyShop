import 'package:baby_shop/user_order_page_list.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.deepOrange,
          ),
          const SizedBox(height: 5),
          ListTile(
            title: Text('Profile',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
            leading: Icon(Icons.person),
          ),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, OrderList.routeName);
            },
            title: Text('Order List',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
            leading: Icon(Icons.reorder),
          ),
          ListTile(
            title: Text('Logout',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
            leading: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
