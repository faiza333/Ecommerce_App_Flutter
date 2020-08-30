import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/constant.dart';
import 'package:shopping/functions.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/screen/admin/editproduct.dart';
import 'package:shopping/screen/admin/manageproduct.dart';
import 'package:shopping/screen/user/cartscreen.dart';
import 'package:shopping/screen/user/login_screen.dart';
import 'package:shopping/screen/user/productinfo.dart';
import 'package:shopping/services/auth.dart';
import 'package:shopping/services/store.dart';
import 'package:shopping/wedgit/productview.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  FirebaseUser _loggedUser;
  int _tabBarIndex = 0;
  int _buttombarindex = 0;
  final _store = Store();
  List<Product> _products;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
//use default to give it lenght
      DefaultTabController(
        length: 4,
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: KUnActiveColor,
                currentIndex: _buttombarindex,
                fixedColor: Colors.blue[300],
                onTap: (value) async{

                  if(value==2){
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.clear();
                    await _auth.SignOut();
            //دي بتخليه يطلع من الصفحة ال هوا فيها وتوديها للوجين
                    Navigator.popAndPushNamed(context,  LoginScreen.id);
                  }
                  setState(() {
                    _buttombarindex = value;
                  });
                },
                items: [
                
                  BottomNavigationBarItem(
                    title: Text(
                      'Test',
                      style: TextStyle(color: KUnActiveColor),
                    ),
                    icon: Icon(Icons.person),
                  ),
                  BottomNavigationBarItem(
                    title: Text(
                      'Test',
                      style: TextStyle(color: KUnActiveColor),
                    ),
                    icon: Icon(Icons.person),
                  ),
                  BottomNavigationBarItem(
                    title: Text(
                      'SignOut',
                      style: TextStyle(color: KUnActiveColor),
                    ),
                    icon: Icon(Icons.close),
                  ),
                ]),
            appBar: AppBar(
              backgroundColor: Colors.blue[300],
              elevation: 0,
              bottom: TabBar(
                  indicatorColor: Colors.blue[9000],
//it give me the index that i pressed
                  onTap: (value) {
                    setState(() {
                      _tabBarIndex = value;
                    });
                  },
                  tabs: <Widget>[
                    Text(
                      "Jackits",
                      style: TextStyle(
                        color:
                            _tabBarIndex == 0 ? Colors.black : KUnActiveColor,
                        fontSize: _tabBarIndex == 0 ? 16 : null,
                      ),
                    ),
                    Text(
                      "Trousior",
                      style: TextStyle(
                        color:
                            _tabBarIndex == 1 ? Colors.black : KUnActiveColor,
                        fontSize: _tabBarIndex == 1 ? 16 : null,
                      ),
                    ),
                    Text(
                      "T-shirts",
                      style: TextStyle(
                        color:
                            _tabBarIndex == 2 ? Colors.black : KUnActiveColor,
                        fontSize: _tabBarIndex == 2 ? 16 : null,
                      ),
                    ),
                    Text(
                      "shoes",
                      style: TextStyle(
                        color:
                            _tabBarIndex == 3 ? Colors.black : KUnActiveColor,
                        fontSize: _tabBarIndex == 3 ? 16 : null,
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(
              children: [
                JackitView(),
                ProductView(kTrousers, _products),
                ProductView(kShoes, _products),
               ProductView(kTshirts, _products),
              ],
            )),
      ),
      Material(
        color: Colors.blue[300],
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Container(
            //color: Colors.blue,
            height: MediaQuery.of(context).size.height * .1,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discover'.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, CartScreen.id);
                  },
                                  child: Icon(
                    Icons.shopping_cart,
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }

  @override
  void inintState() {
    getCurrentUser();
  }

  void getCurrentUser() async {
    _loggedUser = await _auth.getUser();
  }

  Widget JackitView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];

            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              products.add(Product(
                //to get for every product id
                PId: doc.documentID,
                pPrice: data[KProductPrice],
                pName: data[KProductName],
                pcatugry: data[KProductCategory],
                pDescription: data[KProductDescreiption],
                pLocation: data[KProductLocation],
              ));
            }
            //هنا عملت لسته من البرودكت جو الهوم مع اني معايا وادة في الستريم بيلدر لان انا عندي اكتر من ستريم بيلدر
            //فمش هعمل لكل تاب ستريم وكدا كل مرة هضطر اجيب الداتا من النت فانا هعمل ايه اول المرة الداتا هتجيني ال ال هي في الجاكيت اخزناها في ليست
            //والليست دي استخدمها في الباقي طب عايز اجيب البرودط
            //ال الكاتيجوري بتاعتها جاكيت هروح افضي ليست  الستريم واملاها من الخلال البرودكتس ال في الهوم ودا نت خلال الفوؤ لووب
            _products = [...products];
            products.clear();
            products = getProducrCatygory(kJackets, _products);
            //th difrent between this grid and list
            //is this give u more control
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
          } else {
            return Center(child: Text("Loading"));
          }
        });
  }

}
