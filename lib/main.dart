import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'price_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BITCOIN TICKER',
        theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF81A86F),
        scaffoldBackgroundColor: Colors.grey.shade300,
        appBarTheme: AppBarTheme(
            color: Color(0xFF81A86F),
            //for status bar
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xFF81A86F),
                systemNavigationBarColor: Color(0xFF81A86F)
            )
          ),
        ),
      home: PriceScreen()
    );
  }
}


