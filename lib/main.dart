import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animations_menu/menu_dashboard_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const Color backgroundColor = Color(0xFF343442);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: backgroundColor, 
  ));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (value) {
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: const MenuDashboard(),
    );
  }
}
