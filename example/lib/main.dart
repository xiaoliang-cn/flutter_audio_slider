import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audio_slider/audio_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? timer;
  List<double> valueData = <double>[];
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      valueData.add(20+Random().nextInt(5).toDouble());
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: CopyXiaoMiSliderWidget(
            datas: valueData,
            isPlayer: true,
            duration: const Duration(milliseconds: 333),
          ),
          //  child: SimpleWaveSliderAnimation(
          //   datas: valueData,
          //   isPlayer: true,
          //   duration: const Duration(milliseconds: 333),
          // ),
        ),
      ),
    );
  }
}
