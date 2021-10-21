import 'package:c19/Utils/c19_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountrySummary extends StatelessWidget {

  final String title;
  final int amount;
  final Color color;

  const CountrySummary({required this.title, required this.amount, required this.color, Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 120,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.14),
              offset: Offset(0, 0.5),
              blurRadius: 1.2,
              spreadRadius: 0
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title.toUpperCase(), style: const TextStyle(color: C19Colors.quickSilver)),
          const SizedBox(height: 20),
          Text('$amount', style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 25))
        ],
      ),
    );
  }



}