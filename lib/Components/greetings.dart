import 'package:c19/Utils/c19_colors.dart';
import 'package:flutter/material.dart';

class Greetings extends StatelessWidget{

  const Greetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 230,
      decoration: const BoxDecoration(
          color: C19Colors.leatherJacket,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)
          )
      ),
      child: Stack(
        children: [
          Positioned(
            top: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('C-19 Today', style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold)),
                Text('Last updated: one minute ago', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 10,
            child: Image.asset('assets/images/virus2.png', height: 80),
          ),
          const SizedBox(height: 10),
          Positioned(
            top: 85,
            left: 20,
            child: Row(
              children: [
                Image.asset('assets/images/dr.png', height: 110),
                const SizedBox(width: 10),
                const SizedBox(
                  width: 175,
                  child: Text('Si tienes síntomas recuerda llamar a tu respectivo centro de salud', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 15), textAlign: TextAlign.center,),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 5),
            child: const Text('#BeSafe', style: TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic)),
          )
        ],
      ),
    );
  }

}