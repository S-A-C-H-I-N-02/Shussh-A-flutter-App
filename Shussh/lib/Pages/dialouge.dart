import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gmap.dart';

enum DialogAction { yes, abort }

class Dialogs {

  static Future<DialogAction> yesAbortDialog(
      BuildContext context,
      String title1,
      String body,
      String title
      ) async {
    final action = await showDialog(
      context: context,

      barrierDismissible: false,
      builder: (BuildContext context) {
        TextEditingController customController = TextEditingController();
        //String title;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title1),
          content: TextFormField(
            controller: customController,

            decoration: InputDecoration(
                hintText: "Location",
                hintStyle: TextStyle(color: Colors.grey),
                ),

          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                title = customController.text;
                Navigator.pop(context, title);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Gmap()));
                },
              child: const Text('Set Location'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}