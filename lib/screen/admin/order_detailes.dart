//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping/constant.dart';
import 'package:shopping/models/order.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/services/store.dart';


class OrderDetailes extends StatelessWidget {
  static String id = 'OrderDetailes';
  Store _store = Store(); 
  @override
  Widget build(BuildContext context) {
//get data comes from argumnt from pushednamed in orderscreen
     String documntId = ModalRoute.of(context).settings.arguments;
    return  Scaffold(
          body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrdersDetailes(documntId),
        builder: (context, snapshot){
          if(snapshot.hasData)
          {
            List<Product> products = [];
            for(var doc in snapshot.data.documents)
            {
              products.add(Product(
                pName: doc.data[KProductName],
                pQuentity: doc.data[kProductQuantity],
                pcatugry: doc.data[KProductCategory]
                
              ));
            }
            return  Column(
              children: [
                Expanded(
                                  child: ListView.builder(
                              itemBuilder:(context, index) => Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          color: Colors.blue[300],
                          child: Padding(padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Text('product name ${products[index].pName}'
                                ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                 
                                ),
                                SizedBox(height: 10,),
                                Text('quentity : ${products[index].pQuentity}',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                                
                                SizedBox(height: 10,),
                                Text('catugory : ${products[index].pcatugry}',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                )
                            ],
                          ),
                          ),
                          ),
                              ),
                  itemCount: products.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    RaisedButton(onPressed: (){},
                    color: Colors.blue[900],
                    child: Text("Confirm order",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 15))
                    
                    ),
                      RaisedButton(
                        onPressed: (){},
                        color: Colors.blue[900],
                    child: Text("Delete order", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),)
                    
                    ),
                  ],),
                )
              ],
            );
          }
        }),
    );
  }
}