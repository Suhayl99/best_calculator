
import 'package:best_calculator/change_theme.dart';
import 'package:best_calculator/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
late final AnimationController _controller;
  late Animation<AlignmentGeometry> _anim1;
  late Animation<AlignmentGeometry> _anim2;
  late Animation<AlignmentGeometry> _anim3;
  var top = const Alignment(0, -2);
  var middle = const Alignment(0, -0.2);
  var bottom = const Alignment(0, 2);
  var bottommiddle = const Alignment(0, 0.3);
  var left = const Alignment(-3, 0.1);
  var leftmiddle = const Alignment(0, 0.1);


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds:3 ));
      buildAnim();
  }




Future buildAnim() async {
      cupChangePostion();
      await Future.delayed(const Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Best Calculator'),));
      });
}


 cupChangePostion()  async{
       _anim1 =  Tween<AlignmentGeometry>(begin: top, end: middle ).animate(_controller);
       _anim2 = Tween<AlignmentGeometry>(begin: left, end: leftmiddle ).animate(_controller);
       _anim3 = Tween<AlignmentGeometry>(begin: bottom, end: bottommiddle ).animate(_controller);
    _controller.forward();
  }


  Future wait(double sec) => Future.delayed(Duration(milliseconds: (sec * 300).toInt()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: curWorkSpaceColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _anim1,
            builder: (context, child) {
              return AlignTransition(alignment: _anim1, child: child!);
            },
            child: Image.asset(
              'assets/best.png',
              width: 120,
              height: 120,
            ),
          ),
          AnimatedBuilder(
            animation: _anim2,
            builder: (context, child) {
              return AlignTransition(alignment: _anim2, child: child!);
            },
            child: const Text("Best calculator", style: TextStyle(fontSize: 24, color: Colors.black87),)
          ),
          AnimatedBuilder(
            animation: _anim3,
            builder: (context, child) {
              return AlignTransition(alignment: _anim3, child: child!);
            },
            child: Image.asset(
              'assets/logo.png',
              width: 80,
              height: 80,
            ),
          )
        ],
      ),
    );
  }
}