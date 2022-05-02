// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import '../main.dart' as main;
import 'Integer.dart' as Int;
import 'Menus/MMenu.dart' as MM;
import 'Triangle.dart' as Tri;

enum SOptions //screen options
{
	//GeometryMS, //also going to need this later
	TriSolverS,
	IntegerCS,
	MM //main menu
}

Scaffold ChooseScreen(BuildContext context)
{
	switch(main.screen)
	{
		case SOptions.IntegerCS:
		{
			return Int.IntCalc(context);
		} 
		case SOptions.MM:
		{
			return MM.MainMenu(context);
		}
		case SOptions.TriSolverS:
		{
			return Tri.TriSolver(context);
		}
	}
}


