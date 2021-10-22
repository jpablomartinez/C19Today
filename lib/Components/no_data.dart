import 'package:c19/Utils/c19_colors.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {

  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      padding: EdgeInsets.all(10),
      child: const Text('No hay datos disponibles', style: TextStyle(color: C19Colors.leatherJacket, fontSize: 20, fontWeight: FontWeight.w500))
    );
  }

}