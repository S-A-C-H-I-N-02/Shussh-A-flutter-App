import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Shussh/Pages/gmap.dart';
import 'package:Shussh/Pages/locationPage.dart';
//import 'package:flutter_shush/Pages/locationPage.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter/services.dart';
import 'package:Shussh/Animation/FadeAnimation.dart';
import 'package:Shussh/Pages/main_drawer.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/sound_profiles.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _soundMode = 'Unknown';
  String _permissionStatus;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          //leading: Icon(Icons.menu),
          title: Text("Shussh ! - Home"),
        ),
        drawer: MainDrawer(),

        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.grey[900],
                    Colors.grey[900],
                    Colors.grey[900]
                  ]
              )
          ),




          child: SafeArea(
            child: Container(

              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage('assets/images/one.jpg'),
                            fit: BoxFit.cover
                        )
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                                Colors.black.withOpacity(1),
                                Colors.black.withOpacity(.4),
                              ]
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FadeAnimation(1,Text("Shussh !", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),), ),

                          SizedBox(height: 50),
                          Container(
                            height: 30,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[800],
                            ),
                            child: GestureDetector(
                              onTap: (){},//Should add the function to be called in here
                              child: Center(child: Text("Silence your Device",
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0
                                ),)),
                            ),),
                          SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Expanded(//The two widgets
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: .80,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                      children: <Widget>[
                                        Spacer(),
                                        Image.network('https://cdn4.iconfinder.com/data/icons/devices-24/64/iphone_flip-512.png'),
                                        Spacer(),
                                        Text('Flip Your Device' ,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18.0, color: Colors.black),
                                        ),


                                      ]
                                  )
                              ),
                            ),
                            GestureDetector(
                                onTap: navtolc,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                      children: <Widget>[
                                        Spacer(),

                                        Image.network('https://cdn0.iconfinder.com/data/icons/facebook-ui-glyph/48/Sed-21-512.png'),
                                        Spacer(),
                                        Text('Location' ,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 18.0, color: Colors.black),
                                        ),
                                      ]

                                  ),
                                ))
                          ]
                      )
                  )
                ],
              ),
            ),
          ),)
    );
  }

  void navtolc() async{

    Navigator.push(context, MaterialPageRoute(builder: (context) => LcPage()));
  }

  /*void startServiceInPlatform() async {
    if(Platform.isAndroid){
      var methodChannel = MethodChannel("com.retroportalstudio.messages");
      String data = await methodChannel.invokeMethod("startService");
      debugPrint(data);
    }
  }*/


  List<double> _accelerometerValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions = <StreamSubscription<dynamic>>[];
  @override
  void initState() {
    super.initState();
    //Accelerometer events
    _streamSubscriptions.add(accelerometerEvents.listen((AccelerometerEvent event) {
      double x = event.x;
      double y = event.y;
      setState(() async {
        _accelerometerValues = <double>[event.x, event.y, event.z];
        if(x < 1 && x > -1 && y < 1 && y > -1){
          String message;

          try {
            message = await SoundMode.setSoundMode(Profiles.SILENT);

            setState(() {
              _soundMode = message;
            });
          } on PlatformException {
            print('Do Not Disturb access permissions required!');
          }//startServiceInPlatform();
        } else{
          String message;

          try {
            message = await SoundMode.setSoundMode(Profiles.NORMAL);
            setState(() {
              _soundMode = message;
            });
          } on PlatformException {
            print('Do Not Disturb access permissions required!');
          }
        }
      });
    }));

  }
}