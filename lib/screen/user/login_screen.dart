import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shopping/constant.dart';
import 'package:shopping/provider/adminmood.dart';
import 'package:shopping/provider/modelhud.dart';
import 'package:shopping/screen/admin/adminHome.dart';
import 'package:shopping/screen/user/homepage.dart';
import 'package:shopping/screen/user/signup_screen.dart';
import 'package:shopping/services/auth.dart';
import 'package:shopping/wedgit/custom_textfield.dart';
import 'package:shopping/wedgit/customlogo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _email, _password;

  final adminPassword = 'admin1234';

  final _auth = Auth();

  bool KeepMeLogedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .4,
                    child: CustomLogo(),
                  ),
                ),
                CustomTextField(
                    onclick: (value) {
                      _email = value;
                    },
                    hint: 'Enter your email',
                    icon: Icons.email),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.blue[900]),
                         child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.blue,
                          value: KeepMeLogedIn,
                          onChanged: (value)
                          {
                            setState(() {
                              KeepMeLogedIn = value;
                            });
                          },
                        ),
                      ),
                      Text("Remember Me", style:TextStyle(color: Colors.blue[900],fontSize: 18, fontWeight:FontWeight.bold) )
                    ],
                  ),
                ),
                CustomTextField(
                    onclick: (value) {
                      _password = value;
                    },
                    hint: 'Enter your password',
                    icon: Icons.lock),
                SizedBox(
                  height: height * .02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120),
                  child: Builder(
                    builder: (context) => FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.blue[200],
                        onPressed: () async {
                          if(KeepMeLogedIn == true){
                            KeepUserLogedIn();
                                                      }
                                                      _validate(context);
                                                      
                                                    },
                                                    child: Text(
                                                      "Login",
                                                      style:
                                                          TextStyle(fontSize: 20, color: Colors.blue[900]),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * .02,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Don\'t have an account ? ",
                                                    style:
                                                        TextStyle(color: Colors.blue[400], fontSize: 18)),
                            //الويدجت  دي بتسمحلي اخلي التيكست زي اللينك بفضل اون تاب بتاعتها
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(context, SignUpScreen.id);
                                                  },
                                                  child: Text("Sign up",
                                                      style: TextStyle(
                                                          color: Colors.blue[900],
                                                          fontSize: 18,
                                                          decoration: TextDecoration.underline)),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                              child: Row(
                                                children: [
                                                   Expanded(
                            //كل واحدة في اكسباندد علشان يبعدوا عن بعض بقدر المستطاع
                                                    child: GestureDetector(
                                                      child: FlatButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20)),
                                                        color: Provider.of<AdminMood>(context).isAdmin
                                                            ? Colors.white
                                                            : Colors.blue[200],
                                                        onPressed: () {
                                                          Provider.of<AdminMood>(context, listen: false)
                                                              .changeIsAdmin(true);
                                                        },
                                                        child: Text(
                                                          'I\'m an admin',
                                                          style: TextStyle(
                                                              color: Provider.of<AdminMood>(context).isAdmin
                                                                  ? Colors.white
                                                                  : Colors.blue[900],
                                                              fontSize: 18),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: GestureDetector(
                                                        child: FlatButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(20)),
                                                          color: Provider.of<AdminMood>(context).isAdmin
                                                              ? Colors.blue[200]
                                                              : Colors.white,
                                                          onPressed: () {
                                                            Provider.of<AdminMood>(context, listen: false)
                                                                .changeIsAdmin(false);
                                                          },
                                                          child: Text(
                                                            'I\'m user',
                                                            style: TextStyle(
                                                                color:
                                                                    Provider.of<AdminMood>(context).isAdmin
                                                                        ? Colors.blue[900]
                                                                        : Colors.white,
                                                                fontSize: 18),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              }
                            
                              void _validate(BuildContext context) async {
                                final modelhud = Provider.of<ModelHud>(context, listen: false);
                               modelhud.changeisLoading(true);
                                if (_globalKey.currentState.validate()) {
                                  _globalKey.currentState.save();
                                  if (Provider.of<AdminMood>(context, listen: false).isAdmin) {
                                    if (_password == adminPassword) {
                                      try {
                                        await _auth.signIn(_email, _password);
                                        Navigator.pushNamed(context, AdminHome.id);
                                      } catch (e) {
                                        modelhud.changeisLoading(false);
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                         // backgroundColor: Colors.blue[200],
                                          content: Row(
                                            children: [
                                              Text(
                                                e.message,
                                              ),
                                              Icon(Icons.mood_bad, color: Colors.blue[900])
                                            ],
                                          ),
                                        ));
                                      }
                                    } else {
                                      modelhud.changeisLoading(false);
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        //backgroundColor: Colors.blue[200],
                                        content: Row(
                                          children: [
                                            Text('Something is wrong'),
                                            Icon(Icons.mood_bad, color: Colors.blue[900])
                                          ],
                                        ),
                                      ));
                                    }
                                  }else{
                                  try {
                                   await _auth.signIn(_email, _password);
                                    Navigator.pushNamed(context, HomePage.id);
                                  } catch (e) {
                                    modelhud.changeisLoading(true);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      //backgroundColor: Colors.blue[200],
                                      content: Row(
                                        children: [
                                          Text(
                                            e.message,
                                          ),
                                          Icon(Icons.mood_bad, color: Colors.blue[900])
                                        ],
                                      ),
                                    ));
                                  }
                                  }
                                } modelhud.changeisLoading(false);
                              }
                            
                              void KeepUserLogedIn() async 
                              {
                                SharedPreferences preferences =await SharedPreferences.getInstance();
                                preferences.setBool(kKeepMeLoggedIn, KeepMeLogedIn);
                              }
}
