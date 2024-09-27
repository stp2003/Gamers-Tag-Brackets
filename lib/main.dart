import 'package:flutter/material.dart';
import 'package:gamers_tag/screen/bracket_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Tournament Bracket',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            primaryColor: Colors.red,
            scaffoldBackgroundColor: Colors.black,
          ),
          home: const BracketScreen(),
        );
      },
    );
  }
}
