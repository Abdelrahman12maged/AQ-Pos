import 'package:aq_pos/WebView.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:
            AppBarTheme(backgroundColor: Color.fromARGB(255, 29, 56, 71)!),
        useMaterial3: true,
      ),
      home: WebViewAqPos(),
    );
  }
}
