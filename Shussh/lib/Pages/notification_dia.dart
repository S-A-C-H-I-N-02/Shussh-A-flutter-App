import 'package:flutter/material.dart';
import 'package:Shussh/Pages/locationPage.dart';
import 'package:intl/intl.dart';

Future<TimeOfDay> _selectTime(BuildContext context,
    {@required DateTime initialDate}) {
  final now = DateTime.now();

  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: initialDate.hour, minute: initialDate.minute),
  );
}

Future<DateTime> _selectDateTime(BuildContext context,
    {@required DateTime initialDate}) {
  final now = DateTime.now();
  final newestDate = initialDate.isAfter(now) ? initialDate : now;

  return showDatePicker(
    context: context,
    initialDate: newestDate.add(Duration(seconds: 1)),
    firstDate: now,
    lastDate: DateTime(2100),
  );
}

Dialog showDateTimeDialog(
    BuildContext context, {
      @required ValueChanged<DateTime> onSelectedDate,
      @required DateTime initialDate,
    }) {
  final dialog = Dialog(
    child: DateTimeDialog(
        onSelectedDate: onSelectedDate, initialDate: initialDate),
  );

  showDialog(context: context, builder: (BuildContext context) => dialog);
}

class DateTimeDialog extends StatefulWidget {
  final ValueChanged<DateTime> onSelectedDate;
  final DateTime initialDate;
  final positions1;

  const DateTimeDialog({
    @required this.onSelectedDate,
    @required this.initialDate,
    this.positions1,
    Key key,
  }) : super(key: key);
  @override
  _DateTimeDialogState createState() => _DateTimeDialogState(positions1);
}

class _DateTimeDialogState extends State<DateTimeDialog> {
  DateTime selectedDate;
  var positions1;
  _DateTimeDialogState( this.positions1);

  @override
  void initState() {
    super.initState();

    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),

    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Select Date and Time',
          style: Theme.of(context).textTheme.title,
        ),
        const SizedBox(height: 16),


        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton.extended(
              label: Text(DateFormat('yyyy-MM-dd').format(selectedDate), style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.white,
              onPressed: () async {
                final date = await _selectDateTime(context,
                    initialDate: selectedDate);
                if (date == null) return;

                setState(() {
                  selectedDate = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    selectedDate.hour,
                    selectedDate.minute,
                  );
                });

                widget.onSelectedDate(selectedDate);
              },
            ),
            const SizedBox(width: 8),
            FloatingActionButton.extended(
              label: Text(DateFormat('HH:mm').format(selectedDate), style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.white,
              onPressed: () async {
                final time =
                await _selectTime(context, initialDate: selectedDate);
                if (time == null) return;

                setState(() {
                  selectedDate = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    time.hour,
                    time.minute,
                  );
                });

                widget.onSelectedDate(selectedDate);
              },
            ),

          ],
        ),
        const SizedBox(height: 16),
        FloatingActionButton.extended(
          label: Text('Done'),
          backgroundColor: Colors.black,

          onPressed: () {
            print(selectedDate);
            var value = 1;

            print(DateTime.now());
            print("Sucessfully added!");
            print("Position:");
            print(positions1);
            Navigator.push(
              context,
                MaterialPageRoute(builder: (context) => LcPage(value: value, selectedDate : selectedDate,positions1: positions1 )),
            );
          },
          //highlightColor: Colors.orange,
        ),
      ],
    ),
  );
}