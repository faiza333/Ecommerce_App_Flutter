import 'package:flutter/material.dart';
import 'package:shopping/functions.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/screen/user/productinfo.dart';


 ProductView(String pCatygoury, List<Product> allProducts) 
  {
    List<Product> products;
    products = getProducrCatygory(pCatygoury, allProducts);
     return GridView.builder(

              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: ()
                  {
                    Navigator.pushNamed(context,ProductInfo.id, arguments: products[index]);
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
  }