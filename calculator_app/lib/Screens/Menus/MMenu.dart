// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../../main.dart';
import '../Screens.dart';

TextButton MMB() //main menu button 
{//likely to be used on most screens as a home button
	void RetMain() //return to main menu
	{
		screen = SOptions.MM;
		app.Refresh;
	}

	return TextButton
	(
		child: Text("Main Menu"),
		onPressed: () {RetMain();}
	);
}

TextButton SimICalc() //simple int calculator
{
	return TextButton
	(
		child: const Text("Integer Calculator"), 
		onPressed: () 
		{
			screen = SOptions.IntegerCS;
			app.Refresh;
		}
	);
}

TextButton TSButton() //triangle solver button
{
	return TextButton
	(
		child: const Text("Triangle Solver"),
		onPressed: ()
		{
			screen = SOptions.TriSolverS;
			app.Refresh;
		}
	);
}

Scaffold MainMenu(BuildContext context)
{
	return Scaffold
	(
		body: Center(child: Column(children:
		[
			const Text("Main Menu"),
			Row(children: [SimICalc(), TSButton()])
		]),
	));
}
