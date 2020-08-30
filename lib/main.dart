//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/constant.dart';
import 'package:shopping/provider/adminmood.dart';
import 'package:shopping/provider/cartitem.dart';
import 'package:shopping/provider/modelhud.dart';
import 'package:shopping/screen/admin/addproduct.dart';
import 'package:shopping/screen/admin/adminHome.dart';
import 'package:shopping/screen/admin/manageproduct.dart';
import 'package:shopping/screen/admin/order_detailes.dart';
import 'package:shopping/screen/admin/orderscreen.dart';
import 'package:shopping/screen/user/cartscreen.dart';
import 'package:shopping/screen/user/homepage.dart';
import 'package:shopping/screen/user/login_screen.dart';
import 'package:shopping/screen/user/productinfo.dart';
import 'package:shopping/screen/user/signup_screen.dart';
import 'screen/admin/editproduct.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool isUserlogedin = false;
  @override

  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>
    (
      future: SharedPreferences.getInstance(),
      builder:(context, snapshot)
      {
        if(! snapshot.hasData)
        {
          return MaterialApp(home: Scaffold(body: Text("Laoding....."),),
          );

        }else
        {
          isUserlogedin = snapshot.data.getBool(kKeepMeLoggedIn) ?? false;
          return   MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHud>(
                create: (context) => ModelHud(),
              ),
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
              ChangeNotifierProvider<AdminMood>(
                create: (context) => AdminMood(),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute:isUserlogedin ? HomePage.id : LoginScreen.id,
              routes: {
                OrderDetailes.id: (context) => OrderDetailes(),
                OrderScreen.id: (context) => OrderScreen(),
                CartScreen.id: (context) => CartScreen(),
                ProductInfo.id: (context) => ProductInfo(),
                EditProduct.id: (context) => EditProduct(),
                ManageProduct.id: (context) =>  ManageProduct(),
                LoginScreen.id: (context) => LoginScreen(),
                SignUpScreen.id: (context) => SignUpScreen(),
                HomePage.id: (context) => HomePage(),
                AdminHome.id: (context) => AdminHome(),
                AddProduct.id: (context) => AddProduct(),
              },
            ),
          );
        }
      },
    );
          
        }
      }
    
  

