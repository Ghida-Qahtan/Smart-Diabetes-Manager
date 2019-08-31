import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/styles.dart';
import 'package:intl/intl.dart' as intl;

class Pressureinput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF2A79D2), //Color(0xFF7EAFE5),
            automaticallyImplyLeading: false,
            brightness: Brightness.light,
            title: new Text(
              'اضافة وزن',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          ),
          body: new SingleChildScrollView(child: new Body()),
        ));
  }
}

class Body extends StatefulWidget {
  @override
  State createState() => new Bodystate();
}

class Bodystate extends State<Body> {
  int pressureSys = 120;
  int pressureDia = 85;
  String evaluation = '';
  Color slider = Colors.greenAccent[400];
  DateTime dateTime = DateTime.now();
  String note = '';

  void _onChangedSys(e) {
    setState(() {
      if (e > 140 || e < 120) {
        slider = Colors.redAccent[400];
        evaluation = 'هذا ليس جيد';
      } else {
        slider = Colors.greenAccent[400];
        evaluation = 'هذا جيد';
      }
      pressureSys = e;
    });
  }

  void _onChangedDia(e) {
    setState(() {
      if (e > 90 || e < 80) {
        slider = Colors.redAccent[400];
        evaluation = 'هذا ليس جيد';
      } else {
        slider = Colors.greenAccent[400];
        evaluation = 'هذا جيد';
      }
      pressureDia = e;
    });
  }

  Widget _pressure() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.only(right: 50.0, top: 15.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new RichText(
            text: TextSpan(
              text: 'ضغط الدم ',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '(الانبساطي / الانقباضي)',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              _pressureBackground(_onChangedDia,pressureDia,110),
              Text(
                '\t/\t',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              _pressureBackground(_onChangedSys,pressureSys,180),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            evaluation,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: slider,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _pressureBackground(Function fun, pressure ,max) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Container(
          height: 90.0,
          width: 130.0,
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius: new BorderRadius.circular(
              (80.0),
            ),
          ),
          child: new Center(
            child: new Theme(
              data: ThemeData(
                accentColor: slider,
              ),
              child: new NumberPicker.horizontal(
                  initialValue: pressure,
                  minValue: 0,
                  maxValue: max,
                  itemExtent: 40,
                  onChanged: (e) => fun(e)),
            ),
          ),
        ),
        Icon(
          Icons.arrow_drop_up,
          color: slider,
          size: 40,
        ),
      ],
    );
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 8.0),
            new Text(
              'وقت القياس :',
              style: Styles.productRowItemName,
            ),
            Row(
              children: <Widget>[
                new Text(
                  '(',
                  style: Styles.productRowItemName,
                ),
                new IconButton(
                  icon: Icon(
                    CupertinoIcons.clock,
                    color: CupertinoColors.activeBlue,
                    size: 28,
                  ),
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return _cupDate();
                      },
                    );
                  },
                ),
                new Text(
                  ')',
                  style: Styles.productRowItemName,
                ),
                SizedBox(width: 10.0),
              ],
            ),
            new Text(
              intl.DateFormat.yMMMd().add_jm().format(dateTime),
              style: Styles.productRowItemName,
            ),
            SizedBox(width: 5.0)
          ],
        ),
      ],
    );
  }

  Widget _cupDate() {
    return CupertinoDatePicker(
      initialDateTime: dateTime,
      minimumDate: DateTime(2018),
      maximumDate: DateTime.now(),
      mode: CupertinoDatePickerMode.dateAndTime,
      onDateTimeChanged: (e) => setState(() {
        if (e.isAfter(DateTime.now())) {
          e = DateTime.now();
        }
        dateTime = e;
      }),
    );
  }

  Widget _buildNoteField() {
    return CupertinoTextField(
      prefix: const Icon(
        CupertinoIcons.pen,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'ملاحظات',
      onChanged: (e) => setState(() {
        note = e;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          _pressure(),
          SizedBox(height: 40.0),
          _buildDateAndTimePicker(context),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 70.0, horizontal: 10.0),
            child: _buildNoteField(),
          ),
          SizedBox(height: 20.0),
          new ButtonTheme.bar(
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: Text('تمام',
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                  onPressed: () => setState(() {}),
                ),
                SizedBox(width: 160.0),
                new FlatButton(
                  child: Text('الغاء',
                      style: TextStyle(fontSize: 20.0, color: Colors.red)),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
