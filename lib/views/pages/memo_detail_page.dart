import 'package:flutter/material.dart';

import '../../storage/DBMemo.dart';

class MemoDetailPage extends StatefulWidget {
  final arguments;

  const MemoDetailPage({this.arguments});

  @override
  _MemoDetailPageState createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  late Map _request;
  String displayMemo = '';

  @override
  void initState() {
    super.initState();
    _request = Map<String, dynamic>.from(widget.arguments);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細'),
        leading: IconButton(
          icon: const Icon(Icons.list),
          iconSize: 30,
          onPressed: () =>
              setState(() {
                Navigator.pushNamed(context, '/memo_list');
              }),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(displayMemo),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/memo_update',
                        arguments: {'doc_id': _request['doc_id']});
                  },
                  child: const Text('変更'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog<int>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: const Text('削除してもいいですか？'),
                            actions: <Widget>[
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(1);
                                },
                                child: const Text('キャンセル'),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  DBMemo dbMemo = DBMemo();
                                  dbMemo.delete(_request['doc_id']);
                                  Navigator.pushNamed(context, '/memo_list');
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        });
                  },
                  child: const Text('削除'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void load() async {
    DBMemo dbMemo = DBMemo();
    var memo = await dbMemo.get(_request['doc_id']);
    displayMemo = memo!['memo'];
    setState(() {});
  }
}
