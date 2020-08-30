//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/constant.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/provider/cartitem.dart';
import 'package:shopping/screen/user/productinfo.dart';
import 'package:shopping/services/store.dart';
import 'package:shopping/wedgit/customfile.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
//علشان لما يظهر ديالوج توتل السعر ميعملش ارور بسبب اختلاف المساحة
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
            )),
        title: Text('My Cart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          LayoutBuilder(builder: (context, constrins) {
            if (products.isNotEmpty) {
//الاول كنت حاط الليست في اكسباند حولته لكنتينر لانكان فيه مشكلة لما اضيف حاجة واروح اشوفها متحملش
              //ولما كنت بفتح الشوز مثلا مكانش بيحمل
              return Container(
                height: screenHeight -
                    statusBarHeight -
                    appBarHeight -
                    (screenHeight * .08),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: GestureDetector(
                        onTapUp: (details) {
                          showcustommenu(details, context, products[index]);
                        },
                        child: Container(
                          height: screenHeight * .15,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: screenHeight * .15 / 2,
                                backgroundImage:
                                    AssetImage(products[index].pLocation),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            products[index].pName,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            products[index].pPrice,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Text(
                                          products[index].pQuentity.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          color: Colors.blue[300],
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            } else {
              return Container(
                height: screenHeight -
                    (screenHeight * .08) -
                    appBarHeight -
                    statusBarHeight,
                child: Center(
                  child: Text("Cart is empty"),
                ),
              );
            }
          }),
          Builder(
                      builder: (context) => ButtonTheme(
              minWidth: screenWidth,
              height: screenHeight * .08,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: RaisedButton(
                onPressed: () {
                  showcustomdilog(products, context);
                },
                child: Text('Order'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                color: Colors.blue[900],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //علشان لما اضيف عنصر للكارت واروح له اقدر امسح منه واعدله
  void showcustommenu(details, context, product) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;

    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          MyPopupMenuItem(
            onClick: () {
              //علشان اطلع برا البوب ال بيظهر
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deletproduct(product);
              Navigator.pushNamed(context, ProductInfo.id, arguments: product);
            },
            child: Text('Edit'),
          ),
          MyPopupMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deletproduct(product);
            },
            child: Text("Delete"),
          )
        ]);
  }

  void showcustomdilog(List<Product> products, context) async {
    var price = getTotalPrice(products);
    var address;
    AlertDialog alertDialog = AlertDialog(
      actions: [
        MaterialButton(
            onPressed: () {
              try {
                Store _store = Store();
                _store.storeOrders(
                    {kTotallPrice: price, kAddress: address}, products);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Orderd sacssesfuly"),
                ));
                Navigator.pop(context);
              } catch (ex) {
                print(ex.message);
              }
            },
            child: Text("Confirm"))
      ],
      content: TextField(
        decoration: InputDecoration(hintText: "Enter your Address"),
      ),
      title: Text('Total Prics = \$ $price'),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotalPrice(products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuentity * int.parse(product.pPrice);
    }
    return price;
  }
}
