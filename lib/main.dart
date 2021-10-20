import 'package:c19/Utils/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const C19());
}

class C19 extends StatelessWidget {
  const C19({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'C19 Today',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
