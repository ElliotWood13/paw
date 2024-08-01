import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'state/my_app_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Paw',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromRGBO(254, 201, 255, 1)),
          textTheme: TextTheme(
            bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
            labelLarge: TextStyle(
                fontSize: 16,
                color: Colors.black), // Default text style for buttons
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}
