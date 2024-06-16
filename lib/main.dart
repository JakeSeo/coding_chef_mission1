import 'package:flutter/material.dart';

import 'views/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Coding Chef Mission1',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff9c27b0)),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xffe0e0e0),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
