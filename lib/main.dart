import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_asst/widgets/bottom_nav_bar.dart';
import 'package:travel_asst/screens/login_screen.dart';

import 'package:firebase_core/firebase_core.dart';  //firebase

void main() async {

  //WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();                  //firebase

  final prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(TravelGuideApp(isLoggedIn: isLoggedIn));
}

class TravelGuideApp extends StatelessWidget {
  final bool isLoggedIn;
  const TravelGuideApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const BottomNavBar() : LoginScreen(),
    );
  }
}
