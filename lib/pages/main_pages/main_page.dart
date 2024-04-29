import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:qrbats_sp/pages/getStart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_page_contents/home_page.dart';
import 'main_page_contents/history_page.dart';
import 'main_page_contents/qr_scan_page.dart';
import 'main_page_contents/setting_page.dart';


class MainPage extends StatefulWidget {
  final int pageIndex;
  final String token;
  const MainPage({Key? key, this.pageIndex=1, this.token = ""}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  late String userName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userName = jwtDecodedToken["studentName"];
    _currentIndex = widget.pageIndex;
  }

  void _logout() async {
    // Clear the authentication token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    // Navigate to the starting page (login page)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OpennigPage()),
    );
  }

  @override
  Widget build(BuildContext context) {

    // Add your other pages to this list
    List<Widget> pages = [
      Home(),
      QRCodeScan(token: widget.token,),
      HistoryPage(token: widget.token,),
      SettingPage()
      // Add more pages as needed
    ];

    return WillPopScope(
      onWillPop: () async {
        // Disable back button
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Sky Ticker",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF086494),
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Color(0xFF086494),
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          actions: [
            IconButton(
              onPressed: _logout,
              icon: Icon(
                Icons.logout,
                color: Color(0xFF086494),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF086494),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sky Ticker',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),

              ListTile(
                leading: Icon(Icons.account_circle,color: Color(0xFF086494),size: 35,),
                title: Text('Profile',style: TextStyle(color: Color(0xFF086494),fontSize: 20),),
                onTap: () {
                  // Handle drawer item 1
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage(pageIndex: 3,token: widget.token,)),
                  );
                  // Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.settings,color: Color(0xFF086494),size: 35,),
                title: Text('Settings',style: TextStyle(color: Color(0xFF086494),fontSize: 20),),
                onTap: () {
                  // Handle drawer item 2
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage(pageIndex: 3,token: widget.token,)),
                  );
                  //Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.logout,color: Color(0xFF086494),size: 35,),
                title: Text('Logout',style: TextStyle(color: Color(0xFF086494),fontSize: 20)),
                onTap: _logout,
              ),
              // Add more list items as needed
            ],
          ),
        ),
        endDrawer: Drawer(
          // Add content for endDrawer
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Color(0xFF086494),
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'QR-Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),

            /*BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Shedule',
            ),*/
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        body:pages[_currentIndex],

      ),
    );
  }
}
