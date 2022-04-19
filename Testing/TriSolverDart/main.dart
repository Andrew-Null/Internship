// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types, unused_import
/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/Screens.dart';
//import 'Common/Numpad.dart';



SOptions screen = SOptions.MM;


late _MyHomePageState app;

void main() {
	runApp(const MyApp());
}

class MyApp extends StatelessWidget {
	const MyApp({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Internship App',
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
				primarySwatch: Colors.blue,
				//scaffoldBackgroundColor: Color
				//(0xFF101010)
			),
			home: const MyHomePage(title: 'Internship App Home'),
		);
	}
}

class MyHomePage extends StatefulWidget {
	const MyHomePage({Key? key, required this.title}) : super(key: key);
	final String title;

	@override
	State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
}

*/

import 'Geometry/Side.dart' as Side;
import 'Geometry/Angle.dart' as Ang;
import 'Geometry/Triangle/Laws.dart' as Laws;
import 'Geometry/Geometry.dart';
import 'dart:math';
void main()
{
  Side.Side a = Side.Side(6);
  Ang.Degree A = Ang.Degree(30);
  //print(Ang.Degree(120).Cosine());
  print(((Laws.LDC(a, Side.Side(4), Side.Side(8))) as Ang.Radian).value.toString());
  //print(z.side.toString());
  //print(Laws.LDS(a,A).GetSide(Ang.Degree(120)).length.toString());
  //print(A.Sine());
}
