import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cache/CacheAppVersion.dart';

class VersionUpPage extends StatefulWidget {
  const VersionUpPage();

  @override
  _VersionUpPageState createState() => _VersionUpPageState();
}

class _VersionUpPageState extends State<VersionUpPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('バージョン更新のお知らせ'),
      content: const Text('新しいバージョンのアプリが利用可能です。ストアより更新版を入手して、ご利用ください。'),
      actions: <Widget>[
        TextButton(
            onPressed: () async {
              if (await canLaunchUrl(CacheAppVersion().downloadUrl)) {
                await launchUrl(
                  CacheAppVersion().downloadUrl,
                );
              } else {
                throw Error();
              }
            },
            child: const Text(
              'いますぐ更新',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
        ),
      ],
    );
  }
}