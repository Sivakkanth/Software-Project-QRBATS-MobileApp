import 'package:flutter/material.dart';
import 'package:qrbats_sp/pages/starting_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/', // Set initialRoute to '/'
        routes: {
          '/': (context) => StartingPage(), // Map '/' to LoginPage
          // Add more routes here if needed
        },
      ),
    );
  }
}
