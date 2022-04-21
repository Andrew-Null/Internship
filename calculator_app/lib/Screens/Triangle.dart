 // ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables

 import 'package:flutter/material.dart';
 import 'Menus/MMenu.dart';
 import '../main.dart';

//Contollers
TextEditingContoller _AngA = TextEditingContoller();
TextEditingContoller _AngB = TextEditingContoller();
TextEditingContoller _AngC = TextEditingContoller();

TextEditingContoller _aSide = TextEditingContoller();
TextEditingContoller _bSide = TextEditingContoller();
TextEditingContoller _cSide = TextEditingContoller();

//TextEditingController _controller = TextEditingController();

TextField TxtBoxGen(String label, Function cambiar, TextEditingController cntrllr) 
{
  //app.Refresh;
  return TextField
  (
    keyboardType: TextInputType.number,
    onChanged: cambiar(),
    decoration: InputDecoration
    (
      border: const OutlineInputBorder(),
      labelText: label,
    ),
    controller: cntrllr,
  );
}

Column? AngleTextBoxes() {} //temporarily nullable


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
