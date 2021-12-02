import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CopyXiaoMiSliderWidget extends StatefulWidget {
  final bool isPlayer;
  final List<double> datas;
  final Duration? duration;
  const CopyXiaoMiSliderWidget(
      {Key? key, required this.isPlayer, required this.datas, this.duration})
      : super(key: key);

  @override
  _CopyXiaoMiSliderWidgetState createState() => _CopyXiaoMiSliderWidgetState();
}

class _CopyXiaoMiSliderWidgetState extends State<CopyXiaoMiSliderWidget> {
  late final List<double> data;
  final innerData = <double>[];
  late Duration duration;
  late bool isPlayer;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isPlayer = widget.isPlayer;
    data = widget.datas;
    if (widget.duration == null) {
      duration = const Duration(milliseconds: 100);
    } else {
      duration = widget.duration!;
    }
    initData();
  }

  void initData() async {
    for (int i = 0; i < 50; i++) {
      if (i % 2 == 0) {
        innerData.add(5);
      } else {
        innerData.add(8);
      }
    }
    data.addAll(innerData);
    timer =
        Timer.periodic(duration, (timer) {
      if (!isPlayer) {
        return;
      }
      if (data.length >= 50) {
        data.removeAt(0);
      }
      if (innerData.length >= 50) {
        innerData.removeAt(0);
      }
      setState(() {
        innerData.add(5 + Random().nextInt(5).toDouble());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: CustomPaint(
                        painter: _CopyXiaoMiRecorderSlider(heights: data),
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 200,
                        )),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: CustomPaint(
                        painter: _CopyXiaoMiRecorderSlider(
                          heights: innerData,
                          changeless: true,
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 200,
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CopyXiaoMiRecorderSlider extends CustomPainter {
  final List<double> heights;
  final bool changeless;
  _CopyXiaoMiRecorderSlider({required this.heights, this.changeless = false});

  @override
  void paint(Canvas canvas, Size size) {
    final mPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;
    var minWidht = size.width / 50;
    if (changeless) {
      canvas.drawLine(
          Offset(0, size.height / 2 - 60),
          const Offset(0, 160),
          Paint()
            ..color = Colors.grey.withAlpha(100)
            ..strokeWidth = 2);
      mPaint.color = Colors.grey;
    }
    for (int i = 1; i < heights.length; i++) {
      // print(heights[i]);
      canvas.drawLine(Offset(minWidht * i, size.height / 2 - heights[i]),
          Offset(minWidht * i, (size.height / 2 + heights[i])), mPaint);

      // canvas.drawCircle(
      //     Offset(minWidht * i, size.height / 2 - heights[i] + 1), 0.5, mPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CopyXiaoMiRecorderSlider oldDelegate) {
    return true;
  }
}
