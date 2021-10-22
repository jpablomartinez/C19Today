class Country {

  String name = '';
  String countryCode = '';
  int totalConfirmed = 0;
  int newConfirmed = 0;
  int newDeaths = 0;
  int totalDeaths = 0;
  int newRecovered = 0;
  int totalRecovered = 0;

  Country({
    required this.name,
    required this.countryCode,
    required this.totalConfirmed,
    required this.newConfirmed,
    required this.newDeaths,
    required this.newRecovered,
    required this.totalDeaths,
    required this.totalRecovered
  });

  factory Country.fromJson(Map<String, dynamic> json){
    try{
      return Country(
        name: json['Country'] ?? 'No named',
        countryCode: json['CountryCode'] ?? '',
        totalConfirmed: json['TotalConfirmed'] ?? 0,
        newConfirmed: json['NewConfirmed'] ?? 0,
        newDeaths: json['NewDeaths'] ?? 0,
        newRecovered: json['NewRecovered'] ?? 0,
        totalDeaths: json['TotalDeaths'] ?? 0,
        totalRecovered: json['TotalRecovered'] ?? 0
      );
    }
    catch(e,s){
      return Country(name: '', countryCode: '', totalConfirmed: 0, newConfirmed: 0, newDeaths: 0, newRecovered: 0, totalRecovered: 0, totalDeaths: 0);
    }
  }

}