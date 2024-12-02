// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_icon_dynamic/flutter_icon_dynamic.dart';

const List<String> iconsIOS = <String>[
  'sncf-connect',
  'sncf-connect-green',
  'sncf-connect-yellow',
  'should-throw-error'
];

const List<String> iconsAndroid = <String>[
  'appicon.sncf_connect',
  'appicon.sncf_connect_green',
  'appicon.sncf_connect_yellow',
  'sncf.connect.tech.flutter_icon_dynamic_example.MainActivity'
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String dropdownValue = Platform.isIOS ? iconsIOS.first : iconsAndroid.first;
  final _flutterIconDynamicPlugin = FlutterIconDynamic();

  @override
  void initState() {
    super.initState();
  }

  Future<void> changeIcon(String icon, BuildContext context) async {
    try {
      final value = await _flutterIconDynamicPlugin.setIcon(icon, androidIcons: iconsAndroid);
      if (value) {
        showSnackBar(context, 'Icon changed to $icon');
      } else {
        showSnackBar(context, 'Failed to change icon to $icon');
      }
    } catch (e) {
      showSnackBar(context, 'Failed to change icon to $icon: $e');
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final icons = Platform.isIOS ? iconsIOS : iconsAndroid;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<bool>(
                  future: _flutterIconDynamicPlugin.isSupported,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text("Is custom icons supported: ${snapshot.data}");
                    }
                  },
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) async {
                    setState(() {
                      dropdownValue = value!;
                    });
                    await changeIcon(value!, context);
                  },
                  items: icons.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
