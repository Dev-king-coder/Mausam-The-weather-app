import 'package:flutter/material.dart';
import 'package:mausam/screens/auth_screen.dart';

// Make a weather app using the OpenWeatherMap API,
// that asks the user for their location and displays the current weather.
// The app has a button that allows user to add a new location.
// Integrate google-sign-in packages to allow user to sign in with their google account.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mausam',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
        ),
      ),
      home: const AuthScreen(),
    );
  }
}
