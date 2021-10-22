// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:c19/Classes/country.dart';
import 'package:c19/Components/info_country.dart';
import 'package:c19/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataController extends GetxController {

  List<Country> countries = [];
  List<Widget> countriesWidget = [];
  List<Widget> auxCountries = [];
  bool orderByDesc = true;
  bool orderByAlphabetAsc = false;
  bool foundedData = false;
  var searchBy = SearchBy.amount;
  Country? country;

  ///Go to Country Details Screen
  void selectCountry(Country c){
    country = c;
    Get.toNamed('/summary');
  }

  ///Function to find countries on list
  void searchCountry(String text){
    List<Country> tmp = countries.where((element) => element.name.toLowerCase().startsWith(text.toLowerCase())).toList();
    int index = 1;
    List<Widget> list = [];
    for (var country in tmp) {
      Widget infoCountry = InfoCountry(country: country, index: index, selectFunction: ()=> selectCountry(country));
      list.add(infoCountry);
      index++;
    }
    countriesWidget = list;
    update();
  }

  ///Function to create Widget for Countries list
  void getInfoCountry(){
    countriesWidget.clear();
    int index = 1;
    List<Widget> list = [];
    for (var country in countries) {
      Widget infoCountry = InfoCountry(country: country, index: index, selectFunction: ()=> selectCountry(country));
      list.add(infoCountry);
      index++;
    }
    countriesWidget = list;
    update();
  }

  ///Sort countries by confirmed cases (asc or desc)
  void sortCountriesByAmount(){
    if(!orderByDesc) countries.sort((a,b) => a.totalConfirmed.compareTo(b.totalConfirmed));
    else countries.sort((a,b) => b.totalConfirmed.compareTo(a.totalConfirmed));
    getInfoCountry();
  }

  ///Sort countries by alphabet (A-Z or Z-A)
  void sortCountriesByAlphabet(){
    if(orderByAlphabetAsc) countries.sort((a,b) => a.name.compareTo(b.name));
    else countries.sort((a,b) => b.name.compareTo(a.name));
    getInfoCountry();
  }

  ///Select search by alphabet
  void updateSearchByAlphabet(){
    if(searchBy != SearchBy.alphabet) searchBy = SearchBy.alphabet;
    orderByAlphabetAsc = !orderByAlphabetAsc;
    sortCountriesByAlphabet();
    update();
  }

  ///Select search by confirmed cases
  void updateSearchByAmount(){
    if(searchBy != SearchBy.amount) searchBy = SearchBy.amount;
    orderByDesc = !orderByDesc;
    sortCountriesByAmount();
    update();
  }

}