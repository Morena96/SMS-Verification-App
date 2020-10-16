import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms/sms.dart';

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
