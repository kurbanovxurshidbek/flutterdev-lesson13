import 'package:flutter/material.dart';
import 'package:ngdemo12/pages/home_page.dart';
import 'package:ngdemo12/service/hive_service.dart';
import 'package:ngdemo12/service/root_service.dart';
import 'package:ngdemo12/service/sql_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await RootService.init();

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

