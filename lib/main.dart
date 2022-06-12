import 'dart:async';
import 'dart:developer';
import 'package:dog_app/Screens/LoginScreen.dart';
import 'package:dog_app/Database/Database.dart';
import 'package:dog_app/Screens/MyHomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_indicators/progress_indicators.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 233, 237, 241),
        primaryColor: Colors.amber,
      ),
      home: SplashhScreen(),
    );
  }
}

class SplashhScreen extends StatefulWidget {
  const SplashhScreen({Key? key}) : super(key: key);

  @override
  _SplashhScreenState createState() => _SplashhScreenState();
}

class _SplashhScreenState extends State<SplashhScreen> {
  var _databaseprovider;

  @override
  void initState() {
    super.initState();
    _databaseprovider = Databaseprovider.instance;
    Timer(
      Duration(seconds: 3),
      () => autoLogin(),
    );
  }

  void autoLogin() async {
    var currentUser = await _databaseprovider.checkCurrentSession();
    log('curent user: $currentUser');
    if (currentUser != Null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Student Management'),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: new AssetImage("images/new3.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CollectionScaleTransition(
                  children: <Widget>[
                    Icon(Icons.pets, color: Colors.white),
                    SizedBox(width: 3),
                    Icon(Icons.workspaces_outline, color: Colors.white),
                    SizedBox(width: 3),
                    Icon(Icons.pets, color: Colors.white),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                ScalingText(
                  'Loading Please Wait...',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Times New Roman',
                    fontSize: 25.0,
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        offset: Offset(3, 2),
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
