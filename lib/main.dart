// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:demo_blutooth_print/home_page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

var sdkInt;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    sdkInt = androidInfo.version.sdkInt;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
