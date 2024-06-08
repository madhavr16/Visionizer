import 'package:flutter/material.dart';
import 'package:visionizer/feature/prompt/ui/create_prompt_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          elevation: 0,
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const CreatePromptScreen(),
    );
  }
}

