// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types, unused_import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'List/CList.dart';
import 'Screens/Screens.dart';

SOptions screen = SOptions.HomeS;


late _MyHomePageState app;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EPICS App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'EPICS App Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final GlobalKey<FormState> FKey = GlobalKey<FormState>();
  //final TController = TextEditingController();
  @override
  Widget build(BuildContext context) 
  {
    app = this;
    return ChooseScreen(context);
  }

  get Refresh
  {
    setState(() {});
  }

  /*get GControl //get 
  {
    return TController;
  }*/
}
