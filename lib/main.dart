import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Container(
            child: SpinWheel(
              Image.asset('assets/images/spin-wheel.png'),
              width: 310,
              height: 310,
            ),
          ),
        ),
      ),
    );
  }

}

class SpinWheel extends StatefulWidget {
  late final double width;
  late final double height;
  final Image image;

  SpinWheel(this.image, {required this.height, required this.width});

  @override
  State<StatefulWidget> createState() {
    return SpinWheelState();
  }
}

class SpinWheelState extends State<SpinWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation = Tween(begin: 0.0, end: 1.0 ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.fastLinearToSlowEaseIn));
  }

  startOrStop(){
    print('StartOrStop ${animationController.status} - ${animationController.isAnimating}');
    if(animationController.isAnimating){
      animationController.stop();
    }else{
      animationController.reset();
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 30),
      Container(
        height: widget.height,
        width: widget.width,
        child: AnimatedBuilder(
          animation: animation,
          child: Container(child: widget.image),
          builder: (context, child){
            return Transform.rotate(angle: animation.value * 10, child: child);
          },
        ),
      ),
      SizedBox(height: 30),
      ElevatedButton(
        onPressed: startOrStop,
        child: Text('Start/Stop')
      )
    ]);
  }
}
