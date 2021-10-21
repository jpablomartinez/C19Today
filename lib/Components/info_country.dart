import 'dart:ui';

import 'package:c19/Classes/country.dart';
import 'package:c19/Utils/c19_colors.dart';
import 'package:c19/Utils/global_functions.dart';
import 'package:flutter/material.dart';

class InfoCountry extends StatelessWidget{

  final Country country;
  final int index;

  const InfoCountry({required this.country, required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Navigator.pushNamed(context, '/summary', arguments: {'country':country}),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.14),
                offset: Offset(0, 0.5),
                blurRadius: 1.2,
                spreadRadius: 0
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('$index', style: const TextStyle(color: C19Colors.leatherJacket, fontSize: 22, fontWeight: FontWeight.w500)),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 40,
                  height: 40,
                  color: Colors.red,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(GlobalFunctions.parseCountryName(country.name), style: const TextStyle(color: C19Colors.leatherJacket, fontSize: 18, fontWeight: FontWeight.w500)),
                    Text('confirmados: ${country.totalConfirmed}', style: const TextStyle(color: C19Colors.quickSilver, fontSize: 12, fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_sharp, color: C19Colors.leatherJacket, size: 20)
          ],
        ),
      ),
    );
  }

}