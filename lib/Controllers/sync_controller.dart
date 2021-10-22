// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:c19/Classes/country.dart';
import 'package:c19/Utils/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class SyncController {

  ///Checks if mobile is connected to wifi or mobile data
  Future<bool> isConnected() async{
    var conn = await Connectivity().checkConnectivity();
    if(conn == ConnectivityResult.mobile || conn == ConnectivityResult.wifi) return checkConnection();
    else return false;
  }

  ///Checks if device can use internet
  Future<bool> checkConnection() async {
    bool hasConn = false;
    try{
      final res = await InternetAddress.lookup('www.google.com');
      if(res.isNotEmpty && res[0].rawAddress.isNotEmpty) hasConn = true;
    } on SocketException catch(_){
      hasConn = false;
    }
    return hasConn;
  }

  ///Function to get JSON with confirmed cases and other stuffs for all countries
  Future<List<Country>> getConfirmedCasesAllCountries() async{
    List<Country> countries = [];
    try{
      Dio dio = Dio();
      Response response = await dio.get(Routes.getSummary).timeout(const Duration(seconds: 15));
      if(response.statusCode == 200 && response.data.isNotEmpty){
        response.data['Countries'].forEach((c){
          countries.add(Country.fromJson(c));
        });
      }
      return countries;
    }
    catch(e,s){
      return countries;
    }
  }


}