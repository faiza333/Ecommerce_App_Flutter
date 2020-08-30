import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'dart:html';
import 'package:shopping/constant.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/services/store.dart';
import 'package:shopping/screen/admin/editproduct.dart';
import 'package:shopping/wedgit/customfile.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//we say the type will come future here is <List<Product>>
//we have proplem that if u go to databse and add
//product will not appear untill you make save
// and this bad coz may be admin delete product
//then u can;t know soon
//again we will change future to stream
//and it like suscripe
//note we should put products[] in the
//stream to make rebuild
//for it so the values be 0 or the list will rebeat
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];

              for (var doc in snapshot.data.documents) {
                var data = doc.data;
                products.add(Product(
//to get for every product id
                  PId: doc.documentID,
                  pPrice: data[KProductPrice],
                  pName: data[KProductName],
                  pcatugry: data[KProductCategory],
                  pDescription: data[KProductDescreiption],
                  pLocation: data[KProductLocation],
                ));
              }
//th difrent between this grid and list
//is this give u more control
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTapUp: (details) async {
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
                                Navigator.pushNamed(context, EditProduct.id,
                                    arguments: products[index]);
                              },
                              child: Text('Edit'),
                            ),
                            MyPopupMenuItem(
                              onClick: () {
                                _store.delteProduct(products[index].PId);
                                Navigator.pop(context);
                              },
                              child: Text("Delete"),
                            )
                          ]);
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        )),
                        Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .7,
                              child: Container(
                                height: 60,
                                color: Colors.blue[200],
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[index].pName,
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\$ ${products[index].pPrice}',
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                itemCount: products.length,
              );
            } else {
              return Center(child: Text("Loading"));
            }
          }),
    );
  }
// we gonna get proplem with data coz it is disappear when
//we leave the pag coz it is need time to get it so we gonna use
// future builder and we will make all code ander this comment
// no need it more.

// we can't use initstate to appear the data coz data async
//so we do another method and call it in init
  //@override
  // void initState(){
  //   getProduct();
  //     }

  // void getProduct() async
  // {
  //   _products = await _store.loadProducts();
  // }
}

//make calass inharit from popmenue to
// aple make action when click on delet or edit
