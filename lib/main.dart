import 'package:flutter/material.dart';
import 'package:pgdekho/screen/Auth/Otp.dart';
import 'package:pgdekho/screen/Auth/login.dart';
import 'package:pgdekho/screen/onbordingScreen/onbordingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PG Dekho',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,

        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
          background: Colors.white,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),

      home: MyOnboardingScreen(),
      routes: {
        '/onboarding': (context) => MyOnboardingScreen(),
        '/login': (context) =>  LoginScreen(),
        '/otp': (context) => MyOtpScreen(),
      },
    );
  }
}
