import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleWaveSliderAnimation extends StatefulWidget {
  final bool isPlayer;
  final List<double> datas;
  final Duration? duration;
  const SimpleWaveSliderAnimation(
      {Key? key, required this.isPlayer, required this.datas, this.duration})
      : super(key: key);

  @override
  _SimpleWaveSliderAnimationState createState() =>
      _SimpleWaveSliderAnimationState();
}

class _SimpleWaveSliderAnimationState extends State<SimpleWaveSliderAnimation> {
  final ScrollController _controller = ScrollController();
  late final List<double> data;
  final innerData = <double>[];
  late Duration duration;
  late bool isPlayer;
  Timer? timer;
  var isFirst = true;
  @override
  void initState() {
    super.initState();
    data=widget.datas;
    isPlayer = widget.isPlayer;
    for (int i = 0; i < 50; i++) {
      data.add(10);
    }
    if (widget.duration == null) {
      duration = const Duration(milliseconds: 1000 ~/ 5);
    } else {
      duration = widget.duration!;
    }
    Timer.periodic(duration, (timer) async {
      data.add(Random().nextInt(50).toDouble());
      data.removeAt(0);
      var maxExtent = _controller.position.maxScrollExtent;
      _controller.jumpTo(maxExtent);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
        height: 100,
        child: SingleChildScrollView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                    data.length,
                    (index) => Container(
                          height: data[index],
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 3,
                          decoration: const BoxDecoration(color: Colors.black),
                        ))),
          ),
        ),
      ),
    ));
  }
}
