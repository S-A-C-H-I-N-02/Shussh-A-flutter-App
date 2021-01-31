//import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/sound_profiles.dart';
import 'package:Shussh/Pages/notification_dia.dart';
import 'package:intl/intl.dart';



class Gmap extends StatefulWidget {

  final title;
  Gmap({Key key, @required this.title}) : super(key: key);

  @override
  _GmapState createState() => _GmapState(title);

}

class _GmapState extends State<Gmap> {

  String title;
  _GmapState(this.title);
  Set<Marker> markers;
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
  String _soundMode = 'Unknown';
  String _permissionStatus;
  DateTime selectedDate = DateTime.now();


  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

  }
void initState(){
    super.initState();
    markers = Set.from([]);
}

void _getCurrentLocation()async{

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print("My Location value");
    print(position);
    var dtn = DateTime.now();
    var dt = selectedDate;
  if(position == positions1 && dtn.isBefore(dt)){
    String message;

    try {
      message = await SoundMode.setSoundMode(Profiles.NORMAL);
      setState(() {
        _soundMode = message;
      });
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
    print('HELLLLLO');

  }else{
    String message;

    try {
      message = await SoundMode.setSoundMode(Profiles.NORMAL);
      setState(() {
        _soundMode = message;
      });
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
    print('Helllo');
  }

  }


  var positions1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Map'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(13.0391, 80.1419) ,
              zoom: 13,

            ),
            markers: markers,
            onTap:(position1){
              Marker mk1 = Marker(
                markerId: MarkerId('1'),
                position: position1,
              );

              setState(() {
                markers.add(mk1);
              });
              if(markers.length<1)
                print("No marker added");
                positions1=markers.first.position;
              print(positions1);
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              children: <Widget>[
                FloatingActionButton.extended(
                   icon: Icon(Icons.location_on),
                   backgroundColor: Colors.grey[900],
                   label: Text('Select Position'),
                  onPressed: () async{
                   /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DateTimeDialog(positions1: positions1,)),
                    );*/
                   print('GMAPSTATEMENT');
                    print(title); //title should be passes to notification dialog page
                    print(selectedDate);
                     _getCurrentLocation();
                     showDateTimeDialog(context, initialDate: selectedDate,
                         onSelectedDate: (selectedDate) {
                           setState(() {

                             this.positions1 = positions1;
                             this.selectedDate = selectedDate;

                           });
                         });

                  },
                ),


              ]

            ),

          )


        ],
      ),
    );
  }

}
