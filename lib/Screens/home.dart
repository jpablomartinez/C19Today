// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:c19/Classes/country.dart';
import 'package:c19/Components/greetings.dart';
import 'package:c19/Components/info_country.dart';
import 'package:c19/Components/no_data.dart';
import 'package:c19/Components/virus_animation.dart';
import 'package:c19/Controllers/data_controller.dart';
import 'package:c19/Controllers/sync_controller.dart';
import 'package:c19/Utils/c19_colors.dart';
import 'package:c19/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget{

  const Home({Key? key}) : super(key: key);
  @override
  _Home createState()=> _Home();

}

class _Home extends State<Home> with SingleTickerProviderStateMixin{

  final dataController = Get.put(DataController());
  AnimationController? animationController;
  late Animation<double> animation;
  Future? loadData;
  SyncController syncController = SyncController();
  final search = TextEditingController();


  Future<bool> syncData() async {
    bool isConnected = await syncController.isConnected();
    if(isConnected){
      dataController.countries = await syncController.getConfirmedCasesAllCountries();
      if(dataController.countries.isNotEmpty){
        dataController.foundedData = true;
        dataController.countries.sort((a,b) => b.totalConfirmed.compareTo(a.totalConfirmed));
        dataController.getInfoCountry();
      }
    }
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
                          const Greetings(),
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
                                      dataController.searchCountry(value);
                                    },

                                  )
                              ),
                              IconButton(
                                  onPressed: ()=> dataController.updateSearchByAmount(),
                                  icon: GetBuilder<DataController>(
                                    builder: (_) =>
                                      dataController.orderByDesc ?
                                      Icon(Icons.arrow_downward, color: dataController.searchBy == SearchBy.amount ? C19Colors.shamrock : C19Colors.leatherJacket)
                                      :
                                      Icon(Icons.arrow_upward, color: dataController.searchBy == SearchBy.amount ? C19Colors.shamrock : C19Colors.leatherJacket)
                                  )
                              ),
                              GestureDetector(
                                  onTap: () => dataController.updateSearchByAlphabet(),
                                  child: GetBuilder<DataController>(
                                    builder: (_) =>
                                        Text(
                                            dataController.orderByAlphabetAsc ? 'AZ' : 'ZA',
                                            style: TextStyle(color: dataController.searchBy == SearchBy.alphabet ? C19Colors.shamrock : C19Colors.leatherJacket, fontSize: 19, fontWeight: FontWeight.w500)
                                        ),
                                  )
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          dataController.foundedData ?
                          Expanded(
                              flex: 1,
                              child: GetBuilder<DataController>(
                                builder: (_) =>
                                    ListView(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                        children: dataController.countriesWidget
                                    )
                              )
                          )
                          :
                          const NoData()
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