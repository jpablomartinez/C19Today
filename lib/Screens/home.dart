// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:c19/Classes/country.dart';
import 'package:c19/Components/info_country.dart';
import 'package:c19/Components/virus_animation.dart';
import 'package:c19/Controllers/sync_controller.dart';
import 'package:c19/Utils/c19_colors.dart';
import 'package:c19/Utils/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{

  const Home({Key? key}) : super(key: key);
  @override
  _Home createState()=> _Home();

}

class _Home extends State<Home> with SingleTickerProviderStateMixin{

  AnimationController? animationController;
  late Animation<double> animation;
  Future? loadData;
  SyncController syncController = SyncController();
  List<Country> countries = [];
  List<Widget> countriesWidget = [];
  final search = TextEditingController();
  var searchBy = SearchBy.amount;
  bool orderByDesc = true;
  bool orderByAlphabetAsc = false;

  void getInfoCountry(){
    int index = 1;
    List<Widget> list = [];
    for (var country in countries) {
      Widget infoCountry = InfoCountry(country: country, index: index);
      list.add(infoCountry);
      index++;
    }
    setState(() {
      countriesWidget = list;
    });
  }

  void sortCountriesByAmount(){
    if(!orderByDesc) countries.sort((a,b) => a.totalConfirmed.compareTo(b.totalConfirmed));
    else countries.sort((a,b) => b.totalConfirmed.compareTo(a.totalConfirmed));
    getInfoCountry();
  }

  void sortCountriesByAlphabet(){
    if(orderByAlphabetAsc) countries.sort((a,b) => a.name.compareTo(b.name));
    else countries.sort((a,b) => b.name.compareTo(a.name));
    getInfoCountry();
  }

  //TODO: reset countries list when search controller is empty
  void searchCountry(){
    if(search.text.length >= 3){
      List<Country> tmp = countries.where((element) => element.name.startsWith(search.text)).toList();
      int index = 1;
      List<Widget> list = [];
      for (var country in tmp) {
        Widget infoCountry = InfoCountry(country: country, index: index);
        list.add(infoCountry);
        index++;
      }
      setState(() {
        countriesWidget = list;
      });
    }
  }

  Future<bool> syncData() async {
    bool isConnected = await syncController.isConnected();
    if(isConnected){
      countries = await syncController.getConfirmedCasesAllCountries();
      countries.sort((a,b) => b.totalConfirmed.compareTo(a.totalConfirmed));
      if(countries.isNotEmpty){
        int index = 1;
        for (var country in countries) {
          Widget infoCountry = InfoCountry(country: country, index: index);
          countriesWidget.add(infoCountry);
          index++;
        }
      }
    }
    else if(isConnected && countries.isEmpty){}
    else if(!isConnected){}
    animationController!.forward();
    return Future.value(true);
  }

  @override
  void initState(){
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    animation = CurvedAnimation(parent: animationController!, curve: Curves.easeIn);
    loadData = syncData();
    super.initState();
  }

  @override
  void dispose(){
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return FadeTransition(
                opacity: animation,
                child: Container(
                    color:  C19Colors.panache,
                    width: double.infinity,
                    child: SafeArea(
                      child: Column(
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
                                  left: 30,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 220,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color(0xffC4C4C4).withOpacity(0.23)
                                  ),
                                  child: TextField(
                                    cursorColor: C19Colors.shamrock,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.search, color: const Color(0xff21232C).withOpacity(0.25))
                                    ),
                                    controller: search,
                                    onChanged: (value){
                                      searchCountry();
                                    },
                                  )
                              ),
                              IconButton(
                                  onPressed: (){
                                    setState(() {
                                      searchBy = SearchBy.amount;
                                      orderByDesc = !orderByDesc;
                                    });
                                    sortCountriesByAmount();
                                  },
                                  icon: orderByDesc ?
                                    Icon(Icons.arrow_downward, color: searchBy == SearchBy.amount ? C19Colors.shamrock : C19Colors.leatherJacket)
                                    :
                                    Icon(Icons.arrow_upward, color: searchBy == SearchBy.amount ? C19Colors.shamrock : C19Colors.leatherJacket)
                              ),
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      searchBy = SearchBy.alphabet;
                                      orderByAlphabetAsc = !orderByAlphabetAsc;
                                    });
                                    sortCountriesByAlphabet();
                                  },
                                  child: Text(orderByAlphabetAsc ? 'AZ' : 'ZA', style: TextStyle(color: searchBy == SearchBy.alphabet ? C19Colors.shamrock : C19Colors.leatherJacket, fontSize: 19, fontWeight: FontWeight.w500))
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                              flex: 1,
                              child: ListView(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  children: countriesWidget
                              )
                          )
                        ],
                      ),
                    )
                )
            );
          }
          else {
            return Center(
              child: SizedBox(
                height: 350,
                width: double.infinity,
                child: Column(
                  children: const [
                    VirusAnimation(),
                    SizedBox(
                        height: 30,
                        child: Text('Obteniendo datos', style: TextStyle(color: C19Colors.leatherJacket, fontSize: 15, fontWeight: FontWeight.w300))
                    ),
                  ],
                ),
              ),
            );
          }
        },
      )
    );
  }

}