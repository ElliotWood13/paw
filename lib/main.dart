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
            labelLarge: TextStyle(fontSize: 16, color: Colors.black),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Color.fromRGBO(228, 239, 224, 1);
                }
                return Color.fromRGBO(177, 255, 158, 1);
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey[700];
                }
                return Colors.black;
              }),
              padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 32)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.black,
                  width: 3,
                ),
              )),
              elevation: WidgetStateProperty.all(0),
            ),
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}
