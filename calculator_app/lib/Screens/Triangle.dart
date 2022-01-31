 // ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables

 import 'package:flutter/material.dart';
 import 'Menus/MMenu.dart';



Scaffold TriSolver()
{
	// ignore: prefer_const_constructors
	return Scaffold(body: 
		Column(children: 
			[
				const TextField(keyboardType: TextInputType.number),
				MMB()
			]
		)
	);
}