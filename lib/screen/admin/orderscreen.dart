//dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping/constant.dart';
import 'package:shopping/models/order.dart';
import 'package:shopping/screen/admin/order_detailes.dart';
import 'package:shopping/services/store.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'OrderScreen';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
//هستخد البيلدر علشان ابني البادي بتاع الاوردر سكريين
//عارفه انه بياخد كونتيكست و سنابشوت
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("There is no data"));
          } else {
//هنا هبتدي اخزن الداتا جوا ليست علشان استخد الليست جوا
// ليستفيودوتبيلدر فهنعمل مودل للداتا ال هنستقبلها من الاوردر

            List<Order> orders = [];
            for (var doc in snapshot.data.documents) {
              orders.add(Order(
                documntId: doc.documentID,
                  address: doc.data[kAddress],
                  totalprice: doc.data[kTotallPrice]
                  ));
            }
            return ListView.builder(itemBuilder: 
            (context, index) =>
            Padding(padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: ()
              {
                Navigator.pushNamed(context, OrderDetailes.id, arguments: orders[index].documntId);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .2,
                color: Colors.blue[300],
                child: Padding(padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total Price = \$ ${orders[index].totalprice}'
                    ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                     
                    ),
                    SizedBox(height: 10,),
                    Text('Address is ${orders[index].address}',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                ),
                ),
              ),
            ),
            itemCount: orders.length,
            );
          }
        },
      ),
    );
  }
}
