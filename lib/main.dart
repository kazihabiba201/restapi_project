import 'package:flutter/material.dart';
import 'package:restapi_project/screen/product_create_screen.dart';
import 'package:restapi_project/screen/product_gridview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD App',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductGridViewScreen()
    );
  }
}

