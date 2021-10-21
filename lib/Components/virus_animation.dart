import 'package:c19/Utils/c19_colors.dart';
import 'package:flutter/material.dart';

class VirusAnimation extends StatefulWidget{

  const VirusAnimation({Key? key}) : super(key: key);

  @override
  _VirusAnimation createState()=> _VirusAnimation();

}

class _VirusAnimation extends State<VirusAnimation> with SingleTickerProviderStateMixin{

  AnimationController? animationController;
  Animation? animation;


  @override
  void initState(){
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 50.0, end: 70.0).animate(animationController!)
      ..addListener(() {setState(() {});})
      ..addStatusListener((status) { });
    animationController?.repeat();
    super.initState();
  }

  @override
  void dispose(){
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    child: Transform.scale(
                        scale: 1.5,
                        child: Image.asset('assets/images/virus.png', height: animation!.value, width:  animation!.value, color: C19Colors.leatherJacket)
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }


}