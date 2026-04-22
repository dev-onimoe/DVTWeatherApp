import 'package:flutter/material.dart';
import 'package:flutter_assessment/mvvm/views/screens/main_screen.dart';

import 'app_dependencies.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = AppDependencies.createForecastBloc();

    return MaterialApp(
      home: MainScreen(bloc: bloc),
    );
  }
}
