import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onclick;

    String _errorMessage(String str) {
    switch (hint) {
      case 'Enter your name':
        return 'Name is empty !';
      case 'Enter your email':
        return 'Email is empty !';
      case 'Enter your password':
        return 'Password is empty !';
    }
  }

  const CustomTextField({@required this.onclick,  @required this.hint, @required this.icon}) ;

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return _errorMessage(hint);
                }
                
              },
              onSaved: onclick,
              obscureText: hint == 'Enter your password' ? true : false,
              cursorColor: Colors.blue[900],
                decoration: InputDecoration(
                  hintText: hint,
                  prefixIcon: Icon(icon, color: Colors.blue,),
                  filled: true,
                  fillColor: Colors.blue[50],
                  
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue[900],width: 1.5)),
                  focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue[700])),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue[700])),
            )),
          );
  }
}