import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms/sms.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SmsReceiver _receiver = SmsReceiver();
    _receiver.onSmsReceived.listen(
      (SmsMessage _message) {
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

class SmsLer extends StatefulWidget {
  @override
  _SmsLerState createState() => _SmsLerState();
}

class _SmsLerState extends State<SmsLer> {
  List<SmsThread> _threads;
  List<String> aylar = [
    'ýanwar',
    'fewral',
    'mart',
    'aprel',
    'maý',
    'iýun',
    'iýul',
    'awgust',
    'sentýabr',
    'oktýabr',
    'noýabr',
    'dekabr',
  ];

  ahaha() async {
    SmsQuery query = SmsQuery();
    _threads = await query.getAllThreads;
  }

  // bool _isInit = true;
  // bool _isLoading = false;
  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     ahaha().then((e) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //     _isInit = false;
  //     super.didChangeDependencies();
  //   }
  // }

  wagty(DateTime a) {
    return aylar[a.month - 1] + ' ' + a.day.toString();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: ahaha(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (BuildContext context, i) {
                    return ListTile(
                      title: Text(_threads[i].address),
                      leading: CircleAvatar(
                        radius: _width * 0.08,
                        child: _threads[i].contact.fullName == null
                            ? Icon(
                                Icons.person_outline,
                                size: 35,
                              )
                            : _threads[i].contact.thumbnail == null
                                ? Text(
                                    _threads[i].contact.fullName[0],
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  )
                                : ClipOval(
                                    child: Image.memory(
                                      _threads[i].contact.thumbnail.bytes,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                      ),
                      subtitle: Text(
                        _threads[i].messages[0].body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(wagty(_threads[i].messages[0].date)),
                    );
                  },
                  itemCount: _threads.length,
                ),
    );
  }
}
