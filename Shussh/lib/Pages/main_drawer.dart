import 'package:flutter/material.dart';
import 'package:Shussh/Pages/LoginPage.dart';
import 'package:Shussh/Pages/home.dart';


class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Drawer(


      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.grey[900],
            child: Center(

              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage('https://th.bing.com/th/id/OIP.6qHDJF8Tc0NOMgaWlq8VkQHaHa?pid=Api&rs=1'),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                  Text('Pragadeeshwar',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      )
                  ),
                  Text('npragadeeshwar@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                      )
                  )
                ],
              ),
            )
          ),
          ListTile(
            leading: Icon(Icons.home),
            title:Text(
              'Home',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title:Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              } ,// REDIRECTS to login page
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title:Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));},
          )
        ],
      ),

    );
  }
}
