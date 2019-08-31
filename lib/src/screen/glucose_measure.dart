import 'package:flutter/material.dart'; // flutter main package
import 'dart:ui';
import '../widgets/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart' as intl; // flutter main package

class GlucoseMeasure extends StatelessWidget {
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
              'اضافة قراءة السكر',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          ),
          body: new SingleChildScrollView(child: new Body()),
          // Padding(padding: const EdgeInsets.only(top: 100), child: Body()),
        ));
  }
}

class Body extends StatefulWidget {
  @override
  State createState() => new Bodystate();
}

class Bodystate extends State<Body> {
  int gm = 180;
  DateTime dateTime = DateTime.now();
  String evaluation = '';
  Color slider = Colors.greenAccent[400];
  String note = '';
int slot = _slot();
  List<String> slots = const <String>[
    'قبل النوم',
    'بعد الاستيقاظ',
    'قبل الفطور',
    'بعد الفطور',
    'قبل الغداء',
    'بعد الغداء',
    'قبل العشاء',
    'بعد العشاء',
    'بعد الرياضة',
  ];

  static int _slot() {
    int slot;
    if (DateTime.now().hour >= 21 || DateTime.now().hour < 5) {
      slot = 0;
    } else if (DateTime.now().hour >= 5 && DateTime.now().hour < 7) {
      slot = 1;
    } else if (DateTime.now().hour >= 7 && DateTime.now().hour < 9) {
      slot = 2;
    } else if (DateTime.now().hour >= 9 && DateTime.now().hour < 12) {
      slot = 3;
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 14) {
      slot = 4;
    } else if (DateTime.now().hour >= 14 && DateTime.now().hour < 20) {
      slot = 5;
    } else if (DateTime.now().hour >= 20 && DateTime.now().hour < 23) {
      slot = 6;
    } else if (DateTime.now().hour >= 23 || DateTime.now().hour < 00) {
      slot = 7;
    }
    print(slot);
    return slot;
  }

  String message = 'ادخل نسبة الجولوكوز في الدم';

  void _changed(e) {
    setState(() {
      gm = e;
      if (gm < 90 || gm > 200) {
        slider = Colors.redAccent[400];
        evaluation = 'هذا ليس جيد، يجب عليك الانتباه';
      } else {
        slider = Colors.greenAccent[400];
        evaluation = 'هذا رائع انت تبلي جيدا';
      }
    });
  }
  Widget _glucose() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new RichText(
            text: TextSpan(
              text: 'نسبة السكر ',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '(الوحدة)',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          _glucoseBackground(),
          SizedBox(height: 10.0),
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

  Widget _glucoseBackground() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Container(
          height: 130.0,
          width: 190.0,
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
                textTheme: TextTheme(),
              ),
              child: new NumberPicker.horizontal(
                  initialValue: gm,
                  minValue: 17,
                  maxValue: 400,
                  itemExtent: 60,
                  onChanged: (e) => _changed(e)
                      )
                      ,
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
  
  Widget _mySlider() {
    return Column(
      children: <Widget>[
        new Slider(
          value: 50.3,
          onChanged: (double e) => _changed(e),
          activeColor: slider,
          inactiveColor: Colors.grey,
          divisions: 383,
          label: gm.round().toString(),
          max: 400.0,
          min: 17.0,
        ),
        new Text(
          message,
          style: Styles.productRowItemName,
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
        if(e.isAfter(DateTime.now())){ e = DateTime.now();}
        dateTime = e;
      }),
    );
  }

  Widget _buildSlotPicker(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 8.0),
            new Text(
              'فترة القياس :',
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
                    CupertinoIcons.info,
                    color: CupertinoColors.activeBlue,
                    size: 28,
                  ),
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return _cupPicker();
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
            SizedBox(width: 90.0),
            new Text(
              slots[slot],
              style: Styles.productRowItemName,
            ),
            SizedBox(width: 20.0),
          ],
        ),
      ],
    );
  }

  Widget _cupPicker() {
    return CupertinoPicker(
      itemExtent: 40.0,
      backgroundColor: Colors.white,
      children: new List<Widget>.generate(slots.length, (slot) {
        return new Center(
          child: new Text(
            slots[slot],
            style: Styles.productRowItemName,
          ),
        );
      }),
      onSelectedItemChanged: (e) => setState(() {
        slot = e;
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
          _glucose(),
          SizedBox(height: 40.0),
          _buildDateAndTimePicker(context),
          _buildSlotPicker(context),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 45.0, horizontal: 10.0),
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
