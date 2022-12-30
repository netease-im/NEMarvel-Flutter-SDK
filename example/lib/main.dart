import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:marvelflutter/marvelflutter.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    //获取 widget build 过程中出现的异常错误
   Marvelflutter.recordFlutterFatalError(details);
  };
  runZonedGuarded(
    () {
        runApp(const MyApp());
    },
    (error, stackTrace) {
      //没被我们catch的异常
      FlutterErrorDetails details =  FlutterErrorDetails(stack: stackTrace, exception: error);
      Marvelflutter.recordFlutterFatalError(details);

    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _marvelflutterPlugin = Marvelflutter();
  
  @override
  void initState() {
    dynamic flag = true;
    print(flag++);
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _marvelflutterPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
