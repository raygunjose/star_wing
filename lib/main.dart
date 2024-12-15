import 'package:flutter/material.dart';
import 'menu_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RrOoMmSs',
      // home: PropertyTypes(),
      home: MenuListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
