import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:qrbats_sp/pages/main_pages/main_page.dart';
import 'package:qrbats_sp/pages/starting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(MyApp(token: preferences.getString("token"),));
}

class MyApp extends StatelessWidget {
  final String? token;

  MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sky Ticker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) {
            if (token != null && !JwtDecoder.isExpired(token!)) {
              return MainPage(token: token!);
            } else {
              return StartingPage();
            }
          },
        },
      ),
    );
  }
}
