import 'package:ai_with_flutter/ai_with_html.dart';
import 'package:ai_with_flutter/simple_chat_example.dart';
import 'package:ai_with_flutter/text_recognition_screen.dart';

import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const AIWithHtml(),
    );
  }
}
