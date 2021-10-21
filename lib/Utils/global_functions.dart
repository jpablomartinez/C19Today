class GlobalFunctions {

  static String parseCountryName(String name){
    return name.length > 18 ? '${name.substring(0,18)}...' : name;
  }

}