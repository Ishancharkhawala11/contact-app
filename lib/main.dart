import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:practise/Pages/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practise/Pages/Home.dart';
import 'package:practise/Pages/Login.dart';
import 'package:practise/Pages/Sign_up.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.soraTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade800),
        useMaterial3: true,
      ),
      routes: {
        "/":(context)=>CheckLoging(),
        "/home":(context)=>Home(),
        "/signUp":(context)=>Sign_up(),
        "/login":(context)=>Login()
      },
    );
  }
}

