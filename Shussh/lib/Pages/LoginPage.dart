import 'package:flutter/material.dart';
import 'package:Shussh/Animation/FadeAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Shussh/Pages/home.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //appBar: AppBar(backgroundColor: Colors.black,),
      body: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                  Colors.grey[900],
                  Colors.grey[900],
                  Colors.grey[800]
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          1.3,
                          Text(
                            "Welcome Back",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(

                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 60,
                            ),
                            FadeAnimation(
                                1.4,
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                225, 95, 27, .3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10))
                                      ]),


                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextFormField(
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'Provide an Email';
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Email ID",
                                              hintStyle:
                                              TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                          onSaved: (input) => _email = input,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextFormField(
                                            validator: (input) {
                                              if (input.length < 6) {
                                                return 'Longer Password please';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle:
                                                TextStyle(color: Colors.grey),
                                                border: InputBorder.none),
                                            onSaved: (input) =>
                                            _password = input
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 40,
                            ),

                            /*FadeAnimation(
                                1.5,
                                GestureDetector(
                                    onTap: forgot(_email),
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(color: Colors.grey),
                                    ))),*/
                            SizedBox(
                              height: 40,
                            ),
                            FadeAnimation(
                                1.6,
                                GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                                    },
                                    child: Container(
                                      height: 50,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 50),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              50),
                                          color: Colors.grey[900]),
                                      child: Center(
                                        child: Text(
                                          "Sign in",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),

                                      ),
                                    ))),
                            SizedBox(
                              height: 50,
                            ),
                            /*FadeAnimation(
                                1.7,
                                Text(
                                  "Continue with social media",
                                  style: TextStyle(color: Colors.grey),
                                ))*/
                            SizedBox(
                              height: 30,
                            ),
                            /*Row(S
                              children: <Widget>[
                                Expanded(
                                  child: FadeAnimation(
                                      1.8,
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                50),
                                            color: Colors.blue),
                                        child: Center(
                                          child: Text(
                                            "Facebook",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: FadeAnimation(
                                      1.9,
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                50),
                                            color: Colors.green),
                                        child: Center(
                                          child: Text(
                                            "Google",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            )*/
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void fp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        /*final FirebaseUser user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password))
            .user;*/
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomePage()));

      } catch (e) {
        print(e.message);
      }
    }
  }
}
