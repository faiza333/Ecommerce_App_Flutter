import 'package:flutter/material.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/services/store.dart';
import 'package:shopping/wedgit/custom_textfield.dart';

class AddProduct extends StatelessWidget {
  static final id = 'AddProduct';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  String _name, _price, _description, _catiguray, _imagelocation;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body:Stack(
              children:[
                Container(
                  
                   padding: const EdgeInsets.only(top: 400),
                    child: Image(
                      image: AssetImage('images/icons/ff.png'),
                      
                    ),
                  ), 
                
                Form(
          key: _globalKey,
            
              child: Padding(
                padding: EdgeInsets.only(top: 60,right: 40,left: 40),
               // height: MediaQuery.of(context).size.height,
                 child: ListView(
                children: [
                
                CustomTextField(
                  hint: 'Product Name',
                  onclick: (value){
                      _name =value;
                  },
                  ),
                SizedBox(height: 12,),

                CustomTextField(
                  hint: 'Product Price',
                   onclick: (value){
                      _price =value;
                  },
                  ),
                SizedBox(height: 12,),
                CustomTextField(
                  hint: 'Product Description',
                   onclick: (value){
                      _description =value;
                  },
                  ),
                SizedBox(height: 12,),
                CustomTextField(
                  hint: 'Product caregoury',
                   onclick: (value){
                      _catiguray =value;
                  },
                  ),
                  SizedBox(height: 12,),
                CustomTextField(
                  hint: 'Product Location',
                   onclick: (value){
                      _imagelocation =value;
                  },
                  ),
                  SizedBox(height: 12,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: RaisedButton(onPressed: ()
                  {
                    if(_globalKey.currentState.validate()){
                        _globalKey.currentState.save();
//هروح اجهز الفاير ستور علشان اخزن الداتا بتاعتي
                        _store.addProduct(Product(
//هاتلي الداتا من التيكستفيلد وحطها في بينيم
                          pName: _name,
                          pDescription: _description,
                          pLocation: _imagelocation,
                          pPrice: _price,
                          pcatugry: _catiguray,
                        ));
                    }
                  },
                  shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(18.0),
                     side: BorderSide(color: Colors.brown)
                    ),
                  color: Colors.blue[700],
                  child: Text('Add Product')
                  
                  ),
                )
                
                ],),
              ),
            ),
              ]),
      );
  
      
    
  }
}