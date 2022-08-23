import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../storage/DBMemo.dart';

class MemoListPage extends StatefulWidget {
  final arguments;

  const MemoListPage({this.arguments});

  @override
  _MemoListPageState createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  
  List displayMemoList = [];
  
  @override
  void initState() {
    super.initState();
    _load();
  }
  
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar(reason: SnackBarClosedReason.action);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('一覧'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          iconSize: 30,
          onPressed: () {
            setState(() {
              Navigator.pushNamed(context, '/top');
            });
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          ((){
            if(displayMemoList.isNotEmpty) {
              return Expanded(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    child:  SingleChildScrollView(
                      child:  SizedBox(
                        child: ListView.builder(itemBuilder: itemBuilder),
                      ),
                    ),
                  ))
            }
          })
        ],
      ),
    );
  }
}
