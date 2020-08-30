import 'package:flutter/material.dart';
import 'package:shopping/provider/modelhud.dart';
import 'package:shopping/screen/user/homepage.dart';
import 'package:shopping/services/auth.dart';
import 'package:shopping/wedgit/custom_textfield.dart';
import 'package:shopping/wedgit/customlogo.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey <FormState> _globalKey =  GlobalKey <FormState> ();
  static String id = 'SignUpScreen';
  String _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
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
                  onclick: (value){
                   
                  },
                  hint: "Enter your name", icon: Icons.perm_identity),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  onclick: (value){
                    _email=value;
                  },
                  hint: 'Enter your email', icon: Icons.email),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  onclick: (value){
                    _password=value;
                  },
                  hint: 'Enter your password', icon: Icons.lock),
                SizedBox(
                  height: height * .02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120),
                  child: Builder(
                        builder:(context)=> FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.blue[200],
                        onPressed: () async{
                    final modelhud =  Provider.of<ModelHud>(context, listen: false);
                      modelhud.changeisLoading(true);
                         if( _globalKey.currentState.validate()){
                           //do somthing
                           _globalKey.currentState.save();
                           
                           try{
                           final authResult = await _auth.signUp(_email, _password);
                           modelhud.changeisLoading(true);
                           print(authResult.user.uid);
                           Navigator.pushNamed(context, HomePage.id);
                           }catch(e){
                             modelhud.changeisLoading(true);
                             Scaffold.of(context).showSnackBar(SnackBar(
                               //backgroundColor: Colors.blue[200],
                               content: Row(
                                 children: [
                                   Text(e.message,),
                                   Icon(Icons.mood_bad,color:Colors.blue[900])
                                 ],
                               ),
                               
                             ));
                           }
                         }
                         modelhud.changeisLoading(false);
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 20, color: Colors.blue[900]),
                        )),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Do you have an account ? ",
                        style: TextStyle(color: Colors.blue[400], fontSize: 18)),
//الويدجت  دي بتسمحلي اخلي التيكست زي اللينك بفضل اون تاب بتاعتها
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Text("Log in",
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 18,
                              decoration: TextDecoration.underline)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    
  }
}
