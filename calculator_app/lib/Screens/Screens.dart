// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import '../main.dart';
import 'Integer.dart';
import 'Menus/MMenu.dart';

enum SOptions //screen options
{
	//GeometryMS, //also going to need this later
	IntegerCS,
	MM //main menu
}

Scaffold ChooseScreen(BuildContext context)
{
	switch(screen)
	{
		case SOptions.IntegerCS:
		{
			return IntCalc(context);
		} 
		case SOptions.MM:
		{
			return MainMenu(context);
		}
	}
}


