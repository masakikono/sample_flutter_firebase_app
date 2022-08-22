import 'package:flutter/material.dart';

import '../../storage/DBMemo.dart';
import '../widgets/ShowDialog.dart';

class MemoUpdatePage extends StatefulWidget {
  final arguments;

  const MemoUpdatePage({this.arguments});

  @override
  _MemoUpdatePageState createState() => _MemoUpdatePageState();
}

class _MemoUpdatePageState extends State<MemoUpdatePage> {
  late Map _request;
  String memo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('変更'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              maxLength: 50,
              controller: TextEditingController(text: memo),
              onChanged: (value) {
                memo = value;
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  if (memo == '') {
                    ShowDialog.displayConfirmDiaolg(context, 'エラーメッセージ');
                  } else {
                    DBMemo dbMemo = DBMemo();
                    dbMemo.update(_request['doc_id'], memo);
                    Navigator.pushNamed(context, '/memo_detail', arguments: {
                      'doc_id': _request['doc_id'],
                    });
                  }
                },
                child: const Text('変更')),
          ],
        ),
      ),
    );
  }

  void load() async {
    DBMemo dbMemo = DBMemo();
    var data = await dbMemo.get(_request['doc_id']);
    memo = data![''];
    setState(() {});
  }
}
