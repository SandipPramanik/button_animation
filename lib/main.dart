import 'package:flutter/material.dart';
import '';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Button Animation',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degreeOneTranslationAnimation,
      degreeTwoTranslationAnimation,
      degreeThreeTranslationAnimation;
  Animation rotationAnimation;

  final duration = Duration(milliseconds: 300);
  bool opened = false;
  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: duration)
          ..addListener(() {
            setState(() {});
          });
    degreeOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degreeTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degreeThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset.fromDirection(getRadiansFromDegree(330),
                      degreeOneTranslationAnimation.value * 100.0),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value))
                      ..scale(degreeOneTranslationAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      key: UniqueKey(),
                      height: 60.0,
                      width: 60.0,
                      color: Color(0xFF334A92),
                      icon: Icon(Icons.person, color: Colors.white,),
                      onPressed: () {},
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(getRadiansFromDegree(270),
                      degreeTwoTranslationAnimation.value * 100.0),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value))
                      ..scale(degreeTwoTranslationAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      key: UniqueKey(),
                      height: 60.0,
                      width: 60.0,
                      color: Colors.deepOrangeAccent[400],
                      icon: Icon(Icons.filter, color: Colors.white,),
                      onPressed: () {},
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset.fromDirection(getRadiansFromDegree(210),
                      degreeThreeTranslationAnimation.value * 100.0),
                  child: Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value))
                      ..scale(degreeThreeTranslationAnimation.value),
                    alignment: Alignment.center,
                    child: CircularButton(
                      key: UniqueKey(),
                      height: 60.0,
                      width: 60.0,
                      color: Colors.teal[700],
                      icon: Icon(Icons.add_shopping_cart, color: Colors.white,),
                      onPressed: () {},
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: duration,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: CircularButton(
                    key: UniqueKey(),
                    height: 80.0,
                    width: 80.0,
                    color: opened ? Colors.redAccent[700] : Colors.grey[800],
                    icon: Icon(
                      opened ? Icons.close : Icons.sort,
                      size: 40.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        opened = !opened;
                      });
                      if (animationController.isCompleted) {
                        animationController.reverse();
                      } else {
                        animationController.forward();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  CircularButton(
      {Key key, this.height, this.width, this.color, this.icon, this.onPressed})
      : super(key: key);
  final double height;
  final double width;
  final Color color;
  final Widget icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onPressed,
      ),
    );
  }
}
