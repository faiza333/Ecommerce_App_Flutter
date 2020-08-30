//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping/constant.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/screen/admin/addproduct.dart';

class Store
{
  final Firestore _firestore = Firestore.instance;
//لفانكشن دي هتسيف الداتا في الداتا بيز
  addProduct(Product product )
  {
    _firestore.collection(KProductCollction).add({
//هنا بقوله هاتلي الداتا ال في كلاس البرودكت ال هي مثلا النيم وخزنها في كيبرودكتنيم
      KProductName: product.pName,
      KProductPrice: product.pPrice,
      KProductLocation: product.pLocation,
      KProductDescreiption : product.pDescription,
      KProductCategory : product.pcatugry,

    });
  }
//get data from database ep 8
//change it to strem to get data soon
      Stream<QuerySnapshot> loadProducts()
      {
        return _firestore.collection(KProductCollction).snapshots();
      }

      Stream<QuerySnapshot> loadOrders()
      {
        return _firestore.collection(kOrders).snapshots();
      }
//method get orderdetiles that i want
        Stream<QuerySnapshot> loadOrdersDetailes(documntId)
      {
        return _firestore.collection(kOrders).document(documntId).collection(kOrderDetails).snapshots();
      }




//i write productid coz delete
// the one that i want to delet not
      delteProduct(ProductId)
      {
        _firestore.collection(KProductCollction).document(ProductId).delete();
      }

       editProduct(data, documentId) {
    _firestore
        .collection(KProductCollction)
        .document(documentId)
        .updateData(data);
  }

  storeOrders(data ,List<Product> products)
  {
    var _documntRef = _firestore.collection(kOrders).document();
    _documntRef.setData(data);
    for(var product in products){
//روحت للدوكيومنت وعملت كوليكشن اسمها كاوردرديتايلزوهبتدي اخزن فيها الداتا بس هخزن فيها اكتر من برودكت 
//فاستخدمت فور لوب
      _documntRef.collection(kOrderDetails).document().setData({
        KProductName: product.pName,
        KProductPrice: product.pPrice,
        kProductQuantity: product.pQuentity,
        KProductLocation: product.pLocation,
        KProductCategory: product.pcatugry,
      });

    }

  }

      // editProduct(data, documntId)
      // {
      //   _firestore.collection(KProductCollction).document(documntId).updateData(data);
      // }
  // Future<List<Product>> loadProducts()async{
  //   var snapshot = await _firestore.collection(KProductCollction).getDocuments();
  //   List<Product> products = [];
  //   for(var doc in snapshot.documents)
  //   {
  //     var data = doc.data;
  //     products.add(Product(
  //       pPrice: data[KProductPrice],
  //       pName: data[KProductName],
  //       pcatugry: data[KProductCategory],
  //       pDescription: data[KProductDescreiption],
  //       pLocation: data[KProductLocation],
  //     ));
  //   }
  //   return products;
  // }
}