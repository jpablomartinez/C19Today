import 'package:c19/Components/country_summary.dart';
import 'package:c19/Controllers/data_controller.dart';
import 'package:c19/Utils/c19_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryDetails extends StatefulWidget{
  const CountryDetails({Key? key}) : super(key: key);
  @override
  _CountryDetails createState()=> _CountryDetails();

}

class _CountryDetails extends State<CountryDetails> {

  final DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: C19Colors.leatherJacket,
        title: const Text('Resumen', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
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
                    children: [
                      Text(dataController.country!.name, style: const TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold)),
                      const Text('Last updated: one minute ago', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400)),
                    ],
                  ),
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
          ),
          const SizedBox(height: 10),
          Expanded(
              flex: 1,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CountrySummary(title: 'nuevos casos', amount: dataController.country!.newConfirmed, color: dataController.country!.newConfirmed > 0 ? C19Colors.punch : C19Colors.royalBlue),
                      CountrySummary(title: 'total casos', amount: dataController.country!.totalConfirmed, color: dataController.country!.totalConfirmed > 0 ? C19Colors.punch : C19Colors.royalBlue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CountrySummary(title: 'nuevos recuperados', amount: dataController.country!.newRecovered, color: dataController.country!.newRecovered > 0 ? C19Colors.royalBlue : C19Colors.punch),
                      CountrySummary(title: 'total recuperados', amount: dataController.country!.totalRecovered, color: dataController.country!.totalRecovered > 0 ? C19Colors.royalBlue : C19Colors.punch),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CountrySummary(title: 'muertos de ayer', amount: dataController.country!.newDeaths, color: dataController.country!.newDeaths > 0 ? C19Colors.punch : C19Colors.royalBlue),
                      CountrySummary(title: 'total de muertes', amount: dataController.country!.totalDeaths, color: dataController.country!.totalDeaths > 0 ? C19Colors.punch : C19Colors.royalBlue),
                    ],
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

}