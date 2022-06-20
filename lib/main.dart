import 'package:flutter/material.dart';
import 'package:test_dicoding/screens/home.dart';

void main() {
  runApp(const MyApp());
}

// My Inspiration
// Thanks Allaam Naufal ( teman satu pondok seorang ui/ux )
// https://dribbble.com/shots/12028424-Breathe-App/attachments/3657954?mode=media

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test dicoding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(39, 174, 96, 1),
        backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      ),
      home: const Home(),
    );
  }
}
