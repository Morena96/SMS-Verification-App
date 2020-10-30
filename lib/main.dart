//Test for branches and pulling merging
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms/sms.dart';
import 'package:smsVerify/sms.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  postAddress(String address) async {
    String url = 'https://example.com';
    try {
      await http.post(
        url,
        body: json.encode({
          "telefony": address,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      //final responseData = json.decode(response.body);
    } catch (e) {
      throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
//    postAddress('+99362749266');
    SmsReceiver _receiver = SmsReceiver();
    _receiver.onSmsReceived.listen(
      (SmsMessage _message) {
        postAddress(_message.address);
        setState(() {
//          _threads.insert(0, SmsThread.fromMessages([_message]));
        });
        Fluttertoast.showToast(
          msg: _message.address + " belgiden sms geldi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: null)
          ],
          centerTitle: true,
          title: Text('SMS Verify'),
        ),
        body: SmsLer(),
      ),
    );
  }
}
