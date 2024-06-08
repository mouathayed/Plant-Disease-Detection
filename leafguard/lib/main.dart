import 'package:flutter/material.dart';
import 'predict.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Disease Detection',
      theme: ThemeData(
        primaryColor: const Color(0xFF8BC34A),
        scaffoldBackgroundColor: const Color(0xFF8BC34A),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          headline6: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.blueGrey),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8BC34A),
          elevation: 0,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF5FA709)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(const Color(
                0xFF5CAB00)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const PredictPage(),
    );
  }
}
