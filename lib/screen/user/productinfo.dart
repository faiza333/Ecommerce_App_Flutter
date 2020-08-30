import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/provider/cartitem.dart';
import 'package:shopping/screen/user/cartscreen.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quintity =1;
  @override
  Widget build(BuildContext context) {
//هستقبل الدتا

    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(product.pLocation),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              //color: Colors.blue,
              height: MediaQuery.of(context).size.height * .1,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.blue[900],
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                   child: Icon(
                      Icons.shopping_cart,
                      color: Colors.blue[900],
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Opacity(
                  child: Container(
                    color: Colors.blue[300],
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.pName,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[900])),
                          SizedBox(
                            height: 10,
                          ),
                          Text(product.pDescription,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[900])),
                          SizedBox(
                            height: 10,
                          ),
                          Text('\$${product.pPrice}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[900])),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                  child: Material(
                                      color: Colors.yellow[900],
                                      child: GestureDetector(
                                        onTap: add,
                                        child: SizedBox(
                                          child: Icon(Icons.add),
                                          height: 28,
                                          width: 28,
                                        ),
                                      ))),
                              Text(
                                _quintity.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                     ClipOval(
                      child: Material(
                       color: Colors.yellow[900],
                        child: GestureDetector(
                            onTap: subStract,
                             child: SizedBox(
                               child: Icon(Icons.remove),
                                 height: 28,
                                 width: 28,
                                        ),
                                      )
                                      )
                                      ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  opacity: .5,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .1,
                  child: Builder(
                     builder: (context) => RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                      color: Colors.blue[900],
                      onPressed: () 
                      {
                       addtocart(context,product);
                                             },
                                             child: Text(
                                               'Add to card',
                                               style:
                                                   TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                             ),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 )
                               ],
                             ),
                           );
                         }
                       
                         subStract() {
                           if (_quintity > 1) {
                             setState(() {
                               -_quintity--;
                             });
                           }
                         }
                       
                         add() {
                           setState(() {
                             _quintity++;
                           });
                         }
                       
                         void addtocart(context, product) 
                         {
                        CartItem cartitem = 
                        Provider.of<CartItem>(context, listen: false);
                        product.pQuentity = _quintity;
                         var productincart = cartitem.products;
                        bool exist = false;
                        for(var productincart in productincart){
                          if(productincart.pName == product.pName){
                            exist=true;
                          }
                        }
                        if(exist){
                           Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('you have added this item before'),
                        ));
                        }else{
                             cartitem.AddProduct(product);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(' added to cart'),
                        ));
                        }
                     
                         }
}
