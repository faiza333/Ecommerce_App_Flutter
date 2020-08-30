import 'package:flutter/material.dart';

class Product {
  String pName;
  String pPrice;
  String pLocation;
  String pDescription;
  String pcatugry;
  String PId;
  int pQuentity;

  Product(
      {
        this.pQuentity,
        this.PId,
        this.pName,
      this.pDescription,
      this.pLocation,
      this.pPrice,
      this.pcatugry});
}
