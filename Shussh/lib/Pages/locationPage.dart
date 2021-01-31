import 'package:flutter/material.dart';
import 'package:Shussh/Animation/FadeAnimation.dart';
import 'package:Shussh/Pages/gmap.dart';
import 'package:Shussh/Pages/dialouge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Shussh/Pages/notification_dia.dart';

class LcPage extends StatefulWidget {
  final int value;
  final positions1;
  final DateTime selectedDate;
  LcPage({Key key, @required this.value,this.selectedDate, this.positions1}) : super(key: key);
  @override
  _LcPageState createState() => _LcPageState(value, positions1, selectedDate);

}
class _LcPageState extends State<LcPage> {
  var positions1;
  var tel;
  int value;
  DateTime selectedDate;
  _LcPageState(this. value,this. positions1,this. selectedDate);

  bool tappedYes = false;
  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;

  Card buildItem(DocumentSnapshot doc) {                                                                                       //FROM HEREEEEEE
    return Card(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(// color of the card should be changed
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Location Name : ${doc.data['Location Name']}',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              'End-Time : ${doc.data['Date and Time']}',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            /*Text(
              'Position : ${doc.data['LatLong']}',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),*/
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => updateData(doc),
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                FlatButton(
                  onPressed: () => deleteData(doc),
                  child: Text('Delete'),
                  color: Colors.grey
                ),
              ],
            )
          ],
        ),
      ),
    );                                                                                                                                //TO HEREEEEEE
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.grey[900],
                  Colors.grey[900],
                  Colors.grey[900]
                ],
            )
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 80,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(1, Text("Silence Your Device.", style: TextStyle(color: Colors.white, fontSize: 35),)),
                    SizedBox(height: 10,),
                    FadeAnimation(1.3, Text("By Location and Time",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(

                child: Container(

                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))
                  ),

                 child: Column(
                   children: <Widget>[
                     Container(
                       child:StreamBuilder<QuerySnapshot>(                                                   //The DATABASE is created
                    stream: db.collection('shush').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(children: snapshot.data.documents.map((doc) => buildItem(doc)).toList());          //THIS LINE ADDS THE NEW ENTERED DATA TO THE LIST IN THE LOCATION PAGE.
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                     )
                ]
                 )
                ),
              ),
            ]
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Text('+', style: TextStyle( fontSize: 30.0)),
        onPressed: () async{
          //var data = await showDialog(

          final action = await Dialogs.yesAbortDialog(context, 'Name of the Location', 'My Body',tel);
           if (action == DialogAction.yes) {
             setState(() => tappedYes = true);
           } else {
             setState(() => tappedYes = false);
            }
        }

      ),
    );
  }

     @override
  void initState() {
    super.initState();
    if(value == null){
      value = 2;
      print('THE VALUE IS FALSEEEEE');

    }
    else {
      createData();
      print('WORKING');
    }

    print(value);
    print(tel);
    print('NO MEANS NO');
    print(positions1);
    print(selectedDate);
   }



  void createData() async {
    //The data is added to the FIRESTORE DATABASE
    print('working evruvrnvnerfhmr8fhiwdj cyrf reuhd');
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        DocumentReference ref = await db.collection('shush').add(
            {'Location Name': name ,'DateTime': selectedDate });// 'LatLong': LcPage().positions1 ,'DateTime': LcPage().selectedDate
        setState(() => id = ref.documentID);
        print(ref.documentID);
      }
    }

  void readData() async {
    DocumentSnapshot snapshot = await db.collection('shush').document(id).get();                //Printing the data to the console
    print(snapshot.data['name']);
  }

  void updateData(DocumentSnapshot doc) async {
    await db.collection('shush').document(doc.documentID).updateData({'todo': 'please'});   //UPDATE existing data.
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('shush').document(doc.documentID).delete();                          //DELETEING data.
    setState(() => id = null);
  }
}
