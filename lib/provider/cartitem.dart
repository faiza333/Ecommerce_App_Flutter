import 'package:flutter/material.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/screen/admin/addproduct.dart';

class CartItem extends ChangeNotifier
{
  List<Product> products =  [];
  AddProduct(Product product)
  {
    products.add(product);
    notifyListeners();
  }
  deletproduct(Product product){
    products.remove(product);
    notifyListeners();
  }
}
