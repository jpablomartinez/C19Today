import 'package:c19/Classes/country.dart';
import 'package:c19/Components/info_country.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{

  const Home({Key? key}) : super(key: key);
  @override
  _Home createState()=> _Home();

}

class _Home extends State<Home> with SingleTickerProviderStateMixin{

  //AnimationController animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
  //Animation? animation;
  //Future? loadData;

  InfoCountry infoCountry = InfoCountry(country: Country(name: 'Chile', total: 10000), index: 1);

  @override
  void initState(){
    //animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    //animation = CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    super.initState();
  }

  @override
  void dispose(){
    //animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            infoCountry
          ],
        ),
      )
    );
  }

}