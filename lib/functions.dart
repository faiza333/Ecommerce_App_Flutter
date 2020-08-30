import 'package:flutter/material.dart';
import 'package:shopping/models/product.dart';


  List<Product> getProducrCatygory(String kJackets, List<Product> allProducts) {
    List<Product> products = [];
    try{
    for (var product in allProducts) {
      if (product.pcatugry == kJackets) {
        products.add(product);
      }
    }
  } on Error catch(ex){
    print(ex);
  }
    return products;
  }