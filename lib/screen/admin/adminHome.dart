import 'package:flutter/material.dart';
import 'package:shopping/screen/admin/addproduct.dart';
import 'package:shopping/screen/admin/manageproduct.dart';
import 'package:shopping/screen/admin/orderscreen.dart';

class AdminHome extends StatelessWidget {
  static final id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
              children: [

                 Container(
                  
                   padding: const EdgeInsets.only(top: 0),
                    child: Image(
                      image: AssetImage('images/icons/c.png'),
                      
                    ),
                  ), 


                Container(
                  
                   padding: const EdgeInsets.only(top: 400),
                    child: Image(
                      image: AssetImage('images/icons/o.png'),
                      
                    ),
                  ), 

                Container(
                  
          padding: EdgeInsets.only(bottom: 50),
            child: Column(
              
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              //كدا بقي الويدث بتاع الكولوم هوا بتاع الاسكرين
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 40),
              onPressed: () 
              {
                  Navigator.pushNamed(context, AddProduct.id);
              },
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(18.0),
                       side: BorderSide(color: Colors.brown)
                      ),
               child: 
                    Text('Add product', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[50]),),
             ),
            RaisedButton(
               padding: EdgeInsets.symmetric(horizontal: 40),
              onPressed: () 
              {
                Navigator.pushNamed(context,ManageProduct.id);
              }, 
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(18.0),
                       side: BorderSide(color: Colors.brown)
                      ),
              child: Text('Edite product', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[50]),)),
            RaisedButton(
               padding: EdgeInsets.symmetric(horizontal: 40),
              onPressed: () {
                Navigator.pushNamed(context, OrderScreen.id);
              },
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(18.0),
                       side: BorderSide(color: Colors.brown)
                      ), 
              child: 
              Text('View orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[50]),)
              )
          ],
        ),
                ),
              ]),
    );
  }
}
